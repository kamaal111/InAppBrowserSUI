#!/bin/sh

#  preview_documentation.sh
#  InAppBrowserSUI
#
#  Created by Kamaal M Farah on 10/10/2022.
#

swift build --target InAppBrowserSUI -Xswiftc -emit-symbol-graph -Xswiftc -emit-symbol-graph-dir -Xswiftc .build

$(xcrun --find docc) preview InAppBrowserSUI.docc --fallback-display-name InAppBrowserSUI --fallback-bundle-identifier io.kamaal.InAppBrowserSUI --fallback-bundle-version 1 --additional-symbol-graph-dir .build
