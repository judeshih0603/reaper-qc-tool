-- @description Automatcally switch between ruffs and stems track
-- @version 1.1
-- @author @hellojudes
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
local initialTrack = reaper.GetSelectedTrack(0, 0)
if not initialTrack then
    reaper.ShowMessageBox("Please select a track before starting QC.", "Error", 0)
    return
end

-- Start playback from cursor
reaper.SetEditCurPos(cursor_pos, false, false)
reaper.OnPlayButton()


-- Look for custom command (QC_Toggle Solo with Volume.lua)
local switchCommand = reaper.NamedCommandLookup("_RS7c9b92ebf8010f1bef7324d3cddc72baf1eb9d15")

if switchCommand == 0 then
    reaper.ShowMessageBox("Could not find the 'QC_Toggle Solo with Volume.lua' command.", "Error", 0)
    reaper.OnStopButton()
    return
end

-- Timer setup
local interval = 0.3 -- seconds between triggers
local lastTriggerTime = reaper.time_precise()
local isRunning = true

-- Function to stop everything cleanly
local function StopAll()
    if not isRunning then return end
    isRunning = false
    reaper.OnStopButton()
    reaper.UpdateArrange()
end

-- main loop
local function main()
    if not isRunning then return end

    -- Check if playback was stopped manually by the user
    if (reaper.GetPlayState() & 1) == 0 then
        StopAll()
        return
    end

    local now = reaper.time_precise()

    -- Detect track change safety
    local currentTrack = reaper.GetSelectedTrack(0, 0)
    if currentTrack ~= initialTrack then
        reaper.OnStopButton() -- Stop playback if user clicks away
        StopAll()
        return
    end

    -- Trigger the switch periodically
    if now - lastTriggerTime >= interval then
        reaper.Main_OnCommand(switchCommand, 0)
        lastTriggerTime = now
    end

    reaper.defer(main)
end

reaper.defer(main)



