-- @description QC Solo Setup (Macro Wrapper)
-- @version 1.0
-- @author JS
-- @id JS_QC_Solo_Setup
-- @about
--      Solo the parent folder, select the following Ruff track and the Subfolder containing the stems
-- @provides [main] .

-- This script calls your registered actions in sequence
-- reaper.Main_OnCommand(reaper.NamedCommandLookup("QC_Cleanup_JS"), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup("_RS24c44ae159d6f57afebddf7b5e69ca05b61a37dc"), 0)

reaper.Main_OnCommand(40340, 0) -- Unsolo all tracks
reaper.Main_OnCommand(7, 0) -- Toggle solo for selected tracks
reaper.Main_OnCommand(40285, 0) --Go to next track
reaper.Main_OnCommand(40287, 0) -- Go to next track (leaving other tracks selected)
