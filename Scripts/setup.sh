#!/bin/bash

# Navigate to the directory where this script is located
cd "$(dirname "$0")"
REPO_PATH=$(pwd)

# Define REAPER paths for macOS
REAPER_SCRIPTS_DIR="$HOME/Library/Application Support/REAPER/Scripts"
REAPER_EFFECTS_DIR="$HOME/Library/Application Support/REAPER/Effects/utility"

echo "--- REAPER QC Tool Studio Setup ---"

# Symlink the Scripts
echo "Linking individual scripts..."
for script_file in "$REPO_PATH/Scripts"/*.lua; do
    script_name=$(basename "$script_file")
    
    # Create a link for each one directly in the main Scripts folder
    ln -sf "$script_file" "$REAPER_SCRIPTS_DIR/Reaper QC Tool/$script_name"
done

# Create the Effects/utility directory if it doesn't exist
mkdir -p "$REAPER_EFFECTS_DIR"

# Symlink the custom JSFX
echo "Linking custom JSFX..."
ln -sf "$REPO_PATH/Effects/volume_pan_smoothed_QC" "$REAPER_EFFECTS_DIR/volume_pan_smoothed_QC"

echo "--- Setup Complete ---"
echo "1. Open REAPER."
echo "2. Open the Action List (?)."
echo "3. Click 'New action...' > 'Load ReaScript...'"
echo "4. Navigate to the 'Reaper QC Tool' folder and select your scripts."
echo ""
read -p "Press enter to close..."