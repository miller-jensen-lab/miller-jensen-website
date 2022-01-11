#!/bin/sh

# Exit on error or unset var
set -e
set -u

usage() {
    printf "Creates a PNG thumbnail of a paper given a PMID. Puts it in the static/img/publications folder.\n" ""
    printf "Usage: $0 PMID\n" ""
}

# Make sure the user supplied a PMID
if [ "$#" -ne 1  -a "$#" -ne 2 ]; then
    usage
    exit 1
fi

PMID="$1"
FILE="$2"


# Make temp file and delete it in event of crash
temp_dir=$(mktemp -d)
temp_file="$temp_dir/$PMID.pdf"
trap "rm -rf $temp_dir" 0 2 3 15

if [ "$#" -eq 2 ]; then
    cp "$FILE" "$temp_file"
fi

if [ "$#" -eq 1 ]; then
    # Convert the PMID to a DOI
    URL="https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=$PMID&tool=my_tool&email=my_email@example.com&retmode=xml"
    DOI=$(curl -L -s $URL | \
        grep '"doi"'| \
        head -n1| \
        sed 's/.*" *>//;s/<.*//'
    )
    printf "✅ Found DOI %s for PMID %s\n" "$DOI" "$PMID"

    printf "✅ Contacting sci-hub...\n" ""
    PDF_URL=$(curl -L -s "https://sci-hub.do/$DOI" |
        grep "iframe.*src" |
        sed 's/.*src *= *"//;s/".*//;s@^//@http://@'
    )
    if [ -z "$PDF_URL" ]; then
        printf "⚠️ Cannot find PDF URL on Sci-Hub ;(\n" ""
        exit 1
    fi
    printf "✅ Found PDF URL %s\n" "$PDF_URL"

    curl -L -s -o $temp_file "$PDF_URL"
    printf "✅ Downloaded PDF to %s\n" "$temp_file"
fi

# Get the path to this script on the filesystem
PATH_TO_SCRIPT="$( cd "$( dirname "$0" )" && pwd )"


IMG_WIDTH=97
OUTPUT_DESTINATION="$(cd $PATH_TO_SCRIPT/../static/img/publications && pwd)/$PMID.png"
PNG_OUTPUT="$temp_dir/raw.png"
COMPRESSED_PNG="$temp_dir/compressed.png"
sips -s format png "$temp_file" --out "$PNG_OUTPUT" --resampleWidth $IMG_WIDTH >/dev/null

DID_COMPRESSION=""
if [ -z "$DID_COMPRESSION" ] && [ -x "$(command -v zopflipng)" ]; then
    zopflipng -y "$PNG_OUTPUT" "$COMPRESSED_PNG" >/dev/null
    DID_COMPRESSION="zopflipng"
fi
if [ -z "$DID_COMPRESSION" ] && [ -x "$(command -v pngcrush)" ]; then
    pngcrush -ow "$PNG_OUTPUT" "$COMPRESSED_PNG"
    DID_COMPRESSION="pngcrush"
fi
if [ -z "$DID_COMPRESSION" ]; then
    mv "$PNG_OUTPUT" "$COMPRESSED_PNG"
else
    printf "✅ Compressed png with %s\n" "$DID_COMPRESSION"
fi


mv "$COMPRESSED_PNG" "$OUTPUT_DESTINATION"
printf "✅ Wrote PNG thumbnail to %s \n" "$OUTPUT_DESTINATION"
printf "✅ Exiting a cleaning up 😃\n" ""
