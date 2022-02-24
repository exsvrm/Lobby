local PROFILE = {}
MY_UUID = "/"
MY_CREW = "/"

-- @ uuid
Tsc("GetUuid", function(GETFUCKINGUUID)
    MY_UUID = GETFUCKINGUUID
end)
Tsc("GetCrew", function(GETFUCKINGCREW)
    MY_CREW = GETFUCKINGCREW
end)

-- @ open
function LOBBY.PROFILE()
    if LOBBY.SHOW_PROFILE then
        ShowCursorThisFrame()
        SetMouseCursorSprite(1)

        -- @ background
        -- DrawRect(0.0, 0.0, 10.0, 10.0, 0, 0, 0, 175)
        DrawSprite("img", "bg", 0.5, 0.5, 1.0, 1.0, 0.0, 0, 0, 0, 125)
        SetTimecycleModifier("scanline_cam_cheap")
        SetTimecycleModifierStrength(2.0)
        
        --- @ texture
        -- @ commonmenu
        if not HasStreamedTextureDictLoaded("commonmenu") then RequestStreamedTextureDict("commonmenu", true) while not HasStreamedTextureDictLoaded("commonmenu") do Wait(1) end
        else
        -- @ uuid
        DrawSprite("commonmenu", "gradient_nav", 0.039, 0.14, .003, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.1155, 0.14, .15, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.1155, 0.14, .15, .05, 0.0, 255, 255, 255, 255)
        -- @ rank
        DrawSprite("commonmenu", "gradient_nav", 0.039, 0.29, .003, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.1305, 0.29, .18, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.1305, 0.29, .18, .05, 0.0, 255, 255, 255, 255)
        -- @ crew
        DrawSprite("commonmenu", "gradient_nav", 0.039, 0.44, .003, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.1305, 0.44, .18, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.1305, 0.44, .18, .05, 0.0, 255, 255, 255, 255)
        end

        -- @ profile
        if selectedLanguage == "fr" then
            homeSize = vector2(0.070, 0.030)
        elseif selectedLanguage == "en" then
            homeSize = vector2(0.035, 0.030)
        end
        if LOBBY.ShowRectangle(vector2(0.036, 0.03), homeSize, {31, 31, 31, 0}, true, {35, 35, 35, 0}, function()
            LOBBY.SHOW_PROFILE = false
        end) then
            LOBBY.ShowTxt(0.036, 0.03, "~HUD_COLOUR_GREY~" .. string.upper("Lobby") .. "~w~ > ~HUD_COLOUR_REDDARK~" .. string.upper("Profile"), false, 0.6, {255, 255, 255, 255}, EUROSTILE, 0) -- title
        else
            LOBBY.ShowTxt(0.036, 0.03, string.upper("Lobby" .. " > ~HUD_COLOUR_REDDARK~" .. "Profile"), false, 0.6, {255, 255, 255, 255}, EUROSTILE, 0) -- title
        end

        -- @ rank
        if staff then
            LOBBY.rank = "S T A F F"
            LOBBY.rankIcon = "medal_silver_128"
        end
        if dev then
            LOBBY.rank = "D E V E L O P E R"
            LOBBY.rankIcon = "medal_gold_128"
        end
        if vip then
            LOBBY.specialrank = "V I P"
            LOBBY.specialrankIcon = "newstar_32"
        end

        if not HasStreamedTextureDictLoaded("shared") then RequestStreamedTextureDict("shared", true) while not HasStreamedTextureDictLoaded("shared") do Wait(1) end
        else
        DrawSprite("shared", LOBBY.rankIcon, 0.2075, 0.44, .02, .034, 0.0, 255, 255, 255, 255)
        end

        -- @ text
        LOBBY.ShowTxt(0.050, 0.121, MY_UUID, false, 0.6, {255, 255, 255, 255}, TTRN_LIGHT, 0) -- title
        LOBBY.ShowTxt(0.050, 0.271, MY_CREW, false, 0.6, {255, 255, 255, 255}, TTRN_LIGHT, 0) -- title
        LOBBY.ShowTxt(0.050, 0.421, LOBBY.rank, false, 0.6, {255, 255, 255, 255}, TTRN_LIGHT, 0) -- title

        -- @ rightlabel
        LOBBY.ShowTxt(0.145, 0.121, "UUID", false, 0.6, {255, 255, 255, 255}, TTRN_REGULAR, 0) -- title
        LOBBY.ShowTxt(0.165, 0.271, "CREW", false, 0.6, {255, 255, 255, 255}, TTRN_REGULAR, 0) -- title

    end
end
