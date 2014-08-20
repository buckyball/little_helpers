#!/usr/bin/env bash

BASE_DIR=/media/2tbarray/doorcam

find "$BASE_DIR" -maxdepth 1 -mtime +30 -type f -iname "*.jpg" | 
 while IFS= read -r file; do
    ## Get the file's modification year
    year=$(date -d "$(stat -c %y $file)" +%Y)
    month=$(date -d "$(stat -c %y $file)" +%b)
    [[ ! -d "$BASE_DIR/$year/$month" ]] && mkdir -p "$BASE_DIR/$year/$month"; 
    mv "$file" "$BASE_DIR/$year/$month"
done
