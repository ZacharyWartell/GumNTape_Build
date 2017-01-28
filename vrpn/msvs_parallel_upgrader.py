#!/usr/bin/python3
# \author Zachary Wartell
# \brief Find all MSVS project files with suffix [:alpha:]*.sln, [:alpha:]*.vcproj, [:alpha:]*.vcprojx,
#

# Ruminations:
#
# GOAL:  Need to have one source distribution of VRPN cross compiled for
# multiple version of MSVS while keeping all the output files of the
# different versions of MSVS in separate subdirectories.  While I'm
# familiar with CMake, I don't want to bring CMake into this at this
# time.

import sys
import os
import re
import shutil
import argparse

def copyfile_dr(old,new):
    print (old + " => " + new)
    return

if (sys.version_info < (3, 0)):
    print("This script requires Python 3")
    exit()
    
#print (sys.argv[0]);
#print ("Hello");


help="""
Find all MSVS project files with suffix [:alpha:]*.sln, [:alpha:]*.vcproj, [:alpha:]*.vcprojx and make new
files with names [:alpha:]*-<new_suffix>.sln, [:alpha:]*-<new_suffix>.vcproj, etc.  where <new_suffix> is a
string passed as a command line parameter
"""

parser = argparse.ArgumentParser(description=help)

parser.add_argument("directory", help="path name to search for files")
parser.add_argument("--dryrun", help="display what files would be changes without changing them",action="store_true")
parser.add_argument("--new_suffix", help="new suffix to append to MSVS project file name", default="-2010")

args = parser.parse_args()
rootdir = args.directory

msvs_version = args.new_suffix

if (args.dryrun):
    copyfile = copyfile_dr
else:
    copyfile = shutil.copyfile

for root, subFolders, files in os.walk(rootdir):

    for oldfile in files:
        suffix = re.search("\.[a-zA-Z]*$",oldfile)
        #print (oldfile, suffix)
        if suffix:
            if suffix.group(0) == ".vcproj":
                # handle .vcproj files
                if msvs_version not in oldfile:
                    newfile = re.sub(r"(\.vcproj$)", msvs_version + suffix.group(0), oldfile)
                    copyfile(os.path.join(root, oldfile),os.path.join(root, newfile))
                #print (oldfile)
            elif suffix.group(0) == ".vcprojx":
                # handle .vcprojx files
                if msvs_version not in oldfile:
                    newfile = re.sub(r"(\.vcprojx$)", msvs_version + suffix.group(0), oldfile)                
                    copyfile(os.path.join(root, oldfile),os.path.join(root, newfile))
                #print (oldfile)
            elif suffix.group(0) == ".sln":
                # handle .sln files
                if msvs_version not in oldfile:
                    newfile = re.sub(r"(\.sln$)", msvs_version + suffix.group(0), oldfile)                
                    #copyfile(os.path.join(root, oldfile),os.path.join(root, newfile))
                    #shutil.copyfile(os.path.join(root, oldfile),os.path.join(root, newfile))
                    with open(os.path.join(root, newfile),'w') as nf:
                        with open(os.path.join(root, oldfile),'r') as of:
                            for line in of:
                                line = line.rstrip('\r\n')     # these are Windows files :)
                                newline, count = re.subn(r"\.vcproj", msvs_version + ".vcproj", line)
                                #print (count)
                                #if count:
                                #    print ("    " + newline)
                                print (newline,file=nf,end='\r\n')        
