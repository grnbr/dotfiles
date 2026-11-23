import logging
import shutil
import time
from pathlib import Path

from setups_py.shared.paths import REPO_ROOT

logger = logging.getLogger(__name__)

CONFIGS_DIR = REPO_ROOT / "configs"
DEST_DIR = Path.home() / ".config"
BACKUP_DIR = Path.home() / ".config.bak"


def apply_config(config_name: str) -> None:
    source = CONFIGS_DIR / config_name
    target = DEST_DIR / source.name

    if not source.exists():
        logger.warning("SKIP: %s not found", source.name)
        return

    DEST_DIR.mkdir(parents=True, exist_ok=True)
    BACKUP_DIR.mkdir(parents=True, exist_ok=True)

    _backup(target)
    _remove(target)

    target.symlink_to(source)


def _backup(target: Path) -> None:
    if not target.exists() and not target.is_symlink():
        return

    backup = BACKUP_DIR / f"{target.name}.{int(time.time())}"

    if target.is_dir() and not target.is_symlink():
        shutil.copytree(target, backup, symlinks=True)
    else:
        shutil.copy2(target, backup, follow_symlinks=False)


def _remove(target: Path) -> None:
    if target.is_symlink() or target.is_file():
        target.unlink()
    elif target.is_dir():
        shutil.rmtree(target)
