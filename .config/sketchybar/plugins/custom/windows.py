import json
import logging
from subprocess import run

from icon_map import ICON_MAP

logger = logging.getLogger('sketchy')


def set_workspace_windows(sid, windows, focused, visible):
    if focused:
        bg_color = '0xffbd93f9'
        color = '0xff212121'
    elif visible:
        bg_color = '0xff4a111b'
        color = '0xffcdd6f4'
    elif not windows:
        color = '0xff19496e'
        bg_color = '0x001e1e2e'
    else:
        bg_color = '0x001e1e2e'
        color = '0xff939ab7'

    cmd = (
        f'sketchybar --set space.{sid} background.color={bg_color} '
        'label.shadow.drawing=off icon.shadow.drawing=off background.border_width=2 '
        f'icon.color={color} label.color={color} '
    )

    icon_strip = ""

    for app in windows:
        app_name = app['app-name']
        icon_strip += ICON_MAP.get(app_name, app_name)

    if windows and not icon_strip:
        logger.error(windows)
    # else:
    #     logger.info(icon_strip)

    cmd += f'label={icon_strip}'
    run(cmd.split())


def set_title():
    focused_app = get_focused_app()
    if not focused_app:
        cmd = f"sketchybar --set title drawing=off"
        run(cmd.split())
        return

    monitor = focused_app['monitor-appkit-nsscreen-screens-id']
    if not monitor:
        return

    # logger.info(focused_app)
    icon = ''
    label = ''
    if focused_app:
        icon = ICON_MAP.get(focused_app['app-name'], focused_app['app-name'])
        label = ' ' + focused_app['window-title'][:5]
        fullscreen = focused_app['window-is-fullscreen']

    # logger.info(f'{icon}: {label}')

    color = '0xff212121' if fullscreen else '0xff939ab7'
    bg_color = '0xffed8796' if fullscreen else '0x00000000'

    cmd = (
        f"sketchybar --set title background.color={bg_color} icon={icon} "
        'label.shadow.drawing=off icon.shadow.drawing=off background.border_width=2 '
        f'label.color={color} icon.color={color} display={monitor} drawing=on'
    )
    cmd = cmd.split()
    cmd.append(f'label={label}')
    run(cmd)


def get_all_workspaces():
    cmd = f'aerospace list-workspaces --all --json --format '
    cmd = cmd.split()
    cmd.append('%{workspace} %{workspace-is-focused} %{workspace-is-visible}')
    return json.loads(run(cmd, text=True, capture_output=True).stdout)


def _get_all_windows():
    cmd = f'aerospace list-windows --all --json --format'
    cmd = cmd.split()
    format = [
        '{window-id}',
        '{app-name}',
        '{window-title}',
        '{window-is-fullscreen}',
        '{workspace}'
    ]
    params = ''
    for param in format:
        params += f'%{param}'

    cmd.append(params)

    return json.loads(run(cmd, text=True, capture_output=True).stdout)


def get_focused_app():
    cmd = f'aerospace list-windows --focused --json --format'
    cmd = cmd.split()
    format = [
        '{workspace}',
        '{monitor-appkit-nsscreen-screens-id}',
        '{app-name}',
        '{window-title}',
        '{window-is-fullscreen}',
    ]
    params = ''
    for param in format:
        params += f'%{param}'

    cmd.append(params)

    try:
        focused_app = json.loads(run(cmd, text=True, capture_output=True).stdout)[0]
    except Exception:
        focused_app = None

    return focused_app


def get_monitors():
    cmd = (
        'aerospace list-monitors --json '
        '--format %{monitor-appkit-nsscreen-screens-id}'
    )

    monitors = json.loads(run(cmd.split(), text=True, capture_output=True).stdout)
    return [list(mid.values())[0] for mid in monitors]


def get_all_windows():
    all_workspaces = get_all_workspaces()

    workspaces = {}
    for workspace in all_workspaces:
        workspaces[workspace['workspace']] = {
            'focused': workspace['workspace-is-focused'],
            'visible': workspace['workspace-is-visible'],
            'fullscreen': False,
            'apps': [],
            'focused_app': None
        }

    windows = _get_all_windows()

    for win in windows:
        wk = win['workspace']
        workspaces[wk]['apps'].append({
            'app-name': win['app-name'],
            'window-title': win['window-title'],
        })
        if win['window-is-fullscreen']:
            workspaces[wk]['fullscreen'] = True

    for workspace, windows in workspaces.items():
        set_workspace_windows(
            workspace,
            windows['apps'],
            windows['focused'],
            windows['visible']
        )

    set_title()


if __name__ == '__main__':
    get_all_windows()
