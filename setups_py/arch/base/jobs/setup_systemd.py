import logging
import subprocess
from pathlib import Path

from setups_py.shared.jobs.manage_systemd import apply_systemd

logger = logging.getLogger(__name__)

OPTIONAL_SYSTEMD: list[str] = []
SYSTEMD_SERVICES = {"NetworkManager", "bluetooth", "sshd", "sing-box"}
USER_SYSTEMD_SERVICES = [
    "pipewire",
    "pipewire-pulse",
    "wireplumber",
    "darkman",
    "xdg-desktop-portal",
    "cleanup-old-files.timer",
    "mpd",
]
SYSTEMD_RUNTIME_DIR = Path("/run/systemd/system")


def setup_systemd() -> None:
    if not SYSTEMD_RUNTIME_DIR.exists():
        logger.warning("SKIP: systemd is not running")
        return

    apply_systemd(OPTIONAL_SYSTEMD)

    _enable_services()
    _enable_user_services()


def _enable_services() -> None:
    logger.info("Enabling systemd services...")

    for service in SYSTEMD_SERVICES:
        subprocess.run(
            ["sudo", "systemctl", "enable", "--now", service],
            check=True,
        )


def _enable_user_services() -> None:
    logger.info("Enabling user systemd services...")

    for service in USER_SYSTEMD_SERVICES:
        subprocess.run(
            ["systemctl", "--user", "enable", "--now", service],
            check=True,
        )
