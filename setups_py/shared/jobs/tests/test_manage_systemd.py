import pytest

from setups_py.shared.jobs import manage_systemd


def make_tree(root, paths):
    for path in paths:
        file = root / path
        file.parent.mkdir(parents=True, exist_ok=True)
        file.touch()


def test_dir_name_of_returns_user():
    assert manage_systemd._dir_name_of("main/user/a.service") == "user"


def test_dir_name_of_rejects_unknown_dir():
    with pytest.raises(ValueError):
        manage_systemd._dir_name_of("main/other/a.service")


def test_children_lists_main_user(tmp_path, monkeypatch):
    make_tree(
        tmp_path,
        [
            "main/user/cleanup-old-files.service",
            "main/user/cleanup-old-files.timer",
            "optional/user/bspwm/bspwm-session.target",
        ],
    )
    monkeypatch.setattr(manage_systemd, "SYSTEMD_DIR", tmp_path)

    assert manage_systemd._children("main/user") == [
        "main/user/cleanup-old-files.service",
        "main/user/cleanup-old-files.timer",
    ]


def test_children_returns_empty_for_missing_folder(tmp_path, monkeypatch):
    monkeypatch.setattr(manage_systemd, "SYSTEMD_DIR", tmp_path)

    assert manage_systemd._children("main/system") == []


def test_children_returns_empty_for_empty_folder(tmp_path, monkeypatch):
    (tmp_path / "main" / "user").mkdir(parents=True)
    monkeypatch.setattr(manage_systemd, "SYSTEMD_DIR", tmp_path)

    assert manage_systemd._children("main/user") == []


def test_sudo_prefix():
    assert manage_systemd._sudo_prefix("system") == ["sudo"]
    assert manage_systemd._sudo_prefix("user") == []


def test_unit_files_keeps_only_units(tmp_path):
    make_tree(tmp_path, ["a.service", "b.timer", "c.target", "notes.txt"])

    result = manage_systemd._unit_files(tmp_path)

    assert [unit.name for unit in result] == ["a.service", "b.timer", "c.target"]
