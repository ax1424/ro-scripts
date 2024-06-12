#!/usr/bin/env bash

# Directory containing wallpapers
WALLPAPER_DIR="/home/aston/wallpapers"

# Check if the directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Wallpaper directory not found: $WALLPAPER_DIR"
    exit 1
fi

# Function to display the wallpaper selection menu
select_wallpaper() {
    # Options for the menu
    options="Random\nSet\nExit"

    # Show the menu using Rofi
    chosen=$(echo -e "$options" | rofi -dmenu -i -p "Select Wallpaper:")

    # Check if the chosen option is not empty
    if [ -z "$chosen" ]; then
        echo "No option selected."
        exit 1
    fi

    # Execute the selected option
    if [[ "$chosen" == "Random" ]]; then
        select_random_wallpaper
    elif [[ "$chosen" == "Set" ]]; then
        echo "Opening Nitrogen wallpaper browser."
        nitrogen "$WALLPAPER_DIR"
    elif [[ "$chosen" == "Escape" ]]; then
        echo "Exiting."
        exit 0
    else
        echo "Invalid option selected."
        exit 1
    fi
}

# Function to handle random wallpaper selection and confirmation
select_random_wallpaper() {
    while true; do
        # Select a random wallpaper
        random_wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
        echo "Setting random wallpaper: $random_wallpaper"
        nitrogen --set-zoom-fill "$random_wallpaper"
        #nitrogen --restore

        # Ask for confirmation
        confirmation=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Are you satisfied with this wallpaper?")

        if [[ "$confirmation" == "Yes" ]]; then
            echo "Wallpaper set successfully."
            exit 0
        elif [[ "$confirmation" == "No" ]]; then
            echo "Choosing another wallpaper."
        else
            echo "No option selected."
            exit 1
        fi
    done
}

# Start the wallpaper selection process
select_wallpaper
