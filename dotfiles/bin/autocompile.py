#!/usr/bin/python3
#
# Usage:
# ./autocompile.py path ext1,ext2,extn cmd
#
# Blocks monitoring |path| and its subdirectories for modifications on
# files ending with suffix |extk|. Run |cmd| each time a modification
# is detected. |cmd| is optional and defaults to 'make'.
#
# Example:
# ./autocompile.py /my-latex-document-dir .tex,.bib "make pdf"
#
# Dependencies:
# Linux, Python 2.6, Pyinotify
#
import subprocess
import sys
import pyinotify
import os


class OnWriteHandler(pyinotify.ProcessEvent):

    def my_init(self, cwd, extension, cmd):
        self.cwd = cwd
        self.extensions = extension.split(',')
        self.cmd = cmd

    def _run_cmd(self):
        print('==> Mion detected')
        print('current dir: ' + os.getcwd())
        print('call: ' + str(self.cmd.split(';')) + " " + str(self.cwd))
        commands = self.cmd.split(';')
        for c in commands:
            try:
                print("INFO execute " + c)
                retval = subprocess.call(c.split(' '), cwd=self.cwd)
                if retval != 0:
                    print("ERROR while executing " + c + " - error code: " + str(retval))

                # subprocess.check_output(c.split(' '))
            except Exception as e:
                print("ERROR running " + c + "=> " + str(e))

    def process_IN_MODIFY(self, event):
        if all(not event.pathname.endswith(ext) for ext in self.extensions):
            return
        self._run_cmd()


def auto_compile(path, extension, cmd):
    wm = pyinotify.WatchManager()
    print("1")
    handler = OnWriteHandler(cwd=path, extension=extension, cmd=cmd)
    print("2")
    notifier = pyinotify.Notifier(wm, default_proc_fun=handler)
    print("3")
    wm.add_watch(path, pyinotify.ALL_EVENTS, rec=True, auto_add=True)
    print('==> Start monitoring %s (type c^c to exit)' % path)
    notifier.loop()


if __name__ == '__main__':
    if len(sys.argv) < 3:
        print >> sys.stderr, "Command line error: missing argument(s)."
        sys.exit(1)
    # Required arguments
    path = sys.argv[1]
    extension = sys.argv[2]
    # Optional argument
    cmd = 'make'
    if len(sys.argv) == 4:
        cmd = sys.argv[3]
    # Blocks monitoring
    print("path: " + path)
    print("ext: " + extension)
    print("cmd: " + cmd)
    auto_compile(path, extension, cmd)
