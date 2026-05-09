#!/bin/bash
choice=$(echo -e "Shutdown\nReboot\nSleep" | wofi --dmenu --prompt "Power")

case $choice in
    Shutdown) systemctl poweroff ;;
    Reboot) systemctl reboot ;;
    Sleep) systemctl suspend ;;
esacy