"""
Deployment unit tests
Controller tests
"""
import testinfra.utils.ansible_runner


def test_software(host):
    """
    Check whether required software packages are installed
    """
    packages = [
        "git",
        "python3-pynacl",
        "python3-pip",
        "python3-requests",
        "inspec"
    ]
    for pkg in packages:
        _pkg = host.package(pkg)
        assert _pkg.is_installed


def test_ports(host):
    """
    Check whether that required ports are open
    """
    ports = [
        "22",       # ssh
        "443"       # OpenVAS web UI
    ]
    for port in ports:
        _port = host.socket("tcp://0.0.0.0:%s" % port)
        assert _port.is_listening


def test_binaries(host):
    """
    Check additional binaries
    """
    binaries = [
        '/usr/local/bin/docker-compose'
    ]
    for _bin in binaries:
        _file = host.file(_bin)
        assert _file.exists
        assert _file.mode == 0o755
