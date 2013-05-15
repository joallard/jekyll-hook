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
export GIT_SSH=$(echo $(pwd))/scripts/git-ssh.sh

if [ -d $source ]; then
  echo "cleaning up..."
  rm -Rf $source
fi 

echo "cloning into $giturl"
git clone $giturl $source

# Git checkout appropriate branch, pull latest code
cd $source

echo "checking out $branch..."
git checkout $branch

echo "pulling $branch..."
git pull origin $branch
cd -

# Run jekyll
script/bootstrap
script/build
cd -
