#!/bin/bash

file2="/home/zecoa/.cache/wal/colors-last-8"
dunstfile="/home/zecoa/.config/dunst/dunstrc"

mapfile -t colors < "$file2"

if [ "${#colors[@]}" -lt 8 ]; then
  echo "Not enough colors found in $file2"
  exit 1
fi

head -n -15 /home/zecoa/.config/dunst/dunstrc > temp && mv temp /home/zecoa/.config/dunst/dunstrc

{
  cat <<EOF 
[urgency_low]
    background = "${colors[2]}"
    foreground = "${colors[6]}"
    timeout = 5

[urgency_normal]
    background = "${colors[4]}"
    foreground = "${colors[5]}"
    timeout = 5

[urgency_critical]
    background = "#900000"
    foreground = "#ffffff"
    frame_color = "#ff0000"
    timeout = 0
EOF

} >> $dunstfile

pkill dunst && dunst &
