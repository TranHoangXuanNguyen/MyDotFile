#!/usr/bin/env python3
"""Translate legacy IPC used by these dotfiles to Hyprland's native Lua API.

Only used by the Lua session (its PATH prepends hypr/bin). The real hyprctl
continues to handle queries, reload, eval and already-native dispatch calls.
"""
import json
import os
import re
import sys

REAL_HYPRCTL = '/usr/bin/hyprctl'


def quote(value):
    return json.dumps(value, ensure_ascii=False)


def scalar(value):
    if value in ('true', 'on', 'yes'):
        return 'true'
    if value in ('false', 'off', 'no'):
        return 'false'
    if re.fullmatch(r'-?\d+(\.\d+)?', value):
        return value
    return quote(value)


def table(**fields):
    return '{ ' + ', '.join(k + ' = ' + v for k, v in fields.items()) + ' }'


def dispatch(name, arg=''):
    """Return a dispatcher expression; never execute it while translating."""
    plain = {
        'killactive': 'window.close', 'forcekillactive': 'window.kill',
        'togglefloating': 'window.float', 'pseudo': 'window.pseudo',
        'togglegroup': 'group.toggle', 'bringactivetotop': 'window.bring_to_top',
        'exit': 'exit', 'togglesplit': None,
    }
    if name in plain:
        if name == 'togglesplit':
            return 'hl.dsp.layout("togglesplit")'
        return 'hl.dsp.' + plain[name] + '()'
    if name in ('exec', 'execr', 'layoutmsg', 'global', 'submap'):
        fn = {'exec': 'exec_cmd', 'execr': 'exec_raw', 'layoutmsg': 'layout'}.get(name, name)
        return 'hl.dsp.' + fn + '(' + quote(arg) + ')'
    if name == 'fullscreen':
        return 'hl.dsp.window.fullscreen(' + table(mode=quote('maximized' if arg == '1' else 'fullscreen')) + ')'
    if name == 'workspace':
        return 'hl.dsp.focus(' + table(workspace=quote(arg)) + ')'
    if name in ('movetoworkspace', 'movetoworkspacesilent'):
        workspace, _, window = arg.partition(',')
        opts = dict(workspace=quote(workspace), follow=str(name == 'movetoworkspace').lower())
        if window:
            opts['window'] = quote(window)
        return 'hl.dsp.window.move(' + table(**opts) + ')'
    if name == 'togglespecialworkspace':
        return 'hl.dsp.workspace.toggle_special(' + quote(arg) + ')'
    if name in ('movefocus', 'movewindow', 'swapwindow', 'moveintogroup'):
        direction = {'l': 'left', 'r': 'right', 'u': 'up', 'd': 'down'}.get(arg, arg)
        fn = {'movefocus': 'focus', 'movewindow': 'window.move', 'swapwindow': 'window.swap', 'moveintogroup': 'window.move'}[name]
        field = 'into_group' if name == 'moveintogroup' else 'direction'
        return 'hl.dsp.' + fn + '({ ' + field + ' = ' + quote(direction) + ' })'
    if name == 'moveoutofgroup':
        return 'hl.dsp.window.move({ out_of_group = true })'
    if name == 'movecurrentworkspacetomonitor':
        return 'hl.dsp.workspace.move(' + table(monitor=quote(arg)) + ')'
    if name == 'changegroupactive':
        return 'hl.dsp.group.' + ('prev' if arg == 'b' else 'next') + '()'
    if name == 'cyclenext':
        return 'hl.dsp.window.cycle_next({ next = ' + str(arg not in ('prev', 'p')).lower() + ' })'
    if name in ('resizeactive', 'moveactive', 'resizewindowpixel', 'movewindowpixel'):
        vector, _, window = arg.partition(',')
        exact = vector.startswith('exact ')
        if exact:
            vector = vector[6:]
        x, y = map(float, vector.split())
        opts = dict(x=str(x), y=str(y), relative=str(not exact).lower())
        if window:
            opts['window'] = quote(window)
        fn = 'resize' if name.startswith('resize') else 'move'
        return 'hl.dsp.window.' + fn + '(' + table(**opts) + ')'
    if name in ('focuswindow', 'focusmonitor'):
        return 'hl.dsp.focus(' + table(**{'window' if name == 'focuswindow' else 'monitor': quote(arg)}) + ')'
    if name in ('pin', 'setfloating', 'settiled'):
        opts = {}
        if arg:
            opts['window'] = quote(arg)
        if name != 'pin':
            opts['action'] = quote('set' if name == 'setfloating' else 'unset')
        return 'hl.dsp.window.' + ('pin' if name == 'pin' else 'float') + '(' + table(**opts) + ')'
    if name == 'setprop':
        window, prop, value = arg.split(' ', 2)
        return 'hl.dsp.window.set_prop(' + table(window=quote(window), prop=quote(prop), value=quote(value)) + ')'
    if name == 'splitratio':
        return 'hl.dsp.layout(' + quote('splitratio ' + arg) + ')'
    if name == 'dpms':
        action, _, monitor = arg.partition(' ')
        opts = dict(action=quote({'on': 'set', 'off': 'unset'}.get(action, action)))
        if monitor:
            opts['monitor'] = quote(monitor)
        return 'hl.dsp.dpms(' + table(**opts) + ')'
    if name == 'workspaceopt' and arg == 'allfloat':
        # This is a callback rather than a dispatcher object.
        return 'function() hypr_dots.float_workspace() end'
    raise ValueError('Unsupported legacy dispatcher: ' + name)


def config_option(key, value):
    value = scalar(value)
    if ':col.' in key:
        text = json.loads(value)
        parts = text.split()
        angle = parts.pop() if parts and parts[-1].endswith('deg') else '0deg'
        value = '{ colors = {' + ', '.join(quote(p) for p in parts) + '}, angle = ' + angle[:-3] + ' }'
    keys = key.replace(':', '.').split('.')
    for part in reversed(keys):
        value = '{ [' + quote(part) + '] = ' + value + ' }'
    return 'hl.config(' + value + ')'


def keyword(name, arg):
    if name == 'unbind':
        mods, key = map(str.strip, arg.split(',', 1))
        return 'hl.unbind(' + quote(' + '.join(mods.split() + [key])) + ')'
    if name.startswith('bind'):
        flags = name[4:]
        parts = [p.strip() for p in arg.split(',', 4 if 'd' in flags else 3)]
        mods, key = parts[:2]
        desc = parts.pop(2) if 'd' in flags else None
        opts = {long: 'true' for short, long in [('e', 'repeating'), ('l', 'locked'), ('r', 'release'), ('n', 'non_consuming')] if short in flags}
        if desc:
            opts['description'] = quote(desc)
        return 'hl.bind(' + quote(' + '.join(mods.split() + [key])) + ', ' + dispatch(parts[2], parts[3] if len(parts) > 3 else '') + ', ' + table(**opts) + ')'
    if name.startswith('device:'):
        device, field = name[7:].rsplit(':', 1)
        return 'hl.device(' + table(name=quote(device), **{field: scalar(arg)}) + ')'
    if ':' in name:
        return config_option(name, arg)
    raise ValueError('Unsupported legacy keyword: ' + name + '; use native Lua for this operation')


def translate(args):
    # Global refresh flags may appear after the keyword's value in old scripts.
    trailing_flags = [s for s in args[1:] if s in ('-r', '-j', '--quiet', '-q')]
    if trailing_flags:
        args = trailing_flags + [args[0]] + [s for s in args[1:] if s not in trailing_flags]
    index = next((i for i, s in enumerate(args) if s in ('dispatch', 'keyword', '--batch')), None)
    if index is None:
        return args
    command = args[index]
    if command == '--batch':
        statements = []
        for item in ' '.join(args[index + 1:]).split(';'):
            item = item.strip()
            if not item:
                continue
            name, _, rest = item.partition(' ')
            if name not in ('keyword', 'dispatch'):
                raise ValueError('Unsupported batch command: ' + name)
            sub = translate([name] + rest.split(' ', 1))
            statements.append('hl.dispatch(' + sub[1] + ')' if sub[0] == 'dispatch' else sub[1])
        return args[:index] + ['eval', '; '.join(statements)]
    rest = args[index + 1:]
    if not rest:
        return args
    if command == 'dispatch' and rest[0].startswith('hl.'):
        return args
    # Also accept the single quoted argument used by some upstream scripts.
    name, sep, tail = rest[0].partition(' ')
    arg = ' '.join(([tail] if sep else []) + rest[1:])
    if command == 'dispatch':
        expr = dispatch(name, arg)
        code = 'hl.dispatch(' + expr + ')'
    else:
        code = keyword(name, arg)
    return args[:index] + ['eval', code]


def main():
    try:
        args = translate(sys.argv[1:])
    except (ValueError, IndexError) as error:
        print('hyprctl Lua compatibility: ' + str(error), file=sys.stderr)
        return 2
    os.execv(REAL_HYPRCTL, [REAL_HYPRCTL] + args)


if __name__ == '__main__':
    sys.exit(main())
