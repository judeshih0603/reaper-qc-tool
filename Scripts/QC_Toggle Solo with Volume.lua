-- @description QC Toggle Solo with Volume
-- @version 5.0
-- @author JS
-- @id JS_QC_TOGGLE_SOLO_VOLUME
-- @about
--   A pop-free A/B testing tool for REAPER using JSFX volume ramping and track coloring for visual feedback.
-- @provides [main] .


local FADE_TIME = 0.01 
local STEPS = 1 
local COLOR_ACTIVE = reaper.ColorToNative(0, 255, 0) -- Green
local COLOR_INACTIVE = reaper.ColorToNative(50, 50, 50) -- Dark Gray

function RampAndVisual(track, start_db, end_db, active)
    local fx_idx = reaper.TrackFX_GetByName(track, "JS: Volume/Pan Smoother - QC", false)
    if fx_idx == -1 then
        fx_idx = reaper.TrackFX_AddByName(track, "JS: Volume/Pan Smoother - QC", false, -1)
    end

    -- Update Visual Color ONLY (Keep selection unchanged)
    if active then
        reaper.SetTrackColor(track, COLOR_ACTIVE)
    else
        reaper.SetTrackColor(track, COLOR_INACTIVE)
    end

    -- Audio Ramp Logic
    local step_val = (end_db - start_db) / STEPS
    local current_step = 0
    local function FadeLoop()
        if current_step <= STEPS then
            local next_vol = start_db + (step_val * current_step)
            reaper.TrackFX_SetParam(track, fx_idx, 0, next_vol)
            current_step = current_step + 1
            reaper.defer(FadeLoop)
        end
    end
    FadeLoop()
end

function Main()
    local sel_tr = reaper.GetSelectedTrack(0, 0)
    if not sel_tr then return end
    
    local firstTrkNum = reaper.GetMediaTrackInfo_Value(sel_tr, "IP_TRACKNUMBER")
    local ruffTrk = reaper.GetTrack(0, firstTrkNum-1)
    local stemFldrTrk = reaper.GetTrack(0, firstTrkNum)
    
    if not ruffTrk or not stemFldrTrk then return end

    local fx_idx = reaper.TrackFX_GetByName(ruffTrk, "JS: Volume/Pan Smoother - QC", false)
    local current_vol = 0
    if fx_idx ~= -1 then
        current_vol = reaper.TrackFX_GetParam(ruffTrk, fx_idx, 0)
    end

    -- Toggle Logic based on current Ruff Track volume
    if current_vol > -120 then
        -- Switch to STEMS
        RampAndVisual(ruffTrk, 0, -120, false)
        RampAndVisual(stemFldrTrk, -120, 0, true)
    else
        -- Switch to RUFF
        RampAndVisual(ruffTrk, -120, 0, true)
        RampAndVisual(stemFldrTrk, 0, -120, false)
    end
    
    reaper.UpdateArrange()
end

Main()


