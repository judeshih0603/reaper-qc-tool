-- @description Automatcally switch between ruffs and stems track
-- @version 1.1
-- @author JS
-- @id JS_QC_Auto_Playback
-- @about
--   "QC_Toggle Solo with Volume_v1.lua" every 0.3 sec until stopped or if another track is selected.
-- @provides [main] .


-- Stop playback if currently playing
if reaper.GetPlayState() & 1 == 1 then
    reaper.OnStopButton()
    reaper.UpdateTimeline()
end

-- Get cursor position
local cursor_pos = reaper.GetCursorPosition()

-- Get the initially selected track (The QC "Master" track)
local initial_track = reaper.GetSelectedTrack(0, 0)
if not initial_track then
    reaper.ShowMessageBox("Please select a track before starting QC.", "Error", 0)
    return
end

-- Start playback from cursor
reaper.SetEditCurPos(cursor_pos, false, false)
reaper.OnPlayButton()


-- Look for custom command (QC_Toggle Solo with Volume.lua)
local switch_command = reaper.NamedCommandLookup("_RS6c53c5a4020a5c6c8e0b30429f38394f494ccac9")

if switch_command == 0 then
    reaper.ShowMessageBox("Could not find the 'QC_Toggle Solo with Volume.lua' command.", "Error", 0)
    reaper.OnStopButton()
    return
end

-- Timer setup
local interval = 0.3 -- seconds between triggers
local last_trigger_time = reaper.time_precise()
local is_running = true

-- Function to stop everything cleanly
local function StopAll()
    if not is_running then return end
    is_running = false
    reaper.OnStopButton()
    reaper.UpdateArrange()
end

-- Main loop
local function Main()
    if not is_running then return end

-- Check if playback was stopped manually by the user
    if (reaper.GetPlayState() & 1) == 0 then
        StopAll()
        return
    end

    local now = reaper.time_precise()

    -- Detect track change safety
    local current_track = reaper.GetSelectedTrack(0, 0)
    if current_track ~= initial_track then
        reaper.OnStopButton() -- Stop playback if user clicks away
        StopAll()
        return
    end

    -- Trigger the switch periodically
    if now - last_trigger_time >= interval then
        reaper.Main_OnCommand(switch_command, 0)
        last_trigger_time = now
    end

    reaper.defer(Main)
end

reaper.defer(Main)



