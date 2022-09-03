import json
import sys
import os

cwd = os.path.abspath(os.getcwd())

if len(sys.argv) != 3:
    ipath = input("Enter file input path: ")
    opath = input("Enter file output path: ")
else:
    ipath = sys.argv[1]
    opath = sys.argv[2]

ipath = os.path.join(cwd, ipath)
opath = os.path.join(cwd, opath)

if ipath == opath:
    file = open(ipath, "r+")
    ifile = file
    ofile = file
else:
    ifile = open(ipath, "r")
    ofile = open(opath, "w")

obj = json.load(ifile)

if ifile == ofile:
     # set pointer to starting pos cuz file will be appened by dump
    ifile.seek(0)
    ifile.truncate()

json.dump(obj, ofile, 
          indent=2, 
          sort_keys=True
)

ifile.close()
ofile.close()
