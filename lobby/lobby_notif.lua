local SIMPLE_NOTIFICATION = {}

function LOBBY.SIMPLE_NOTIFICATION(ZHAH237DS, UDAZU3661D, E773DSDDI26)
while LOBBY.SHOW_NOTIF do

    ShowCursorThisFrame()
    SetMouseCursorSprite(1)

    DrawSprite("commonmenu", "gradient_bgd", 0.48, 0.48, .20, .30, 0.0, 255, 255, 255, 255)

    LOBBY.ShowTxt(0.48, 0.335, ZHAH237DS, true, 0.4, {89, 19, 22, 255}, TTRN_REGULAR, 0)

    LOBBY.ShowTxt(0.48, 0.375, UDAZU3661D, true, 0.45, {255, 255, 255, 255}, TTRN_REGULAR, 0)

    if LOBBY.ShowRectangle(vector2(0.47, 0.575), vector2(0.02, 0.25), {31, 31, 31, 0}, true, {35, 35, 35, 0}, function()
        LOBBY.SHOW_NOTIF = false
    end) then
        LOBBY.ShowTxt(0.48, 0.575, "OK", true, 0.6, {255, 255, 255, 255}, TTRN_REGULAR, 0) -- title
    else
        LOBBY.ShowTxt(0.48, 0.575, "OK", true, 0.6, {255, 255, 255, 255}, TTRN_REGULAR, 0) -- title
    end

    Citizen.Wait(1)
end
end