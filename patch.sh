#!/bin/bash

# Check if fontforge is installed
if ! command -v fontforge &> /dev/null; then
    echo "fontforge is not installed. Please install it first."
    exit 1
fi

# Try to use the latest version
git submodule init
git submodule update --recursive --remote --depth 1
git submodule foreach --recursive '
    git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed "s@^refs/remotes/origin/@@") ||
    git checkout main ||
    git checkout master
'

# Patch nerd font to dm-mono font
for file in dm-mono/exports/DMMono*.ttf; do
    fontforge -script ./nerd-fonts/font-patcher -c "$file" -out dm-mono-nerd-font
done
