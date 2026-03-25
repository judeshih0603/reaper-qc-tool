# REAPER QC TOOL

A collection of Lua scripts and custom JSFX for REAPER designed for click-free QC between "Ruff" and "Stem" printed from Bear's TEMPLATE. This system uses JSFX-based volume ramping and visual color-coding to ensure smooth transitions without digital pops during film scoring sessions.

---

## Features
* **Automated Setup:** Organizes, colors, and builds folders for your ruffs and stems instantly.
* **Pop-Free Audio:** Uses a modified `volume_pan_smoothed_QC` JSFX to perform micro-fades, eliminating digital "pops".
* **Visual Feedback:** Automatically colors the active track **Green** and the inactive track **Dark Gray**.
* **Automated A/B:** Includes a playback script that toggles sources every 0.3 seconds for rapid comparison.
* **Hard Installation:** Copies files directly to your REAPER Application Support folder so they remain functional even if the repository is moved.

---

## Included Scripts & Plugins

| File Name | Function |
| :--- | :--- |
| **qc-solo-setup** | Runs cleanup and initializes the solo workflow. |
| **qc-organize-audio** | Organizes tracks into folders and colors them (Single Undo). |
| **qc-toggle-solo-with-volume** | Ramps volumes and updates colors. |
| **qc-auto-playback** | Toggles sources every 0.3s during playback. |
| **volume_pan_smoothed_QC** | The custom JSFX engine (installed to `/Effects/utility/`). |

---

## Setup & Workflow

### 1. Installation (SSH & Local Copy)
This toolkit is distributed via a private repository. Your public SSH key must be added as a **Deploy Key** by the repository owner before you can proceed.

1.  **Clone the Repository:**
    Open your terminal and run:
    `git clone git@github.com:Sparks-and-Shadows/reaper-qc-tool.git`
2.  **Run the Installer:**
    * Run the setup.sh script.
3.  **Import into REAPER:**
    * A Finder window will automatically open to the `Reaper QC Tool` folder upon completion.
    * In REAPER, open the **Action List** (`?`).
    * Click **New action... > Load ReaScript...** and select all `.lua` files in that folder.

---

### 2. Hotkey Configuration (Optional)
Assign the following keys in the REAPER Action List for the intended workflow:

* **A:** `qc-solo-setup.lua`
* **V:** `qc-toggle-solo-with-volume.lua`
* **Shift + Space:** `qc-auto-playback.lua`

Assign **qc-organize-audio** to the main toolbar or a key

---

### 3. Usage

1. **Import:** Import midi (optional), ruffs and stems into Reaper
2. **Orgainzed:** Execute **qc-organize-audio** from toolbar
2. **Solo Setup:** Select a parent folder track (e.g., STRINGS) and run **qc-solo-setup** (press **A**). This cleans previous FX and prepares the selection. The Ruff track and the subfolder containing stems will be selected.
2. **Auto QC:** Run **qc-auto-playback_JS** (Press **Shift+Space**) to begin automated A/B switching from the cursor.
3. **Manual QC:** Run **qc-toggle-solo-with-volume_JS** (Press **V**) to manually toggle between sources at any time.
4. **Stop:** Press **Space** or select any other track to terminate the auto-toggle loop.

---

## Requirements
* **macOS:** Designed specifically for REAPER on macOS (Intel or Apple Silicon).
* **SWS Extension:** Required for advanced track selection and folder logic.

---

