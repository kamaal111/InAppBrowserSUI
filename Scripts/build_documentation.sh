#!/bin/sh

#  build_documentation.sh
#  InAppBrowserSUI
#
#  Created by Kamaal M Farah on 10/10/2022.
#

ARCHIVE_PATH="doc_archives"
APP_NAME="InAppBrowserSUI"
DERIVED_DATA_PATH="docs_derived_data"
BUILD_DESTINATION="platform=iOS Simulator,name=iPhone 14 Pro"
OUTPUT_DIRECTORY="docs"

mkdir -p $ARCHIVE_PATH $DERIVED_DATA_PATH $OUTPUT_DIRECTORY

xcodebuild -workspace $APP_NAME.xcworkspace -derivedDataPath $DERIVED_DATA_PATH -scheme $APP_NAME -destination "$BUILD_DESTINATION" -parallelizeTargets docbuild

cp -R `find $DERIVED_DATA_PATH -type d -name "*.doccarchive"` $ARCHIVE_PATH

for ARCHIVE in $ARCHIVE_PATH/*.doccarchive; do
    cmd() {
        echo "$ARCHIVE" | awk -F'.' '{print $1}' | awk -F'/' '{print tolower($2)}'
    }
    ARCHIVE_NAME="$(cmd)"
    echo "Processing Archive: $ARCHIVE"
    $(xcrun --find docc) process-archive transform-for-static-hosting "$ARCHIVE" --hosting-base-path $APP_NAME/$ARCHIVE_NAME --output-path $OUTPUT_DIRECTORY/$ARCHIVE_NAME
done
