#!/bin/bash
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  printf "Script for batch OCR from PDF using ImageMagick and Tesseract.\n"
  printf "Usage: put the script into the directory with PDFs and run it.\n"
  exit 0
fi

counter=0
filescount=$(ls -1 *.pdf| wc -l)
printf "Script for batch OCR from PDF using ImageMagick and Tesseract.\n"
printf "Total number of PDF files in this directory is $filescount.\n"
for file in *.pdf; do
    outfile="$(basename "$file" .pdf)"
    # Use ImageMagick to convert the PDF to a high-res multi-page TIFF.
    printf "Converting $file to TIFF with ImageMagick.\n"
    convert -density 300 "$file" -depth 8 -strip -background white \
            -alpha off ./temp.tiff
    # Use Tesseract to perform OCR on the TIFF.
    printf "Attempting OCR with: "
    tesseract ./temp.tiff "$outfile" -l ces
    # Discard the intermediate TIFF file.
    rm ./temp.tiff
    let counter++
    printf "PDF number $counter from $filescount is done.\n\n"
done

#######################################################
#  Script that converts the PDFs in scripts directory.
#  to TIFFs and attempts to perform OCR with Tesseract.
#  To use this script:
#   - put the script in folder with the PDFs
#   - make the script executable with chmod +x
#   - run it with ./script.sh
#  For different languages change the tesseract option.
