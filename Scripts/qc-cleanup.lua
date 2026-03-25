-- @description Scans all tracks and removes the JS: Volume/Pan Smoother - QC plugin
-- @version 1.0
-- @author @hellojudes
-- @id JS_QC_Cleanup
-- @about
--   Scans all tracks and removes the JS: Volume/Pan Smoother - QC plugin
-- @provides [main] .
local function main()
    local trackCount = reaper.CountTracks(0)
    local removedCount = 0

    -- Loop through every track
    for i = 0, trackCount - 1 do
        local track = reaper.GetTrack(0, i)
        
        -- Look for the specific JSFX
        local fxId = reaper.TrackFX_GetByName(track, "JS: Volume/Pan Smoother - QC", false)
        
        while fxId ~= -1 do
            -- Remove the plugin
            reaper.TrackFX_Delete(track, fxId)
            removedCount = removedCount + 1
            
            -- Check again for any remaining instances
            fxId = reaper.TrackFX_GetByName(track, "JS: Volume/Pan Smoother - QC", false)
        end
    end
    reaper.UpdateArrange()
end

-- Wrap in an Undo block
reaper.Undo_BeginBlock()
main()
reaper.Undo_EndBlock("Remove QC Smoother Plugins", -1)