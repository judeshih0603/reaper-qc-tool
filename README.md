# REAPER Pop-Free QC Switcher

A collection of Lua scripts for REAPER for click-free QC between a Ruff and Stems. This system uses JSFX-based volume ramping and visual color-coding to ensure smooth transitions without digital pops.

---

## Features

* **Pop-Free Audio:** Uses `JS: Volume/Pan Smoother` to perform micro-fades, eliminating the digital "pops" caused by instant volume jumps.
* **Visual Feedback:** Automatically colors the active track **Green** and the inactive track **Dark Gray**.
* **Automated A/B:** Includes a playback script that toggles sources every 0.3 seconds for rapid comparison.
* **Safety Integration:** Auto-stops playback if you select a different track or manually hit the spacebar.

---

## Included Scripts

| Script Name | Function |
| **QC_Toggle Solo with Volume_v5** | The core engine. Ramps volumes and updates track colors. |
| **QC_Auto Playback_v1** | Starts playback from cursor and triggers the toggle every 0.3s. |
| **QC_Cleanup_v1** | Scans the project and removes all `JS: Volume/Pan Smoother` instances. |
| **QC_Solo_Setting** | (Custom Action) Combines cleanup and track preparation. |

---

## Setup & Workflow

### 1. Installation

1. Add the `.lua` scripts to your REAPER `Scripts` folder.
2. Import them into the **Actions List**.
3. Ensure `QC_Toggle Solo with Volume_v5` has a registered **Command ID** that matches the one referenced in `QC_Auto Playback_v1.lua` (currently `_RS69081a9d3a87e17d55f91aa3cc266ff4f29d4a8b`), change the Command ID if needed.

### 2. Custom Action Configuration

Create a **Custom Action** named `QC_Solo_Setting` assigned to shortcut **A**:

1. `Script: QC_Cleanup_JS_v1.lua`
2. `Track: Unsolo all tracks`
3. `Track: Toggle solo for selected tracks`
4. `Track: Go to next track`
5. `Track: Go to next track (leaving other tracks selected)`

### 3. Usage

1. **Initialize:** Select the Ruff track and press **A**. This cleans previous FX and prepares the selection.
2. **Auto QC:** Press **Shift+Space** to begin automated A/B switching from the cursor.
3. **Manual QC:** Press **V** to manually toggle between sources at any time.
4. **Stop:** Press **Space** or select any other track to terminate the auto-toggle loop.

---

## Requirements

* **JSFX:** Requires the stock REAPER plugin `JS: Volume/Pan Smoother`. The script will attempt to add it automatically if missing.
* **Track Layout:** The script logic depends on the Ruff track being exactly one index above the Stems track.
