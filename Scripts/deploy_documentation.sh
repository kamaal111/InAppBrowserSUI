#!/bin/sh

#  deploy_documentation.sh
#  InAppBrowserSUI
#
#  Created by Kamaal M Farah on 10/10/2022.
#

rm -rf docs _site

yarn build:docs

npx gh-pages -b gh-pages -d docs
