#!/usr/bin/env bash

# Define the options
options="Logout\nShutdown\nReboot\nExit"

# Show the menu using Rofi
chosen=$(echo -e "$options" | dmenu -l 4 -i -p "System Menu:")

# Execute the selected option
case "$chosen" in
    Logout)
        echo "awesome.quit()" | awesome-client
        qtile cmd-obj -o cmd -f shutdown
        ;;
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Escape)
        echo "Exiting."
        exit 0
        ;;
    *)
        echo "Invalid option selected."
        ;;
esac
