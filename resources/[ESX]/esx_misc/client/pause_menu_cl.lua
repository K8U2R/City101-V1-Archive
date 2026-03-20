function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

local config = {
    ["TITLE"] = "~r~101 City~w~ | <FONT FACE='A9eelsh'>~r~101 ﺔﻨﻳﺪﻣ </font>",
    ["SUBTITLE"] = "<FONT FACE='A9eelsh'>~r~https://discord.gg/dhsPHxDDvQ</font>",
    ["MAP"] = "<FONT FACE='A9eelsh'>101 ﺔﻨﻳﺪﻣ ﺔﻄﻳﺮﺧ 🗺️</font>",
    ["STATUS"] = "<FONT FACE='A9eelsh'>ﺔﻟﺎﺤﻟﺍ</font>",
    ["GAME"] = "<FONT FACE='A9eelsh'>~r~ﺝﻭﺮﺨﻟﺍ</font>",
    ["INFO"] = "<FONT FACE='A9eelsh'>ﺕﺎﻣﻮﻠﻌﻣ</font>",
    ["SETTINGS"] = "<FONT FACE='A9eelsh'>ﺕﺍﺩﺍﺪﻋﻹﺍ ⚙️</font>",
    ["R*EDITOR"] = "<FONT FACE='A9eelsh'>ﺭﺎﺘﺳ ﻙﻭﺭ ﺝﺎﺘﻧﻮﻣ 🎥</font>"
}

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        N_0xb9449845f73f5e9c("SHIFT_CORONA_DESC")
        PushScaleformMovieFunctionParameterBool(true)
        PopScaleformMovieFunction()
        N_0xb9449845f73f5e9c("SET_HEADER_TITLE")
        PushScaleformMovieFunctionParameterString(config["TITLE"])
        PushScaleformMovieFunctionParameterBool(true)
        PushScaleformMovieFunctionParameterString(config["SUBTITLE"])
        PushScaleformMovieFunctionParameterBool(true)
        PopScaleformMovieFunctionVoid()
    end
end)

Citizen.CreateThread(function()
    AddTextEntry('PM_SCR_MAP', config["MAP"])
    AddTextEntry('PM_SCR_STA', config["STATUS"])
    AddTextEntry('PM_SCR_GAM', config["GAME"])
    AddTextEntry('PM_SCR_INF', config["INFO"])
    AddTextEntry('PM_SCR_SET', config["SETTINGS"])
    AddTextEntry('PM_SCR_RPL', config["R*EDITOR"])
end)
