#!/bin/sh

#  build_documentation.sh
#  InAppBrowserSUI
#
#  Created by Kamaal M Farah on 10/10/2022.
#

DERIVED_DATA_PATH=".build/plugins/Swift-DocC/outputs/"
OUTPUT_DIRECTORY="docs"

mkdir -p $OUTPUT_DIRECTORY _site

swift package generate-documentation

for ARCHIVE in $DERIVED_DATA_PATH/*.doccarchive; do
    cmd() {
        echo "$ARCHIVE" | awk -F'.' '{print $1}' | awk -F'/' '{print tolower($2)}'
    }
    ARCHIVE_NAME="$(cmd)"
    echo "Processing Archive: $ARCHIVE"
    $(xcrun --find docc) process-archive transform-for-static-hosting "$ARCHIVE" \
        --output-path _site \
        --hosting-base-path /
done
