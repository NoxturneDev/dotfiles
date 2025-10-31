#!/usr/bin/python3

import os
import subprocess
import sys

if (len(sys.argv) > 1):
    args = ' '.join(sys.argv[1:])
    if ('gnome-help' in args) and not os.path.exists('/usr/share/help/C/gnome-help'):
        os.system ("xdg-open http://www.linuxmint.com/documentation.php &")
    elif ('ubuntu-help' in args) and not os.path.exists('/usr/share/help/C/ubuntu-help'):
        os.system ("xdg-open http://www.linuxmint.com/documentation.php &")
    else:
        subprocess.Popen(["/usr/bin/yelp"] + sys.argv[1:])
else:
    os.system ('/usr/bin/yelp')
