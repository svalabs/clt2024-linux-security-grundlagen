"""
Deployment unit tests
Generic tests
"""
import os
import testinfra.utils.ansible_runner


def test_software(host):
    """
    Check whether required software packages are installed
    """
    packages = [
        "vim-common",
        "dos2unix",
        "acl",
        "htop",
        "fail2ban"
    ]
    for pkg in packages:
        _pkg = host.package(pkg)
        assert _pkg.is_installed


def test_unneeded_software(host):
    """
    Check whether crap packages are installed
    """
    packages = [
        "cowsay",
        "figlet",
        "telnet",
    ]
    for pkg in packages:
        _pkg = host.package(pkg)
        assert _pkg.is_installed


def test_selinux_software(host):
    """
    Check whether SELinux software packages are installed
    """
    packages = [
        "policycoreutils",
        "policycoreutils-python-utils"
    ]
    # set service name depending on OS family
    if host.system_info.distribution == "rockylinux":
        for pkg in packages:
            _pkg = host.package(pkg)
            assert _pkg.is_installed


def test_ssh_options(host):
    """
    Check whether required SSH options are set
    """
    options = [
        "PasswordAuthentication yes",
        "PermitRootLogin yes"
    ]
    _ssh = host.file("/etc/ssh/sshd_config")
    for _opt in options:
        assert _ssh.contains(_opt)


def test_firewall(host):
    """
    Check whether firewall is enabled
    """
    if host.system_info.distribution == "ubuntu":
        _service = host.service("ufw.service")
    else:
        _service = host.service("firewalld.service")
    assert _service.is_enabled
    assert _service.is_running


def test_user(host):
    """
    Check whether user exists and has valid home directory
    """
    user = host.user("user")
    home_dir = host.file(user.home)
    assert user.exists
    assert home_dir.is_directory
    assert home_dir.user == user.name


def test_user_sudo(host):
    """
    Check whether user can use use
    """
    sudo_config = host.file("/etc/sudoers")
    assert sudo_config.contains('user  ALL=(ALL)       NOPASSWD: ALL')


def test_hosts(host):
    """
    Check whether local name lookup works
    """
    hosts = host.file("/etc/hosts")
    for name in ['controller', 'node1', 'node2']:
        # check that line is available
        assert name in hosts.content_string
        # check that hosts are pingable
        assert host.run('ping %s -c3' % name).rc == 0


def test_solutions(host):
    """
    Check whether solutions have been copied
    """
    labs_dir = host.file("/labs")
    assert labs_dir.exists
    assert len(labs_dir.listdir()) > 10


def test_binaries(host):
    """
    Check additional binaries
    """
    binaries = [
        '/usr/bin/commander',
        '/usr/bin/lab',
        '/usr/local/bin/sus'
    ]
    for _bin in binaries:
        _file = host.file(_bin)
        assert _file.exists
        assert _file.mode == 0o755
