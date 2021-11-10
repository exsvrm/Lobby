local ZONE_CREATE = {}

-- @ open
function LOBBY.ZONE_CREATE()
if LOBBY.ShowCreate then
    
    SetPedAsNoLongerNeeded()
    -- @ background
    DrawSprite("img", "bg", 0.5, 0.5, 1.0, 1.0, 0.0, 0, 0, 0, 125)
    SetTimecycleModifier("scanline_cam_cheap")
    SetTimecycleModifierStrength(2.0)

    if selectedLanguage == "fr" then
        homeSize = vector2(0.070, 0.030)
    elseif selectedLanguage == "en" then
        homeSize = vector2(0.035, 0.030)
    end
    if LOBBY.ShowRectangle(vector2(0.036, 0.03), homeSize, {31, 31, 31, 0}, true, {35, 35, 35, 0}, function()
        LOBBY.ShowCreate = false
    end) then
        LOBBY.ShowTxt(0.036, 0.03, "~HUD_COLOUR_GREY~" .. string.upper(GetPhrase("lobby")) .. "~w~ > ~HUD_COLOUR_REDDARK~" .. string.upper(GetPhrase("lobby_create")), false, 0.6, {255, 255, 255, 255}, EUROSTILE, 0) -- title
    else
        LOBBY.ShowTxt(0.036, 0.03, string.upper(GetPhrase("lobby") .. " > ~HUD_COLOUR_REDDARK~" .. GetPhrase("lobby_create")), false, 0.6, {255, 255, 255, 255}, EUROSTILE, 0) -- title
    end

    for i,v in pairs(GetActivePlayers()) do
        LOBBY.ShowTxt(0.48, 0.25, GetPlayerName(v), true, 0.6, {255, 255, 255, 255}, EUROSTILE, 0)
    end

end
end