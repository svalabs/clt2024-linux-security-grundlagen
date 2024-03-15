"""
Deployment unit tests
node1 tests
"""
import testinfra.utils.ansible_runner


def test_software(host):
    """
    Check whether required software packages are installed
    """
    packages = [
        "apparmor",
        "apparmor-profiles",
        "apparmor-profiles-extra",
        "apparmor-utils"
    ]
    for pkg in packages:
        _pkg = host.package(pkg)
        assert _pkg.is_installed


def test_unneeded_software(host):
    """
    Check whether crap packages are installed
    """
    packages = [
        "libt3config0",
        "libt3highlight2",
        "libt3key-bin",
        "libt3key1",
        "libt3widget2",
        "libt3window0",
        "libtranscript1",
        "tilde"
    ]
    for pkg in packages:
        _pkg = host.package(pkg)
        assert _pkg.is_installed
