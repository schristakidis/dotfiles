import json
import logging
from subprocess import run

logger = logging.getLogger('sketchy')


def set_windows(sid):

    cmd = (
        f'aerospace list-windows --workspace {sid} --json'
        "--format '%{window-id} %{app-name} %{window-title}  %{window-is-fullscreen}'"
    )
    output = run(cmd.split(), text=True, capture_output=True).stdout
    apps = json.loads(output)
    logger.info(apps)
