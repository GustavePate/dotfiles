#!/bin/python

import os
# import glob
from os import listdir
from os.path import isfile, join
from shlex import quote
import subprocess
import shutil


def doit():
    # ffmpeg -i input -codec:v libx264 -crf 23 -preset medium -codec:a
    # libfdk_aac -vbr 4 -movflags faststart -vf scale=-1:720,format=yuv420p
    # output.mp4
    # files = glob.glob("./.*.avi")
    ext = ".mp4"
    mypath = "./"

    # create converted and old directory if not exists

    old = os.path.join(mypath, "old")
    if not os.path.isdir(old):
        os.mkdir(old)

    converted = os.path.join(mypath, "converted")
    if not os.path.isdir(converted):
        os.mkdir(converted)

    onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
    for f in onlyfiles:
        if f.endswith(ext):
            # protect string

            src = f
            dest = os.path.join(converted, os.path.basename(src))
            # old = os.path.join(old, os.path.basename(src))
            print("####################################")
            print("####################################")
            print("####################################")
            print("src:", src)
            print("old:", old)
            print("dest:", dest)
            command = 'ffmpeg -i {} -codec:v libx264 -crf 23 -preset slow -codec:a libfdk_aac -vbr 4 -movflags faststart -vf scale=-1:720,format=yuv420p {}'.format(
                quote(src),
                quote(dest))
            print(command)
            # command = 'ls -l; sleep 1'
            subprocess.call(command, shell=True)
            shutil.move(src, old)

if __name__ == '__main__':
    doit()
