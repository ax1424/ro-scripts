#!/usr/bin/env bash

# Directory containing wallpapers
WALLPAPER_DIR="/home/aston/wallpapers"

# Function to select and set a random wallpaper
select_and_set_random_wallpaper() {
    while true; do
        random_wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
        echo "Setting random wallpaper: $random_wallpaper"
        nitrogen --set-zoom-fill "$random_wallpaper" --save

        # Ask for confirmation
        confirmation=$(echo -e "Yes\nNo" | dmenu -l 2 -i -p "Are you satisfied with this wallpaper?")

        if [[ "$confirmation" == "Yes" ]]; then
            echo "Wallpaper set successfully."
            break
        elif [[ "$confirmation" == "No" ]]; then
            echo "Choosing another wallpaper."
        else
            echo "No option selected."
            exit 1
        fi
    done
}

# Function to display the wallpaper selection menu
select_wallpaper() {
    while true; do
        # Options for the menu
        options="Set\nRandom\nExit"

        # Show the menu using dmenu
        chosen=$(echo -e "$options" | dmenu -l 3 -i -p "Select Wallpaper:")

        # Check if the chosen option is not empty
        if [ -z "$chosen" ]; then
            echo "No option selected."
            exit 1
        fi

        # Execute the selected option
        if [[ "$chosen" == "Set" ]]; then
            echo "Opening Nitrogen wallpaper browser."
            nitrogen "$WALLPAPER_DIR" --save
            break
        elif [[ "$chosen" == "Random" ]]; then
            select_and_set_random_wallpaper
            break
        elif [[ "$chosen" == "Exit" ]]; then
            echo "Exiting."
            exit 0
        else
            echo "Invalid option selected."
            exit 1
        fi
    done
}

# Start the wallpaper selection process
select_wallpaper
