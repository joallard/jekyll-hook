#!/bin/bash
set -e

echo $SSH_KEY > ssh_key

# This script is meant to be run automatically
# as part of the jekyll-hook application.
# https://github.com/developmentseed/jekyll-hook

repo=$1
branch=$2
owner=$3
giturl=$4
source=$5
build=$6

# Check to see if repo exists. If not, git clone it
if [ ! -d $source ]; then
    echo "cloning into $giturl"
    ssh -i $(echo $(pwd))/ssh_key git clone $giturl $source
fi

# Git checkout appropriate branch, pull latest code
cd $source
git checkout $branch
git pull origin $branch
cd -

# Run jekyll
cd $source
jekyll $source $build --no-server --no-auto
cd -
