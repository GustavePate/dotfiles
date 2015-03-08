#!/usr/bin/env python
# -*-coding: utf8-*-

"""
Need a running firefox instance with  Remote Control add-on
(see https://addons.mozilla.org/en-US/firefox/addon/remote-control)
"""

import socket
import telnetlib
import sys


def telnet_reload(host, port):
    tn = None
    res = ""

    try:
        tn = telnetlib.Telnet(host, port)
        tn.write("reload\n")
        res = tn.read_until('\n')
    except socket.error as e:
        print "ERROR with_telnet "
        raise e
    finally:
        tn.close()
        return res


if __name__ == "__main__":
    "This part will run after selecting a tab for remote control in firefox"
    try:
        telnet_reload('localhost', '32000')
    except Exception as e:
        print "ERROR reload_browser, is Remote Control on ? " + str(e)
    finally:
        sys.exit(0)
