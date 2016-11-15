#!/usr/bin/env python3

#This is a simple script which walks the trees in the TCCD/data folder
#to find and list all the folders containing files that need to be 
#dealt with in various ways. These lists are saved into text files 
#which can be read and used by the build process.

#Author Martin Holmes. November 2016.

import os
import sys
import re
import shutil

print("=====================================================================")
print("Parsing the folder structure to discover the locations of key files.")
print("=====================================================================")
print()

#root location is the folder containing this file.
dirRoot = os.getcwd()

#data directory is relative to working dir
dirData = os.path.abspath('../../data')

#regex for TEI file names
reTeiFile = re.compile("^lg.+\d\d\d\d-\d\d-\d\d.xml$")

#regex for original HOCR folders
reOrigHocr = re.compile("hocr_orig$")

#regex for edited HOCR files
reEditedHocr = re.compile("\.html$")

print("Data directory is at " + dirData)

provinceFolders = ["AB_SK", "BC", "Indigenous_Voices", "Man", "Nfld", "NS", "Ont_Que", "PEI"]

#Function for creating an XSLT collection file from a list of files.

def writeCollection(fileList, fileName):
  f = open(fileName, 'w')
  f.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
  f.write("<collection>\n")
  for i in fileList:
    f.write("   <doc href=\"" + i + "\"/>\n")
  f.write("</collection>")

print("=====================================================================")
print("Walking the data directory to list all the TEI files...")

teiFiles = []
for dirpath, subdirs, files in os.walk(dirData):
    for f in files:
        if re.match(reTeiFile, f):
            teiFiles.append(os.path.join(dirpath, f))
            
writeCollection(teiFiles, 'teifiles.xml')

print("Done.")
print("=====================================================================")
print()

print("=====================================================================")
print("Listing all the original HOCR files...")

origHocrFiles = []
for fldr in provinceFolders:
  for dirpath, subdirs, files in os.walk(dirData + '/' + fldr):
      for f in files:
          if re.search(reOrigHocr, dirpath):
              origHocrFiles.append(os.path.join(dirpath, f))
 
writeCollection(origHocrFiles, 'origHocrFiles.xml')

print("Done.")
print("=====================================================================")
print()

print("=====================================================================")
print("Listing all the edited HOCR files...")

editedHocrFiles = []
for fldr in provinceFolders:
  if (os.path.exists(dirData + '/' + fldr + '/final')):
    for dirpath, subdirs, files in os.walk(dirData + '/' + fldr + '/final'):
        for f in files:
            if re.search(reEditedHocr, dirpath):
                editedHocrFiles.append(os.path.join(dirpath, f))
  else:
    if (os.path.exists(dirData + '/' + fldr + '/hocr_edited')):
      for dirpath, subdirs, files in os.walk(dirData + '/' + fldr + '/hocr_edited'):
        for f in files:
            if re.search(reEditedHocr, f):
                editedHocrFiles.append(os.path.join(dirpath, f))
      
            
writeCollection(editedHocrFiles, 'editedHocrFiles.xml')

print("Done.")
print("=====================================================================")
print()

