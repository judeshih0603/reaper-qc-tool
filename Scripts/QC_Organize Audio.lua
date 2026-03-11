-- @description Set up the Ruffs and Stems in an organized structure in Reaper for QC purposes
-- @version 6.0
-- @author JS
-- @about
--   The script groups the corresponding stems and ruff into folders based on the names in Bear's Submix Auxes and Ruffs.
-- @provides [main] .


function Main()
  -- select all tracks
  reaper.Main_OnCommand(40296, 0)--Track: Select all Tracks
  -- Function to generate a random color
function random_color()
  local r = math.random(1, 255)
  local g = math.random(1, 255)
  local b = math.random(1, 255)
  return reaper.ColorToNative(r, g, b) -- Convert to REAPER's color format
end
  
    
  -- this tables contain words that script uses to filter, feel free to add your own words!
  -- BUT BE CAREFUL, script doesn`t use full-match, it`s more like "does the track name contains this word?"
  -- e.g. if track name is kick12345-abcdefg-159846 it will match with "kick" from namesOfDrumTracks
  -- so if you add for example "T" as a word in same table, it wouldn`t work correctly!
  -- size of letters doesn`t matter
  namesOfPercBigTracks = {"RuffPercBig", "shimes", "frames", "middrums", "kick", "snare", "tom", "PercBig", "LowDrums", "Taikos", "BassDrum", "timp", "loops" }
  namesOfPercSmallTracks = {"PercSmall", "scrapes" , "Japanese", "Changs", "Cymbs", "Rims", "Metal", "Shakers", "Perc Small", "Tambourine", "Triangle", "Wood", "Ambient", "MarkTree" , "Junk", "GreekSmall", "Perc Japanese"}
  namesOfStringTracks = {"Strs", "Str" , "OrchLong" , "OrchFx Strs" }
  namesOfChoirTracks = {"voc", "vox", "choir"}
  --namesOfSynthTracks = { "RuffSynth", "SynthLead", "Synth1", "Synth2", "Synth3", "Synth4", "Synth5", "SynthArp", "Elec Hits"}
  namesOfGuitarTracks = {"GTR", "guitar"}
  namesOfPitchedTracks = {"piano" , "Mallet" , "Dulcimer" , "Pitched" , "celeste"}
  namesOfBrassTracks = {"Brs"}
  namesOfWwsTracks = {"Wws", "Ww" }
  namesOfHarpTracks = {"Harp" }
  namesOfvdgTracks = {"vdg"}
  namesOfvcTracks = {"Qtet" , "Vc"}
  namesOfTanburTracks = {"Tanbur"}
  namesOfFiddleTracks = {"Fiddle"}
  namesOfPercDumbeksTracks = {"Dumbeks"}
  namesOfNyckTracks = {"Nyck"}
  namesOfGadulkaTracks = {"Gadulka"}
  namesOfOrchFxTracks = {"Bartok", "RuffOrchFx" , "OrchFx Misc"}
  namesOfBoneFluteTracks = { "Ethnc" , "BoneFlute" , "FxEthnic" }
  namesOfBagpipesTracks = { "Bagpipes" , "Bagpipe" }
 -- namesOfSynth8bitTracks = { "SynthNES", "NoiseNES", "SEGA", "8Bit" }
 -- namesOfSynth16bitTracks = { "SNES", "SEGA", "16Bit" }  
  namesOfGtrBouzoukiTracks = { "Bouzouki" }
  namesOfDrumTracks = { "Drm", "Drumkit" }
  namesOfPercElecTracks = { "#Elec", "PercElec" }
  namesOfCitharaTracks = { "Cithara" }
  namesOfBassTracks = { "RuffBass", "#Bass " }
  namesOfSoloVlnTracks = { "SoloVln", "ElecVln", "Solo Vln" }  
  namesOfSnareTracks = { "Snare", }
  namesOfSynthTracks = { "Synth", "SynthArp"}


  -- this variables contain names of parent(folder) tracks
  -- edit them if you want, by putting a word between quotation marks ""
  -- e.g. default: drumsParentTrackName = "DRUMS" 
  --      edited:  drumsParentTrackName = "MY DRUMS"
  guitarsParentTrackName = "GUITARS"
  stringsParentTrackName = "STRINGS"
  WwsParentTrackName = "WWS"
  pitchedParentTrackName = "PITCHED"
  brassParentTrackName = "BRASS"
  PercBigParentTrackName = "PERC BIG"
  choirParentTrackName = "CHOIR"
  PercSmallParentTrackName = "PERC SMALL"
  HarpParentTrackName = "HARPS"
  vdgParentTrackName = "SOLO VDG"
  vcParentTrackName = "SOLO VC"
  tanburParentTrackName = "SOLO TANBUR"
  fiddleParentTrackName = "SOLO FIDDLE"
  nyckParentTrackName = "SOLO NYCKELHARPA"
  percDumbekstTrackName = "PERC DUMBEKS"
  gadulkaTrackName = "SOLO GADULKA"
  orchfxTrackName = "ORCH FX"
  bonefluteTrackName = "BONE FLUTES"
  bagpipesTrackName = "SOLO BAGPIPES"
  --synth8bitTrackName = "SYNTH 8 BIT"
  --synth16bitTrackName = "SYNTH 16 BIT"
  gtrBouzoukiTrackName = "GTR BOUZOUKI"
  drumTrackName = "DRUM"
  percElecTrackName = "PERC ELEC"
  citharaTrackName = "CITHARA"
  bassParentTrackName = "BASS"
  soloVlnParentTrackName = "SOLO VLN"
  snareParentTrackName = "SNARE"
  synthsParentTrackName = "SYNTHS"

  -- this variables contain colors of folders is RGB
  -- edit this to set your own color
  guitarsColor = random_color()
  stringsColor = random_color()
  WwsColor   = random_color()
  pitchedColor  = random_color()
  brassColor  = random_color()
  percbigColor   = random_color()
  choirColor  = random_color()
  percsmallColor   = random_color()
  harpColor   = random_color()
  vdgColor   = random_color()
  vcColor   = random_color()
  tanburColor = random_color()
  fiddleColor = random_color()
  nyckColor = random_color ()
  gadulkaColor = random_color()
  orchfxColor = random_color()
  bonefluteColor = random_color()
  bagpipesColor = random_color()
  --synth8bitColor = random_color()
  --synth16bitColor = random_color()
  gtrBouzoukiColor = random_color()
  drumColor = random_color()
  percElecColor = random_color()
  citharaColor = random_color()
  bassColor = random_color()
  soloVlnColor = random_color()
  snareColor = random_color()
  synthsColor  = random_color()

  -- whoever you are, better DON`T change it!
  commandID = reaper.NamedCommandLookup("_SWS_MAKEFOLDER")-- this variable holds the sws command ID
  moveToTopCommand = reaper.NamedCommandLookup("_RS0c82ca99c16b6b0fc43ab21e815fb7e9765efa14")
  -- whoever you are, better DON`T change it!
  tracksIndexesThatUserSelected = {} -- that table holds indexes of tracks that user selected + parent tracks that are created
                                     -- by the script
  
  
  -- THIS SECTION FROM HERE ----------------------------------------------------------------
  -- is used to insert indexes of all tracks that user selected, to table(tracksToSelect)    
                                               
  numberOfTracks = reaper.CountSelectedTracks(0)
                                          
  for i = 0,numberOfTracks-1,1 do
    track = reaper.GetTrack(0,i) 
    index = reaper.GetMediaTrackInfo_Value(track,"IP_TRACKNUMBER")
    table.insert(tracksIndexesThatUserSelected,index)
    reaper.SetMediaTrackInfo_Value(track,"I_SELECTED",0) 
  end                                        
  -- TO HERE --------------------------------------------------------------------------------
  
  ----JS
  function Msg(str) ----For the Reaper message window
    reaper.ShowConsoleMsg(tostring(str) .. "\n")
  end
  
  -- this is actual call of function that creates folder
 
  createFolder(tracksIndexesThatUserSelected, namesOfStringTracks, stringsParentTrackName, stringsColor)
  createFolder(tracksIndexesThatUserSelected, namesOfWwsTracks, WwsParentTrackName, WwsColor)
  createFolder(tracksIndexesThatUserSelected, namesOfPitchedTracks, pitchedParentTrackName, pitchedColor)
  createFolder(tracksIndexesThatUserSelected, namesOfGuitarTracks, guitarsParentTrackName, guitarsColor)
  createFolder(tracksIndexesThatUserSelected, namesOfBrassTracks, brassParentTrackName, brassColor)
  createFolder(tracksIndexesThatUserSelected, namesOfPercBigTracks, PercBigParentTrackName, percbigColor)
  createFolder(tracksIndexesThatUserSelected, namesOfChoirTracks, choirParentTrackName, choirColor)
  createFolder(tracksIndexesThatUserSelected, namesOfPercSmallTracks, PercSmallParentTrackName, percsmallColor)
  createFolder(tracksIndexesThatUserSelected, namesOfHarpTracks, HarpParentTrackName, harpColor)
  createFolder(tracksIndexesThatUserSelected, namesOfvdgTracks, vdgParentTrackName, vdgColor)
  createFolder(tracksIndexesThatUserSelected, namesOfvcTracks, vcParentTrackName, vcColor)
  createFolder(tracksIndexesThatUserSelected, namesOfTanburTracks, tanburParentTrackName, tanburColor)
  createFolder(tracksIndexesThatUserSelected, namesOfFiddleTracks, fiddleParentTrackName, fiddleColor)
  createFolder(tracksIndexesThatUserSelected, namesOfNyckTracks, nyckParentTrackName, nyckColor)
  createFolder(tracksIndexesThatUserSelected, namesOfGadulkaTracks, gadulkaTrackName, gadulkaColor)
  createFolder(tracksIndexesThatUserSelected, namesOfOrchFxTracks, orchfxTrackName, orchfxColor)
  createFolder(tracksIndexesThatUserSelected, namesOfBoneFluteTracks, bonefluteTrackName, bonefluteColor)
  createFolder(tracksIndexesThatUserSelected, namesOfBagpipesTracks, bagpipesTrackName, bagpipesColor)
  --createFolder(tracksIndexesThatUserSelected, namesOfSynth8bitTracks, synth8bitTrackName, synth8bitColor)
  --createFolder(tracksIndexesThatUserSelected, namesOfSynth16bitTracks, synth16bitTrackName, synth16bitColor)
  createFolder(tracksIndexesThatUserSelected, namesOfGtrBouzoukiTracks, gtrBouzoukiTrackName, gtrBouzoukiColor)
  createFolder(tracksIndexesThatUserSelected, namesOfDrumTracks, drumTrackName, drumColor)
  createFolder(tracksIndexesThatUserSelected, namesOfPercElecTracks, percElecTrackName, percElecColor)
  createFolder(tracksIndexesThatUserSelected, namesOfCitharaTracks, citharaTrackName, citharaColor)
  createFolder(tracksIndexesThatUserSelected, namesOfBassTracks, bassParentTrackName, bassColor)
  createFolder(tracksIndexesThatUserSelected, namesOfSoloVlnTracks, soloVlnParentTrackName, soloVlnColor)
  createFolder(tracksIndexesThatUserSelected, namesOfSnareTracks, snareParentTrackName, snareColor)
  createFolder(tracksIndexesThatUserSelected, namesOfSynthTracks, synthsParentTrackName, synthsColor)
  
  moveUnSortedTracks(tracksToSelect)

  colorTracksToParentTrackColor(tracksIndexesThatUserSelected)
end  
  
-- function colors tracks in folder to their parents track color
function colorTracksToParentTrackColor(tracksToColor)

  for i=0, tableLength(tracksToColor)-1, 1 do
       track = reaper.GetTrack(0,i)
       folder_info =  reaper.GetMediaTrackInfo_Value(track, 'I_FOLDERDEPTH')
       parent_track = reaper.GetParentTrack(track)
    
       if parent_track ~= nil then -- check if track has a parent track, otherwise it would throw an error
         color = reaper.GetTrackColor(parent_track)
    
         if color ~= 0 then
             reaper.SetTrackColor(track,color)
         end
       end
  end
end  

-- function creates folder from tracks which names suits to specific table (e.g. namesOfPercBigTracks)
function createFolder(tracksToSelect,tableWithTrackNames, nameOfParentTrack, folderColor)

  local numberOfTracksAddedToTheFolder = 0
  local ruffTracks = {} -- Changed to a table to handle multiple Ruffs
  local stemTracks = {}
  local ruffAmount = 0
  for i = 0, tableLength(tracksToSelect)-1, 1 do
    local track = reaper.GetTrack(0, i)
    local _, track_name = reaper.GetTrackName(track, "")
    
    if contains(tableWithTrackNames, track_name) then
      reaper.SetMediaTrackInfo_Value(track, "I_SELECTED",1)
      numberOfTracksAddedToTheFolder = numberOfTracksAddedToTheFolder + 1
      
      ----JS: detect if Ruff is missing despite there are stems in this catogery.

      if string.match(track_name, "Ruff") then
        table.insert(ruffTracks, track)
        ruff_name = track_name
        ruffAmount = 1
        else
        table.insert(stemTracks, track)
        end
      ----
    end
  end

  if numberOfTracksAddedToTheFolder > 1 then -- validate if there is more than 1 track in the group, dont want to create folder with 1 track
  
    if ruffAmount == 0 then
     Msg("Ruff is missing: " .. nameOfParentTrack)
    end
  
  
  
  
    reaper.InsertTrackAtIndex(0,0) -- insert track at the begining of the project, it will be parent track
    table.insert(tracksToSelect,tableLength(tracksToSelect)) -- insert one more element to this table, it holds indexes of 
                                                           -- all tracks that are currently in this project
          
    local parent_track = reaper.GetTrack(0,0) -- take this track which i just inserted
    
    reaper.SetTrackColor(parent_track, folderColor)
    reaper.GetSetMediaTrackInfo_String(parent_track, "P_NAME" ,nameOfParentTrack, true)
    reaper.SetMediaTrackInfo_Value(parent_track, "I_SELECTED", 1)
    reaper.ReorderSelectedTracks(0,1) -- reorder all selected tracks, i need this, because sws - make folder from selected tracks
                                    -- works only for tracks that are directly in touch with each other

                                    
    
    reaper.Main_OnCommandEx(commandID, 0, 0) -- it executes sws make folder from selected tracks (ruff and stems should be all selected)
                                    
    -- Move all ruff to the top in parent folder
    
    
    local current_idx = 1
    for i, rTrk in ipairs(ruffTracks) do
      reaper.SetOnlyTrackSelected(rTrk)
      reaper.ReorderSelectedTracks(1, 1)
      reaper.SetMediaTrackInfo_Value(rTrk, "I_FOLDERDEPTH", 0) -- Inside parent
      current_idx = current_idx + 1

    end

    ----JS: Add Subfolder
    clearSelect(tracksToSelect)
    reaper.InsertTrackAtIndex(current_idx,0) ---- create a subfolder below Ruff track
    table.insert(tracksToSelect,tableLength(tracksToSelect)+1) ---- append one more element to the table for adding the subfolder track
    local subfolder_track = reaper.GetTrack(0, current_idx) 
    reaper.SetMediaTrackInfo_Value(subfolder_track, "I_SELECTED", 1) ---- select the subfolder track

    ----
    
    reaper.SetMediaTrackInfo_Value(parent_track, "I_FOLDERCOMPACT", 0)
                                
    
    
    
    
    ----JS: Adding Stems tracks to subfolder track
   


    for j, sTrk in ipairs(stemTracks) do
      --reaper.SetOnlyTrackSelected(sTrk)
      --reaper.ReorderSelectedTracks(current_idx, 0)
      reaper.SetMediaTrackInfo_Value(sTrk, "I_SELECTED", 1)
      
    end


    --local ruff_track = reaper.GetTrack(0,1) ----this is the ruff track, which is always going to be the first track in the folder when we do reaper.ReorderSelectedTracks()  

    --reaper.SetMediaTrackInfo_Value(parent_track, "I_SELECTED", 0) -----|   We only want the stems in the subfolder,
    --reaper.SetMediaTrackInfo_Value(ruff_track, "I_SELECTED", 0) -------|-- therefore these are for diselecting the outer folder & ruff tracK

    
    
    reaper.Main_OnCommandEx(commandID, 0, 0) -- it executes sws make folder from selected tracks
        
    
    
  end
  clearSelect(tracksToSelect) -- clear selects, this function have already made a folder for selected tracks, so there is no need
                              -- to hold them selected
end

-- function unselects all tracks that are currently selected
-- without this script doesn`t work, because it creates folder from selected tracks, so they have to be unselected
-- after script creates a folder from them
function clearSelect(tracksToSelect)
  for i = 0, tableLength(tracksToSelect)-1, 1 do
    track = reaper.GetTrack(0, i)
    reaper.SetMediaTrackInfo_Value(track, "I_SELECTED",0)
  end
end

-- function gets table and returns its length
-- i used it to program Wws
function tableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
    return count
end
  
-- function checks if table contains specific string
-- i used it to check if table contains track name
-- for example if namesOfPercBigTracks contains "kick"(track name)
function contains(tab,name)
  for i=1, tableLength(tab),1 do
   if string.match(string.upper(name), string.upper(tab[i])) then -- i convert strings to uppercase letters because
    return true                                                   -- it eliminates the problem with comparison strings
   end                                                            -- with lowercase and uppercase letters :)
  end
  return false
end




function moveUnSortedTracks()
  local totalTracksAmount =  reaper.CountTracks(0)
  for i = 0, totalTracksAmount-1, 1 do
    local track = reaper.GetTrack(0, i)
    local _, track_name = reaper.GetTrackName(track, "")
    parent_track = reaper.GetParentTrack(track)
    if string.match(track_name, "RuffDemo") then
      reaper.SetMediaTrackInfo_Value(track, "I_SELECTED",1)

      --TO DO - Mute the RuffDemo Track
      
    else
      if parent_track == nil then
        color = reaper.GetTrackColor(track)
        
        if color == 0 then
       
        --[[
        local function Msg(str)
        reaper.ShowConsoleMsg(tostring(str) .. "\n")
        end
        Msg(track_name)
        ]]--
       
          Msg("Unsorted Track: " ..track_name)
          reaper.SetMediaTrackInfo_Value(track, "I_SELECTED",1)
        end
      end
    end
    reaper.Main_OnCommandEx( moveToTopCommand, 0, 0)
  end
end


reaper.Undo_BeginBlock()

Main()
reaper.Main_OnCommand(40939, 0) -- Track: Select Track 01
reaper.Undo_EndBlock("QC_Organize Audio", -1)
    
   
        
          
        
