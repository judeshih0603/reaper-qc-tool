# REAPER QC TOOL

A collection of Lua scripts for REAPER for click-free QC between a Ruff and Stems. This system uses JSFX-based volume ramping and visual color-coding to ensure smooth transitions without digital pops.

---

## Features
* **Automated Setup:** Automatically organizes and colors the ruffs and stems into folders
* **Pop-Free Audio:** Uses custom effect to perform micro-fades, eliminating the digital "pops" caused by instant volume jumps.
* **Visual Feedback:** Automatically colors the active track **Green** and the inactive track **Dark Gray**.
* **Automated A/B:** Includes a playback script that toggles sources every 0.3 seconds for rapid comparison.
* **Safety Integration:** Auto-stops playback if you select a different track or manually hit the spacebar.

---

## Included Scripts

| File Name | Function |
| :--- | :--- |
| **QC_Organize Audio** | Set up the Ruffs and Stems in an organized structure in Reaper. |
| **QC_Toggle Solo with Volume** | The core engine. Ramps volumes and updates track colors. |
| **QC_Auto Playback** | Starts playback from cursor and triggers the toggle every 0.3s. |
| **QC_Cleanup** | Scans the project and removes all `JS: Volume/Pan Smoother - QC` instances. |
| **QC_Solo_Setup** | Combines cleanup and track preparation. |
| **volume_pan_smoothed_QC** | (Custom Action) Modified Reaper Effect - JS: Volume/Pan Smoother. |


---

## Setup & Workflow

### 1. Installation
The entire toolkit is now distributed via ReaPack to ensure Command IDs remain consistent across all studio machines.

1.  **Install Dependencies:**
    * Download and install [ReaPack](https://reapack.com/).
    * Download and install the [SWS Extension](https://sws-extension.org/).
2.  **Import the Repository:**
    * In REAPER, go to **Extensions > ReaPack > Import repositories...**
    * Paste the following URL:  
        `https://raw.githubusercontent.com/judeshih0603/reaper-qc-tool/refs/heads/main/index.xml`
3.  **Install the Package:**
    * Go to **Extensions > ReaPack > Browse packages...**
    * Find **JS QC Tools**, right-click it, and select **Install**.
    * Click **Apply** (this will install the scripts and the custom JSFX).

### 2. Hotkey Configuration (Optional)
Open the **Actions List** (`?`) and assign the following keys:

* **A:** `QC_Solo_Setup.lua`
* **V:** `QC_Toggle Solo with Volume_JS.lua`
* **Shift + Space:** `QC_Auto Playback_JS.lua`

### 3. Usage

1. **Import:** Import midi (optional), ruffs and stems into Reaper
2. **Orgainzed:** Execute QC SETUP ACTION from toolbar
2. **Initialize:** Select the Ruff track and run **QC_Solo Setup** (press **A**). This cleans previous FX and prepares the selection.
2. **Auto QC:** Run **QC_Auto Playback_JS** (Press **Shift+Space**) to begin automated A/B switching from the cursor.
3. **Manual QC:** Run **QC_Toggle Solo with Volume_JS** (Press **V**) to manually toggle between sources at any time.
4. **Stop:** Press **Space** or select any other track to terminate the auto-toggle loop.

---

## Requirements

* **SWS Extension:** Required for advanced track selection and consolidation logic.
* **JSFX:** The system uses the included `volume_pan_smoothed_QC`. The installation is handled automatically by ReaPack.
