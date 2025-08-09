#!/bin/bash

UNZIP_DIR="temp/*/otfs/*"

echo "Installing fontawesome..."
curl https://use.fontawesome.com/releases/v7.0.0/fontawesome-free-7.0.0-desktop.zip?_gl=1*18fnv93*_ga*MTQ1MjU4OTk0Ni4xNzU0Njk2NjE1*_ga_BPMS41FJD2*czE3NTQ2OTY2MTUkbzEkZzEkdDE3NTQ2OTcwMDYkajYwJGwwJGgw -o fonts

echo "Extracting fontawesome files..."
unzip -q fonts -d temp
rm fonts

echo "Moving to fonts directory..."
mkdir fonts
mv $UNZIP_DIR fonts
rm temp

echo "Installing fonts..."

# find os
if [[ $OSTYPE == 'darwin'* ]]; then
  FONT_DIR="$HOME/Library/Fonts"
  cp fonts/* $FONT_DIR
  echo "All done :)"
elif [ $OSTYPE == 'linux-gnu' ]; then
  FONT_DIR="$HOME/.local/share/fonts"
  cp fonts/* $FONT_DIR
  echo "All done :)"
else
  echo "You are either on Windows or some OS that I don't know."
  echo "Sorry, I don't know how to automatically install fonts through that OS :( so please install them manually." 
fi
