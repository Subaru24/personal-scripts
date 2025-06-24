#!/bin/bash

file="/home/zecoa/.cache/wal/colors"
file2="/home/zecoa/.cache/wal/colors-last-8"

tail -n 8 "$file" > "$file2"

/home/zecoa/scripts/starship-pywal.sh;
/home/zecoa/scripts/dunst-pywal.sh

