#!/bin/bash
set -e

if [ -z "$1" ]
then
    echo "No TeX file supplied"
    exit 1
fi

WORK_DIR="$(mktemp -d)"

# Add "\input{handwriting/main.tex}""
cat $1 | sed -e 's/\\input{handwriting\/main.tex}//g' | sed -e 's/\\begin{document}/\\input{handwriting\/main.tex}\n\\begin{document}/' | sed -e 's/{equation}/{equation\*}/g' > $WORK_DIR/main.tex
cp -r handwriting $WORK_DIR

cd $WORK_DIR
# Complie
latexmk -xelatex -interaction=nonstopmode main.tex
# Rotating by splitting and combining
mkdir split
convert -density 130 main.pdf split/page-%04d.pdf
mkdir rotated
# Note the "bash -c", without it the random numbers generated will be the same
find split -name '*.pdf' -execdir bash -c 'convert -density 130 -rotate $(seq -1 .01 1 | shuf | head -n1) {} ../rotated/{}' \;
convert -density 130 rotated/*.pdf temp.pdf
# https://gist.github.com/andyrbell/25c8632e15d17c83a54602f6acde2724
convert -density 130 temp.pdf -attenuate 0.05 +noise Multiplicative temp.pdf
# Compress. https://askubuntu.com/a/256449/1088053
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=output.pdf temp.pdf

cd -
cp $WORK_DIR/output.pdf .
