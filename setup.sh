#!/bin/bash

# Navigate to the directory where this script is located
cd "$(dirname "$0")"
REPO_PATH=$(pwd)

# Define REAPER paths for macOS
REAPER_QC_SCRIPTS_DIR="$HOME/Library/Application Support/REAPER/Scripts/Reaper QC Tool"
REAPER_EFFECTS_DIR="$HOME/Library/Application Support/REAPER/Effects/utility"

echo "--- REAPER QC Tool Studio Setup ---"

mkdir -p "$REAPER_QC_SCRIPTS_DIR"
mkdir -p "$REAPER_EFFECTS_DIR"

# Copy the custom JSFX
# The -f flag forces an overwrite if the file already exists.
if [ -f "$REPO_PATH/Effects/volume_pan_smoothed_QC" ]; then
    echo "Installing custom JSFX..."
    cp -f "$REPO_PATH/Effects/volume_pan_smoothed_QC" "$REAPER_EFFECTS_DIR/volume_pan_smoothed_QC"
fi

# Copy scripts into the subfolder
echo "Installing scripts into 'Reaper QC Tool' folder..."
for script_file in "$REPO_PATH/Scripts"/*.lua; do
    # Get the filename
    script_name=$(basename "$script_file")
    cp -f "$script_file" "$REAPER_QC_SCRIPTS_DIR/$script_name"
done


echo "--- Setup Complete ---"
echo "1. Open REAPER."
echo "2. Open the Action List (?)."
echo "3. Click 'New action...' > 'Load ReaScript...'"
echo "4. Navigate to the 'Reaper QC Tool' folder and select your scripts."
echo "Opening folder for Action List import..."
open "$REAPER_QC_SCRIPTS_DIR"
read -p "Press enter to close..."

