#!/bin/bash

BASE_PATH=$(cd $(dirname $0) && pwd -P)
VERBOSE=false
DEBUG=false

generateIMG(){
    # FIXME: test file is .tex
    file=${1%.*}
    $VERBOSE && echo "Generating SVG and PNG from $1"
    $DEBUG && OUT=/dev/stdout || OUT=/dev/null
    pdflatex -interaction=nonstopmode -output-directory=/tmp "${file}.tex" >$OUT \
      && pdf2svg "/tmp/$(basename ${file}).pdf" "${file}.svg" \
      && rsvg-convert --output "${file}.png" "${file}.svg"
    RESULT=$?
    $VERBOSE && echo "Result: $([ $RESULT == 0 ] && echo OK || echo NOK)"
}

usage(){
    echo "Usage: `basename $0` [-v] [-d] PATH..." >&2
    echo "   -v   Verbose mode" >&2
    echo "   -d   Debug mode (implies verbose)" >&2
}

while getopts vd opt; do
    case "$opt" in
        v) VERBOSE=true;;
        d) VERBOSE=true; DEBUG=true;;
        *) usage; exit 1;;
    esac
done
shift $(($OPTIND-1))
if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi

for path in "$@"; do
    if [ -d "$path" ]; then
        for file in "$path"/*; do
            generateIMG "$file"
        done
    elif [ -f "$path" ]; then
        generateIMG "$path"
    else
        echo "$path: file or folder not found"
    fi
done
