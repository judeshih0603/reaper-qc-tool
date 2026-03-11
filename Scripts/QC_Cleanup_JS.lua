-- @description Scans all tracks and removes the JS: Volume/Pan Smoother - QC plugin
-- @version 1.0
-- @author JS
-- @id JS_QC_Cleanup
-- @about
--   Scans all tracks and removes the JS: Volume/Pan Smoother - QC plugin
-- @provides
--   [main] .
function Main()
    local track_count = reaper.CountTracks(0)
    local removed_count = 0

    -- Loop through every track
    for i = 0, track_count - 1 do
        local track = reaper.GetTrack(0, i)
        
        -- Look for the specific JSFX
        local fx_idx = reaper.TrackFX_GetByName(track, "JS: Volume/Pan Smoother - QC", false)
        
        while fx_idx ~= -1 do
            -- Remove the plugin
            reaper.TrackFX_Delete(track, fx_idx)
            removed_count = removed_count + 1
            
            -- Check again for any remaining instances
            fx_idx = reaper.TrackFX_GetByName(track, "JS: Volume/Pan Smoother - QC", false)
        end
    end
    reaper.UpdateArrange()
end

-- Wrap in an Undo block
reaper.Undo_BeginBlock()
Main()
reaper.Undo_EndBlock("Remove QC Smoother Plugins", -1)