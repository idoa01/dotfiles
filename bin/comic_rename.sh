#!/bin/bash

OPTS="v"
while getopts n flag; do
    case $flag in
        n)
            OPTS=$OPTS$flag
            ;;
        ?)
            exit;
            ;;
    esac
done
shift $(($OPTIND - 1))
rename -$OPTS 's/([a-zA-Z_ ]*)[_ ]([0-9]*).*(20\d\d).*/$2_$1_$2_$3.cbr/' $1
