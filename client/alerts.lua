local CHANNELS <const> = {
    `STATUS_ALERT_FEED`,
    `WARNING_FEED`
}

local EVENTS <const> = {
    [`UI_STICKY_FEED_BUTTON_TYPE_ACCEPT`]     = "alert_accept",
    [`UI_STICKY_FEED_BUTTON_TYPE_BACK`]       = "alert_back",
    [`UI_STICKY_FEED_BUTTON_TYPE_OPTION`]     = "alert_option",
    [`UI_STICKY_FEED_BUTTON_TYPE_OPTION_ALT`] = "alert_option_alt"
}

function ShowAlert(type, title, body, config)
    local types = {
        ERROR = 0x9F2CC2439A04E7BA,   -- _UI_STICKY_FEED_CREATE_ERROR_MESSAGE
        DEATH = 0x815C4065AE6E6071,   -- _UI_STICKY_FEED_CREATE_DEATH_FAIL_MESSAGE
        WARNING = 0x339E16B41780FC35, -- _UI_STICKY_FEED_CREATE_WARNING_MESSAGE
    }

    local soundSetLiteral = VarString(10, "LITERAL_STRING", config.soundSet or "")
    local soundNameLiteral = VarString(10, "LITERAL_STRING", config.soundName or "")

    local dataConfig = DataView.ArrayBuffer(19 * 8)
    dataConfig:SetInt64(0 * 8, soundSetLiteral)
    dataConfig:SetInt64(1 * 8, soundNameLiteral)
    dataConfig:SetInt32(2 * 8, 4)
    dataConfig:SetInt32(3 * 8, config.acceptHash or 0)
    dataConfig:SetInt32(6 * 8, config.acceptHeld and 1 or 0)
    dataConfig:SetInt32(7 * 8, config.backHash or 0)
    dataConfig:SetInt32(10 * 8, config.backHeld and 1 or 0)
    dataConfig:SetInt32(11 * 8, config.optionHash or 0)
    dataConfig:SetInt32(14 * 8, config.optionHeld and 1 or 0)
    dataConfig:SetInt32(15 * 8, config.optionAltHash or 0)
    dataConfig:SetInt32(18 * 8, config.optionAltHeld and 1 or 0)

    local titleLiteral = VarString(10, "LITERAL_STRING", title or "")
    local bodyLiteral = VarString(10, "LITERAL_STRING", body or "")

    local displayConfig = DataView.ArrayBuffer(4 * 8)

    if type == "ERROR" then
        displayConfig:SetInt64(1 * 8, titleLiteral)
        displayConfig:SetInt64(2 * 8, bodyLiteral)
    elseif type == "DEATH" then
        displayConfig:SetInt64(1 * 8, titleLiteral)
        -- No support for body in death messages
    else
        displayConfig:SetInt64(2 * 8, titleLiteral)
        displayConfig:SetInt64(3 * 8, bodyLiteral)
    end

    local native = types[type] or types.WARNING
    local id = Citizen.InvokeNative(native, dataConfig:Buffer(), displayConfig:Buffer(), 1)

    return id
end

CreateThread(function()
    while true do
        if UiStickyFeedIsAlertScreenActive() ~= 1 then
            Wait(250)
            goto continue
        end

        for _, channel in ipairs(CHANNELS) do
            while EventsUiIsPending(channel) do
                local msg = DataView.ArrayBuffer(8 * 4)
                msg:SetInt32(0, 0)
                msg:SetInt32(8, 0)
                msg:SetInt32(16, 0)
                msg:SetInt32(24, 0)

                if Citizen.InvokeNative(0x90237103F27F7937, channel, msg:Buffer()) ~= 0 then -- EVENTS_UI_PEEK_MESSAGE
                    local event = msg:GetInt32(0)
                    local msgId = msg:GetInt32(8)
                    local parameter = msg:GetInt32(16)

                    if event == `ITEM_SELECTED` then
                        SignalBus:emit(EVENTS[parameter] or "alert_selected", msgId)
                        UiStickyFeedClearMessage(msgId)
                    elseif event == `STICKY_FEED_CLEARED` then
                        SignalBus:emit("alert_cleared", msgId)
                        UiStickyFeedClearMessage(msgId)
                    end
                end

                EventsUiPopMessage(channel)
            end
        end

        Wait(0)

        ::continue::
    end
end)
