#!/usr/bin/env bash

# Merge changes in all chapters forward

set -uxfe

for i in {1..8}
do
  git checkout "part0${i}"
  git merge --no-edit "part0$((i-1))"
done

git checkout master
git merge --no-edit part08
