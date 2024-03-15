"""
Deployment unit tests
Generic tests
"""


def test_networking(host):
    """
    Check whether local name lookup works
    """
    for ipaddr in ['192.168.56.10', '192.168.56.20', '192.168.56.30']:
        # check that hosts are pingable
        assert host.run('ping %s -c3' % ipaddr).rc == 0
