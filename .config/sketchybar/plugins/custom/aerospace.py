import logging
import os

from windows import get_all_windows, set_title

logging.basicConfig(
    filename=os.path.join(os.path.expanduser("~"), ".cache/hypr_monitors.log"),
    filemode='a',
    format='%(asctime)s %(levelname)s %(message)s',
    datefmt='%H:%M:%S',
    level=logging.DEBUG
)

logger = logging.getLogger('sketchy')
# logger.info('running')

sender = os.getenv('SENDER')
# logger.info(sender)
if sender == 'aerospace_window_focus_change':
    try:
        get_all_windows()
    except Exception:
        logger.exception('failed to get windows')
elif sender == 'aerospace_fullscreen':
    try:
        set_title()
    except Exception:
        logger.exception('failed to get windows')
