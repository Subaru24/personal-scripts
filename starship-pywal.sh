#!/bin/bash

file2="/home/zecoa/.cache/wal/colors-last-8"
starfile="/home/zecoa/.config/starship.toml"


mapfile -t colors < "$file2"

if [ "${#colors[@]}" -lt 8 ]; then
  echo "Not enough colors found in $file2"
  exit 1
fi

tail -n +31 "$starfile" > star_tail.tmp

{
  cat <<EOF 
format = """\\
[](bg:#6A55ED00 fg:${colors[2]})\\
[  ](bg:${colors[2]}  fg:#120914)\\
[](fg:${colors[2]} bg:${colors[1]})\\
[](fg:${colors[1]} bg:${colors[3]})\\
\$directory\\
[](fg:${colors[3]} bg:${colors[6]})\\
\$git_branch\\
\$git_status\\
\$git_metrics\\
[](fg:${colors[6]} bg:#3CE3DB00)\\
\$character\\
"""
[directory]
format = "[ \$path ](\$style)"
style = "fg:#e8dbdb bg:${colors[3]}"

[git_branch]
format = '[ \$symbol\$branch(:\$remote_branch) ](\$style)'
symbol = "  "
style = "fg:#1C3A5E bg:${colors[6]}"

[git_status]
format = '[\$all_status](\$style)'
style = "fg:#1C3A5E bg:${colors[6]}"

[git_metrics]
format = "([+\$added](\$added_style))[](\$added_style)"
added_style = "fg:#1C3A5E bg:${colors[6]}"

EOF
  cat star_tail.tmp
} > temp && mv temp "$starfile" && rm star_tail.tmp
# hello
