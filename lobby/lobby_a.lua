LOBBY = {}
LOBBY.__index = lobby
LOBBY.lockedControls = { {24, 30, 31, 32, 33, 34, 35} }
LOBBY.campos = vec3(464.031921, 4832.338379, -58.993797)
LOBBY.cooldown = false
LOBBY.cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", LOBBY.campos, 0.0, 0.0, 75.0, 100.00, false, 0)
LOBBY.active = false
LOBBY.SHOW_PROFILE = false
LOBBY.SHOW_NOTIF = false
LOBBY.rank = ""
LOBBY.specialrank = ""
LOBBY.rankIcon = ""
LOBBY.specialrankIcon = ""
local clickControl = {24, 176}

function LOBBY.HandleControl()
    for k,v in pairs(clickControl) do
        if IsControlJustReleased(0, v) and not LOBBY.cooldown then
            LOBBY.HandleCooldown()
            return true
        end
    end
    return false
end

function LOBBY.HandleCooldown()
    if not LOBBY.cooldown then
        LOBBY.cooldown = true
        Citizen.CreateThread(function()
            Wait(150)
            LOBBY.cooldown = false
        end)
    end
end

function LOBBY.isMouseOnButton(position, buttonPos, Width, Heigh)
    return position.x >= buttonPos.x and position.y >= buttonPos.y and position.x < buttonPos.x + Width and position.y < buttonPos.y + Heigh
end

function LOBBY.ShowTxt(x, y, text, center, scale, rgb, font, justify)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(rgb[1], rgb[2], rgb[3], rgb[4])
    SetTextEntry("STRING")
    SetTextCentre(center)
    AddTextComponentString(text)
    EndTextCommandDisplayText(x,y)
end

function LOBBY.ShowRectangle(position, size, color, action, hoverColor, actions, hoverAction)
	local pos = (position + size / 2.0)
	DrawRect(pos[1], pos[2], size[1], size[2], color[1], color[2], color[3], color[4])

    if action ~= nil then
        if LOBBY.isMouseOnButton({x = GetControlNormal(0, 239) , y = GetControlNormal(0, 240)}, {x = position.x, y = position.y}, size[1], size[2]) then
            SetMouseCursorSprite(5)
            if hoverColor[4] ~= 0 then
                DrawRect(pos[1], pos[2], size[1] + 0.003, size[2] + 0.003, hoverColor[1], hoverColor[2], hoverColor[3], hoverColor[4])
            end

            if LOBBY.HandleControl() then
                actions()
            end

            if hoverAction ~= nil then
                hoverAction()
            end
            return true
        else
            return false
        end
    end
end

function LOBBY.SubMenuIsActive()
    if LOBBY.SHOW_PROFILE then
        return true
    end
end

function LOBBY.MenuActive()
    if LOBBY.active then
        return true
    end
end

function LOBBY.Unshow()
    RenderScriptCams(false, true, 1, false, false)
    SetCamActive(LOBBY.cam, false)
    DestroyCam(LOBBY.cam, false)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    SetEntityVisible(GetPlayerPed(-1), true)
    SetTimecycleModifier("")
    DisplayRadar(true)
    StopAudioScene("MP_MENU_SCENE")
    SendNUIMessage({type = "close"})
end

Citizen.CreateThread(function()

    while LOBBY.MenuActive() do

        StartAudioScene("MP_MENU_SCENE")
        SetTimecycleModifier("")

        -- @ visible + freeze + pos
        FreezeEntityPosition(GetPlayerPed(-1), true)
        --SetEntityVisible(GetPlayerPed(-1), false)
        SetEntityInvincible(GetPlayerPed(-1), true)
        DisplayRadar(false)
        SetPedCanSwitchWeapon(GetPlayerPed(-1), false)
        SetEntityCoords(GetPlayerPed(-1), 480.613739, 4821.369141, -58.382862)
        SetEntityHeading(GetPlayerPed(-1), 201.95593261719)

        -- @ cursor
        ShowCursorThisFrame()
        SetMouseCursorSprite(1)

        -- @ controls
        for _,v in pairs(LOBBY.lockedControls) do
            DisableControlAction(0, v, true)
        end

        DisableControlAction(0, 322, true)

        if not LOBBY.SubMenuIsActive() then

        -- @ background
        -- DrawRect(0.0, 0.0, 10.0, 10.0, 0, 0, 0, 175)
        DrawSprite("img", "bg", 0.5, 0.5, 1.0, 1.0, 0.0, 0, 0, 0, 125)
        SetTimecycleModifier("scanline_cam_cheap")
        SetTimecycleModifierStrength(2.0)

        -- if not HasStreamedTextureDictLoaded("image") then RequestStreamedTextureDict("image", true) while not HasStreamedTextureDictLoaded("image") do Wait(1) end
        -- else
        -- @ bg img
        -- DrawSprite("image", "lobby_image", 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
        -- @ gtb img
        -- DrawSprite("image", "gotobase_image", 0.114, 0.180, .153, .128, 0.0, 255, 255, 255, 255)
        -- @ gtc img
        -- DrawSprite("image", "gotocombat_image", 0.289, 0.180, .153, .128, 0.0, 255, 255, 255, 255)
        -- end

        --[[
        --- @ texture
        -- @ commonmenu
        if not HasStreamedTextureDictLoaded("commonmenu") then RequestStreamedTextureDict("commonmenu", true) while not HasStreamedTextureDictLoaded("commonmenu") do Wait(1) end
        else
        -- @ GO TO BASE
        DrawSprite("commonmenu", "gradient_nav", 0.039, 0.269, .003, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.1155, 0.269, .15, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.1155, 0.269, .15, .05, 0.0, 255, 255, 255, 255)
        -- @ GO TO CZ
        DrawSprite("commonmenu", "gradient_nav", 0.214, 0.269, .003, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.2905, 0.269, .15, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.2905, 0.269, .15, .05, 0.0, 255, 255, 255, 255)
        -- @ GO TO PROFILE
        DrawSprite("commonmenu", "gradient_nav", 0.039, 0.369, .003, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.0855, 0.369, .09, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.0855, 0.369, .09, .05, 0.0, 255, 255, 255, 255)
        -- @ GO TO SETTINGS
        DrawSprite("commonmenu", "gradient_nav", 0.164, 0.369, .003, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.2255, 0.369, .12, .05, 0.0, 89, 19, 22, 255)
        DrawSprite("commonmenu", "gradient_bgd", 0.2255, 0.369, .12, .05, 0.0, 255, 255, 255, 255)
        end

        -- @ mp leaderboard
        if not HasStreamedTextureDictLoaded("mpleaderboard") then RequestStreamedTextureDict("mpleaderboard", true) while not HasStreamedTextureDictLoaded("mpleaderboard") do Wait(1) end
        else
        -- @ go to base
        DrawSprite("mpleaderboard", "leaderboard_globe_icon", 0.180, 0.269, .02, .034, 0.0, 255, 255, 255, 255)
        -- @ go to cz
        DrawSprite("mpleaderboard", "leaderboard_deaths_icon", 0.355, 0.269, .02, .034, 0.0, 255, 255, 255, 255)
        -- @ go to profile
        DrawSprite("mpleaderboard", "leaderboard_male_icon", 0.120, 0.369, .02, .034, 0.0, 255, 255, 255, 255)
        -- @ go to settings
        DrawSprite("mpleaderboard", "leaderboard_position_icon", 0.2725, 0.369, .02, .034, 0.0, 255, 255, 255, 255)
        end

        -- @ lobby
        LOBBY.ShowTxt(0.036, 0.03, "~HUD_COLOUR_REDDARK~" .. string.upper("Lobby"), false, 0.6, {255, 255, 255, 255}, EUROSTILE, 0) -- title

        -- @ go to base sl
        if selectedLanguage == "fr" then
            baseSize = vector2(0.095, 0.030)
        elseif selectedLanguage == "en" then
            baseSize = vector2(0.060, 0.030)
        end
        -- @ go to base
        if LOBBY.ShowRectangle(vector2(0.050, 0.25), baseSize, {31, 31, 31, 0}, true, {35, 35, 35, 0}, function()
            LOBBY.Unshow()
            LOBBY.active = false
            SetEntityCoords(GetPlayerPed(-1), base.spawnpos)
        end) then
            LOBBY.ShowTxt(0.050, 0.25, "~HUD_COLOUR_GREY~" .. "Go base", false, 0.6, {255, 255, 255, 255}, 2, 0) -- title
        else
            LOBBY.ShowTxt(0.050, 0.25, "Go base", false, 0.6, {255, 255, 255, 255}, 2, 0) -- title
        end

        -- @ go to combat sl
        if selectedLanguage == "fr" then
            combatSize = vector2(0.09, 0.030)
        elseif selectedLanguage == "en" then
            combatSize = vector2(0.07, 0.030)
        end
        -- @ go to combat
        if LOBBY.ShowRectangle(vector2(0.225, 0.255), combatSize, {31, 31, 31, 0}, true, {35, 35, 35, 0}, function()
            LOBBY.Unshow()
            LOBBY.active = false
            SetEntityCoords(GetPlayerPed(-1), combat.actualcombat)
        end) then
            LOBBY.ShowTxt(0.225, 0.25, "~HUD_COLOUR_GREY~" .. "Go combat", false, 0.6, {255, 255, 255, 255}, 2, 0) -- title
        else
            LOBBY.ShowTxt(0.225, 0.25, "Go combat", false, 0.6, {255, 255, 255, 255}, 2, 0) -- title
        end

        -- @ profile sl
        if selectedLanguage == "fr" then
            profileSize = vector2(0.04, 0.030)
        elseif selectedLanguage == "en" then
            profileSize = vector2(0.05, 0.030)
        end
        -- @ profile
        if LOBBY.ShowRectangle(vector2(0.050, 0.35), profileSize, {31, 31, 31, 0}, true, {35, 35, 35, 0}, function()
            LOBBY.SHOW_PROFILE = true
        end) then
            LOBBY.ShowTxt(0.050, 0.35, "~HUD_COLOUR_GREY~" .. "Profile", false, 0.6, {255, 255, 255, 255}, 2, 0) -- title
        else
            LOBBY.ShowTxt(0.050, 0.35, "Profile", false, 0.6, {255, 255, 255, 255}, 2, 0) -- title
        end

        -- @ settings sl
        if selectedLanguage == "fr" then
            settingSize = vector2(0.07, 0.030)
        elseif selectedLanguage == "en" then
            settingSize = vector2(0.05, 0.030)
        end
        -- @ settings
        if LOBBY.ShowRectangle(vector2(0.175, 0.35), settingSize, {31, 31, 31, 0}, true, {35, 35, 35, 0}, function()
            -- LOBBY.ShowProfile = true
        end) then
            LOBBY.ShowTxt(0.175, 0.35, "~HUD_COLOUR_GREY~" .. "Settings", false, 0.6, {255, 255, 255, 255}, 2, 0) -- title
        else
            LOBBY.ShowTxt(0.175, 0.35, "Settings", false, 0.6, {255, 255, 255, 255}, 2, 0) -- title
        end

        -- @ create sl
        if selectedLanguage == "fr" then
            settingSize = vector2(0.07, 0.030)
        elseif selectedLanguage == "en" then
            settingSize = vector2(0.05, 0.030)
        end
        -- @ create
        if LOBBY.ShowRectangle(vector2(0.175, 0.75), settingSize, {31, 31, 31, 0}, true, {35, 35, 35, 0}, function()
            LOBBY.SHOW_NOTIF = true
            LOBBY.SIMPLE_NOTIFICATION("NOTIFICATION", GetPhrase("t_s_not_enabled"), "OK")
        end) then
            LOBBY.ShowTxt(0.175, 0.75, "~HUD_COLOUR_GREY~" .. string.upper("Créer"), false, 0.6, {255, 255, 255, 255}, TTRN_REGULAR, 0) -- title
        else
            LOBBY.ShowTxt(0.175, 0.75, string.upper("Créer"), false, 0.6, {255, 255, 255, 255}, TTRN_REGULAR, 0) -- title
        end
        --]]

        DrawRect(0.0, 0.0, 10.0, 10.0, 17, 38, 57, 75)

        DrawRect(0.48, 0.48, 0.750, 0.750, 17, 38, 57, 175)

        LOBBY.ShowTxt(0.20, 0.225, "BASE", false, 0.6, {255, 255, 255, 255}, TTRN_REGULAR, 0) -- title

        -- @ cam
        SetCamActive(LOBBY.cam, true)
        RenderScriptCams(true, false, 2000, true, true)

        end

        LOBBY.PROFILE()
        LOBBY.ZONE_CREATE()
        LOBBY.SIMPLE_NOTIFICATION()

        Citizen.Wait(1)
    end
end)

RegisterCommand("radarnone", function()
    LOBBY.active = false
    LOBBY.Unshow()
    SetEntityCoords(GetPlayerPed(-1), 350.137665, 4872.116699, -60.599663)
end)
