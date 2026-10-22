#!/usr/bin/env python3
"""Validate native config, runtime actions and legacy IPC with real Hyprland.

Uses --verify-config only. Does not reload or start a compositor session.
"""
import importlib.util
import os
from pathlib import Path
import subprocess
import tempfile
import re
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('hypr_ipc', ROOT / 'scripts/hypr_ipc.py')
ipc = importlib.util.module_from_spec(spec)
spec.loader.exec_module(ipc)


class Translation(unittest.TestCase):
    def test_workspace_and_window_targets(self):
        self.assertEqual(ipc.translate(['dispatch', 'workspace', 'e+1']), ['eval', 'hl.dispatch(hl.dsp.focus({ workspace = "e+1" }))'])
        result = ipc.translate(['dispatch', 'movetoworkspacesilent', 'special:scratchpad,address:0x123'])[-1]
        self.assertIn('follow = false', result)
        self.assertIn('window = "address:0x123"', result)

    def test_drag_coordinates(self):
        absolute = ipc.dispatch('movewindowpixel', 'exact 12 34,address:0x123')
        relative = ipc.dispatch('resizeactive', '-50 0')
        self.assertIn('relative = false', absolute)
        self.assertIn('window = "address:0x123"', absolute)
        self.assertIn('relative = true', relative)

    def test_shell_text_is_lua_data(self):
        command = 'printf \'%s\\n\' "$(touch /tmp/do-not-execute)"'
        code = ipc.dispatch('exec', command)
        self.assertEqual(code, 'hl.dsp.exec_cmd(' + ipc.quote(command) + ')')

    def test_flags_and_queries(self):
        self.assertEqual(ipc.translate(['-j', 'clients']), ['-j', 'clients'])
        self.assertEqual(ipc.translate(['dispatch', 'hl.dsp.window.close()']), ['dispatch', 'hl.dsp.window.close()'])
        code = ipc.translate(['keyword', 'device:touchpad:enabled', 'false', '-r'])
        self.assertEqual(code[:2], ['-r', 'eval'])
        self.assertIn('enabled = false', code[-1])

    def test_shell_menus_select_current_format(self):
        with tempfile.TemporaryDirectory() as directory:
            temp = Path(directory)
            for name, body in {
                'rofi': 'printf "%s\\n" "$MENU_CHOICE"',
                'pidof': 'exit 1',
                'kitty': 'printf "%s\\n" "$@" > "$MENU_CAPTURE"',
                'xdg-open': 'printf "%s\\n" "$1" > "$MENU_CAPTURE"',
            }.items():
                file = temp / name
                file.write_text('#!/usr/bin/env bash\n' + body + '\n')
                file.chmod(0o755)
            env = os.environ | {
                'PATH': str(temp) + ':' + os.environ['PATH'],
                'MENU_CAPTURE': str(temp / 'capture'),
                'MENU_CHOICE': 'Edit User Settings',
                'HYPR_DOTS_TERMINAL': 'kitty', 'EDITOR': 'nvim',
            }
            for mode in ('lua', 'conf'):
                env['HYPR_CONFIG_FORMAT'] = mode
                subprocess.run(['bash', str(ROOT / 'scripts/Kool_Quick_Settings.sh')], env=env, check=True)
                self.assertIn('UserConfigs/UserSettings.' + mode, (temp / 'capture').read_text())
            env |= {'HYPR_CONFIG_FORMAT': 'lua', 'MENU_CHOICE': 'a & b', 'HYPR_DOTS_SEARCH_ENGINE': 'https://example.org/?q={}'}
            (temp / 'capture').unlink()
            subprocess.run(['bash', str(ROOT / 'scripts/RofiSearch.sh')], env=env, check=True)
            # xdg-open is backgrounded by the script; wait briefly for our stub.
            import time
            for _ in range(100):
                if (temp / 'capture').exists():
                    break
                time.sleep(0.01)
            self.assertEqual((temp / 'capture').read_text().strip(), 'https://example.org/?q=a%20%26%20b')

    def test_native_shortcuts_have_no_duplicates(self):
        seen = set()
        for file in ('configs/Keybinds.lua', 'configs/Laptops.lua', 'UserConfigs/UserKeybinds.lua'):
            for combo in re.findall(r'hl\.bind\("([^"\n]+)"', (ROOT / file).read_text()):
                parts = combo.lower().split(' + ')
                normalized = (tuple(sorted(parts[:-1])), parts[-1])
                self.assertNotIn(normalized, seen, 'duplicate shortcut: ' + combo)
                seen.add(normalized)

    def test_unsupported_operations_are_explicit(self):
        with self.assertRaises(ValueError):
            ipc.translate(['keyword', 'windowrulev2', 'unset, initialClass:.*'])


def verify_native_api():
    samples = [
        ('exec', 'printf safe'), ('execr', 'printf safe'), ('killactive', ''),
        ('fullscreen', '1'), ('togglefloating', ''), ('pseudo', ''),
        ('workspace', 'm+1'), ('movetoworkspace', '3'),
        ('movetoworkspacesilent', 'special:scratchpad,address:0x123'),
        ('movefocus', 'l'), ('movewindow', 'd'), ('swapwindow', 'r'),
        ('moveintogroup', 'l'), ('moveoutofgroup', ''), ('togglegroup', ''),
        ('changegroupactive', 'f'), ('changegroupactive', 'b'),
        ('movecurrentworkspacetomonitor', 'l'), ('layoutmsg', 'togglesplit'),
        ('togglespecialworkspace', ''), ('cyclenext', 'prev'),
        ('resizeactive', '-50 0'), ('movewindowpixel', 'exact 3 4,address:0x123'),
        ('resizewindowpixel', 'exact 500 300,address:0x123'),
        ('focuswindow', 'address:0x123'), ('focusmonitor', 'eDP-1'),
        ('pin', 'address:0x123'), ('setfloating', 'address:0x123'),
        ('settiled', 'address:0x123'), ('setprop', 'active opaque toggle'),
        ('dpms', 'on'), ('dpms', 'off eDP-1'), ('splitratio', '0.3'),
        ('bringactivetotop', ''), ('workspaceopt', 'allfloat'), ('exit', '0'),
    ]
    lines = ['require("hyprland")', 'require("tests/verify_actions")']
    # Register closures only. No dispatcher is executed by this test.
    for name, arg in samples:
        lines.append('hl.bind("SUPER + F24", ' + ipc.dispatch(name, arg) + ')')
    for name, arg in [
        ('general:layout', 'master'), ('decoration:blur:enabled', 'false'),
        ('decoration:blur:size', '3'), ('device:test-touchpad:enabled', 'false'),
        ('general:col.active_border', 'rgb(ffffff) rgb(333333) 270deg'),
        ('bind', 'SUPER,J,cyclenext'), ('unbind', 'SUPER,J'),
        ('binded', 'SUPER,J,cycle windows,cyclenext,prev'),
    ]:
        lines.append(ipc.keyword(name, arg))
    with tempfile.NamedTemporaryFile(mode='w', prefix='.verify-', suffix='.lua', dir=ROOT) as config:
        config.write('\n'.join(lines) + '\n')
        config.flush()
        subprocess.run(['Hyprland', '--verify-config', '-c', config.name], check=True, cwd=ROOT)


if __name__ == '__main__':
    # Avoid cache files in the config tree during routine checks.
    suite = unittest.defaultTestLoader.loadTestsFromTestCase(Translation)
    if not unittest.TextTestRunner(verbosity=2).run(suite).wasSuccessful():
        raise SystemExit(1)
    verify_native_api()
    print('Native config, runtime actions and IPC API checks passed.')
