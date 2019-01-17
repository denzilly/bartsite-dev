#!/bin/bash
echo "Building site files"
cd /home/bart/bartsite-files/bartsite-dev/bartsite-dev/
bundle exec jekyll build
echo "Site files built"

yes | cp -rf /home/bart/bartsite-files/bartsite-dev/bartsite-dev/_site/. /home/bart/bartsite-files/bartsite-deploy/denzilly.github.io/
echo "Site files copied"
