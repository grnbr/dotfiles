import importlib
import logging
from pathlib import Path

from setups_py.shared.paths import REPO_ROOT

logger = logging.getLogger(__name__)


COMMON_DIRS = [
    Path(__file__).parent / "common",
    REPO_ROOT / "setups_py/shared/jobs/common",
    REPO_ROOT / "setups_py/shared/jobs/common/for-clean-systems",
    REPO_ROOT / "setups_py/arch/shared/jobs/common",
    REPO_ROOT / "setups_py/arch/shared/jobs/common/for-clean-systems",
]


def run_common_jobs() -> None:
    for folder in COMMON_DIRS:
        for job_file in _job_files(folder):
            _run_job(job_file)


def _job_files(folder: Path) -> list[Path]:
    if not folder.is_dir():
        return []

    return [file for file in folder.glob("*.py") if not file.name.startswith("_")]


def _run_job(job_file: Path) -> None:
    logger.info("=> Running %s", job_file)

    module_name = ".".join(job_file.relative_to(REPO_ROOT).with_suffix("").parts)
    module = importlib.import_module(module_name)

    getattr(module, job_file.stem)()
