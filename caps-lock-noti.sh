#!/usr/bin/env bash


#sudo evtest /dev/input/event3 | grep "LED_CAPSL" | while read -r line; do
#    echo "$line" >> temp.txt
#done



DEVICE="/dev/input/event3"  # change this to your actual keyboard input device
LOG="/tmp/capslock.log"

sudo evtest "$DEVICE" | grep --line-buffered -o "LED_CAPSL.*" | while read -r line; do
    echo "$line" | tee "$LOG"
    content=$(< $LOG)
    if [[ "$content" = "LED_CAPSL) state 0" || "$content" = "LED_CAPSL), value 0" ]]; then
      notify-send "Caps Lock OFF" -r 9365 -i "/usr/share/icons/Qogir/24/panel/caps-lock-off.svg"
    elif [[ "$content" = "LED_CAPSL) state 1" || "$content" = "LED_CAPSL), value 1" ]]; then
      notify-send "Caps Lock ON" -r 9365 "/usr/share/icons/Qogir/24/panel/caps-lock-on.svg"
    fi
done

