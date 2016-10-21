#!/bin/bash

BASE_PATH=$(cd $(dirname $0) && pwd -P)

generateSVG(){
    # FIXME: test file is .tex
    file=${1%.*}
    pdflatex -output-directory=/tmp "${file}.tex" >/dev/null && pdf2svg "/tmp/$(basename ${file}).pdf" "${file}.svg"
}

if [ "$#" -eq 0 ]; then
    echo "Usage: `basename $0` PATH..." >&2
    exit 1
fi

for path in "$@"; do
    if [ -d "$path" ]; then
        for file in "$path"/*; do
            generateSVG "$file"
        done
    elif [ -f "$path" ]; then
        generateSVG "$path"
    else
        echo "$path: file or folder not found"
    fi
done
