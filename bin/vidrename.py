#!/usr/bin/env python
import sys
import re
from optparse import OptionParser

usage = "usage: %prog [-v*] SOURCE"
version = "%prog 0.1 Alpha"
parser = OptionParser(usage=usage,version=version)
parser.add_option("-v", "--verbose", action="count", dest="verbose", default=0, help="Increase verbosity")
parser.add_option("-m", "--move", action="store_true", dest="move", default=False, help="move file to new name")
parser.add_option("-c", "--copy", action="store_true", dest="copy", default=False, help="copy file to new name")
(options,args) = parser.parse_args()
if (len(args) == 0):
    print usage
    sys.exit(0)

se = re.compile(r's(\d+)e(\d+)|(\d+)(\d\d)|(\d+)x(\d\d)')
year_re = re.compile('^(19|20)\d\d$')

d = { "hdtv" : "HDTV",
      "xvid" : "XviD",
    "dvdrip" : "DVDRip",
      "pdtv" : "PDTV",
      "real" : "REAL",
    "repack" : "REPACK",
    "webrip" : "WEBRip",
    "web-dl" : "WEB-DL",
    "proper" : "PROPER",
  "internal" : "INTERNAL",
       "web" : "WEB",
       "cd1" : "CD1",
       "cd2" : "CD2",
        "of" : "of",
      'x264' : 'x264',
      'h264' : 'h264',
      '720p' : '720p',
       'mp4' : 'mp4',
       'mkv' : 'mkv',
       'dcs' : 'DCs',
        "vs" : "vs",
        "a"  : "a",
       "to"  : "to",
       "in"  : "in",
       "the" : "the",
       "and" : "and",
       "vs." : "vs",
       "srt" : "srt",
      "avi/" : "avi/",
       "avi" : "avi"}

group_names =  {
  "momentum" : "MOMENTUM",
   "killers" : "KILLERS",
      "nor"  : "NOR",
      "ftp"  : "FTP",
      "fov"  : "FoV",
      "fum"  : "FUM",
      "sva"  : "SVA",
      "lol"  : "LOL",
     "vild"  : "ViLD",
     "imbt"  : "iMBT",
     "fleet" : "FLEET",
     "skgtv" : "SKGTV",
   "clerks"  : "CLERKS",
   "crooks"  : "CROOKS",
   "diverge" : "DiVERGE",
   "amiable" : "AMIABLE",
   "nodlabs" : "NODLABS",
   "deflate" : "DEFLATE",
    "strife" : "STRiFE",
      "fqm"  : "FQM",
      "sys"  : "SYS",
       "w4f" : "W4F",
       "bia" : "BiA",
       "tbs" : "TBS",
      "batv" : "BATV",
     "asap"  : "ASAP",
     "river" : "RiVER",
    "fever"  : "FEVER",
      "notv" : "NoTV",
      "2hd"  : "2HD" }

uploader_names = ["ettv","eztv"]

original_filename = args[0]
filename = original_filename.lower()

def season_episode(text):
    if not se.match(text):
        return None
    return tuple(map(lambda x: '%.2d' % int(x), filter(lambda x: x, se.match(text).groups())))


parts = filter(None, re.split(r'[. \[\]-]', filename))
output_parts = []
for part in parts:
    if part in group_names:
        output_parts.append(group_names[part])
    elif part in uploader_names:
        continue
    elif part in d:
        output_parts.append(d[part])
    elif year_re.match(part):
        output_parts.append(part)
    elif season_episode(part):
        output_parts.append('S%sE%s' % season_episode(part))
    else:
        output_parts.append(part.capitalize())

try:
    xvid_index = output_parts.index('HDTV') + 1
    if output_parts[xvid_index] not in ('XviD', 'x264', 'h264'):
        if output_parts[-1] == 'avi':
            output_parts.insert(xvid_index,'XviD')
        else:
            output_parts.insert(xvid_index,'x264')
except Exception, e:
    pass
new_filename = '.'.join(output_parts)
new_filename = new_filename.replace('XviD.','XviD-').replace('x264.','x264-').replace('h264.','h264-').replace('WEB.Dl','WEB-DL')
new_filename = new_filename.replace('Nine.Nine','Nine-Nine')
new_filename = new_filename[0].upper() + new_filename[1:]
#if options.verbose:
verb = "copy" if options.copy else "move"
print "will %s %r to %r" % (verb, original_filename, new_filename)
if options.move:
    import shutil
    shutil.move(original_filename, new_filename)
elif options.copy:
    import shutil
    shutil.copy(original_filename, new_filename)
