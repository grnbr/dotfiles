from pathlib import Path


def _find_repo_root() -> Path:
    here = Path(__file__).resolve()

    for folder in here.parents:
        if (folder / ".git").exists():
            return folder

    raise RuntimeError("Repo root not found (no .git above this file)")


REPO_ROOT = _find_repo_root()
