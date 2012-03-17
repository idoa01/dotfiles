#!/bin/bash
find ~/source/linking/trunk/ | grep sql | grep -v svn | grep -v target | grep -v bin | grep -v ".swp" | xargs grep --color -n $@
