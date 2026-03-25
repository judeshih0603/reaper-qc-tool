-- @description QC Toggle Solo with Volume
-- @version 5.0
-- @author JS
-- @id JS_QC_TOGGLE_SOLO_VOLUME
-- @about
--   A pop-free A/B testing tool for REAPER using JSFX volume ramping and track coloring for visual feedback.
-- @provides [main] .


local fadeTime = 0.01 
local steps = 1 
local colorActive = reaper.ColorToNative(0, 255, 0) -- Green
local colorInactive = reaper.ColorToNative(50, 50, 50) -- Dark Gray

local function rampAndVisual(track, startDb, endDb, active)
    local fxId = reaper.TrackFX_GetByName(track, "JS: Volume/Pan Smoother - QC", false)
    if fxId == -1 then
        fxId = reaper.TrackFX_AddByName(track, "JS: Volume/Pan Smoother - QC", false, -1)
    end

    -- Update Visual Color ONLY (Keep selection unchanged)
    if active then
        reaper.SetTrackColor(track, colorActive)
    else
        reaper.SetTrackColor(track, colorInactive)
    end

    -- Audio Ramp Logic
    local DbPerStep = (endDb - startDb) / steps
    local currentStep = 0
    local function fadeLoop()
        if currentStep <= steps then
            local nextDb = startDb + (DbPerStep * currentStep)
            reaper.TrackFX_SetParam(track, fxId, 0, nextDb)
            currentStep = currentStep + 1
            reaper.defer(fadeLoop)
        end
    end
    fadeLoop()
end

local function main()
    local selectedTrk = reaper.GetSelectedTrack(0, 0)
    if not selectedTrk then return end
    
    local firstTrkNum = reaper.GetMediaTrackInfo_Value(selectedTrk, "IP_TRACKNUMBER")
    local ruffTrk = reaper.GetTrack(0, firstTrkNum-1)
    local stemFldrTrk = reaper.GetTrack(0, firstTrkNum)
    
    if not ruffTrk or not stemFldrTrk then return end

    local fxId = reaper.TrackFX_GetByName(ruffTrk, "JS: Volume/Pan Smoother - QC", false)
    local currentVol = 0
    if fxId ~= -1 then
        currentVol = reaper.TrackFX_GetParam(ruffTrk, fxId, 0)
    end

    -- Toggle Logic based on current Ruff Track volume
    if currentVol > -120 then
        -- Switch to STEMS
        rampAndVisual(ruffTrk, 0, -120, false)
        rampAndVisual(stemFldrTrk, -120, 0, true)
    else
        -- Switch to RUFF
        rampAndVisual(ruffTrk, -120, 0, true)
        rampAndVisual(stemFldrTrk, 0, -120, false)
    end
    
    reaper.UpdateArrange()
end

main()


