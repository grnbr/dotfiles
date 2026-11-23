import logging
import subprocess

logger = logging.getLogger(__name__)

PACMAN_CONF = "/etc/pacman.conf"


def enable_multilib() -> None:
    logger.info("Enabling multilib...")

    _uncomment_multilib()

    if not _is_enabled():
        logger.warning("multilib section missing, adding it")
        _append_multilib()

    if not _is_enabled():
        raise RuntimeError("Failed to enable multilib")

    logger.info("multilib enabled")


def _uncomment_multilib() -> None:
    subprocess.run(
        ["sudo", "sed", "-i", r"/\[multilib\]/,/Include/s/^#//", PACMAN_CONF],
        check=True,
    )


def _is_enabled() -> bool:
    result = subprocess.run(["grep", "-q", r"^\[multilib\]", PACMAN_CONF])

    return result.returncode == 0


def _append_multilib() -> None:
    entry = "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist\n"

    subprocess.run(
        ["sudo", "tee", "-a", PACMAN_CONF],
        input=entry,
        text=True,
        stdout=subprocess.DEVNULL,
        check=True,
    )
