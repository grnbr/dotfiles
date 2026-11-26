import logging
import subprocess
from pathlib import Path

from setups_py.shared.paths import REPO_ROOT

logger = logging.getLogger(__name__)

SYSTEMD_DIR = REPO_ROOT / "configs" / "systemd"
UNIT_SUFFIXES = {".service", ".timer", ".target"}

DEST_DIRS = {
    "user": Path.home() / ".config" / "systemd" / "user",
    "system": Path("/etc/systemd/system"),
}


def apply_systemd(optional_names: list[str] | None = None) -> None:
    for dir_name in DEST_DIRS:
        for item_name in _children(f"main/{dir_name}"):
            apply_systemd_item(item_name)

    for name in optional_names or []:
        apply_systemd_item(f"optional/{name}")

    for dir_name in DEST_DIRS:
        _daemon_reload(dir_name)


def apply_systemd_item(item_name: str) -> None:
    item = SYSTEMD_DIR / item_name
    dir_name = _dir_name_of(item_name)

    if item.is_dir():
        for unit in _unit_files(item):
            _link_unit(unit, dir_name)
    elif item.is_file():
        _link_unit(item, dir_name)
    else:
        logger.warning("SKIP: %s not found", item)


def _dir_name_of(item_name: str) -> str:
    dir_name = Path(item_name).parts[1]

    if dir_name not in DEST_DIRS:
        raise ValueError(f"Invalid systemd directory in: {item_name}")

    return dir_name


def _children(folder_name: str) -> list[str]:
    folder = SYSTEMD_DIR / folder_name

    if not folder.is_dir():
        return []

    return [f"{folder_name}/{child.name}" for child in sorted(folder.iterdir())]


def _unit_files(folder: Path) -> list[Path]:
    return sorted(item for item in folder.iterdir() if item.suffix in UNIT_SUFFIXES)


def _link_unit(unit: Path, dir_name: str) -> None:
    dest = DEST_DIRS[dir_name]
    sudo = _sudo_prefix(dir_name)

    subprocess.run([*sudo, "mkdir", "-p", str(dest)], check=True)
    subprocess.run([*sudo, "ln", "-sf", str(unit), str(dest / unit.name)], check=True)

    logger.info("Linked systemd: %s", unit.name)


def _daemon_reload(dir_name: str) -> None:
    systemctl = ["systemctl", "--user"] if dir_name == "user" else ["systemctl"]

    subprocess.run([*_sudo_prefix(dir_name), *systemctl, "daemon-reload"], check=True)


def _sudo_prefix(dir_name: str) -> list[str]:
    return ["sudo"] if dir_name == "system" else []
