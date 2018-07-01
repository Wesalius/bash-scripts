#!/bin/bash
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  printf "Usage: gsplitter file.pdf number_of_pages\n"
  printf "Example that splits file.pdf into chunks of 50 pages: gsplitter file.pdf 50\n"
  exit 0
fi

counter=1
file=$1
chunk=$2
fpage=1
lpage=$chunk
#count number of pdf pages in a file
pdfpages=$(pdfinfo $file | grep Pages | awk '{print $2}')
printf "PDF file is $pdfpages pages long. Splitting into chunks of $chunk pages.\n"
#iterate over the file until last page is reached
while  [ $counter -le awk 'BEGIN {rounded = $pdfpages+$chunk-1)/$chunk; print rounded}' ]; do
  #split pdf using ghostscript
  gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dFirstPage=$fpage -dLastPage=$lpage -sOutputFile=$(basename $file .pdf)_$counter.pdf $file
  let counter++
  fpage=$(( $fpage + $chunk ))
  lpage=$(( $lpage + $chunk ))
done


#the script fails on the while condition
