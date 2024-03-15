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
        "python3-policycoreutils",
        "policycoreutils-devel",
        "selinux-policy-doc",
        "nmap"
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
        "libt3highlight-utils",
        "libt3widget2",
        "libt3window0",
        "libtranscript1",
        "libt3key-utils",
        "libt3key1",
        "tilde"
    ]
    for pkg in packages:
        _pkg = host.package(pkg)
        assert _pkg.is_installed


def test_webapp_files(host):
    """
    Check web application files
    """
    files = [
        '/var/www/html/app.php',
        '/var/www/html/crying_cat.jpg',
        '/var/www/html/happy_cat.jpg'
    ]
    for f in files:
        _file = host.file(f)
        assert _file.exists
        assert _file.size > 0


def test_ports(host):
    """
    Check whether that required ports are open
    """
    ports = [
        "80"       # http
    ]
    for port in ports:
        _port = host.socket("tcp://0.0.0.0:%s" % port)
        assert _port.is_listening


def test_insecure_files(host):
    """
    Ensure that files with insecure permissions were created
    """
    files = [
        {
            'path': '/var/www/html/web-passwords',
            'user': 'root',
            'group': 'root',
            'mode': 0o777
        },
        {
            'path': '/usr/bin/notarootshell',
            'user': 'root',
            'group': 'root',
            'mode': 0o4775
        },
        {
            'path': '/var/www/html/database_dispatcher.php',
            'user': 'root',
            'group': 'apache',
            'mode': 0o2775
        }
    ]
    for f in files:
        _file = host.file(f['path'])
        assert _file.exists
        assert _file.size > 0
        assert _file.user == f['user']
        assert _file.group == f['group']
        assert _file.mode == f['mode']
