NuiHelper = {
    importOpen = false
}

function NuiHelper:Open(pedType, pedModel, placeholderName, placeholderAge)
    if self.importOpen then return end

    self.importOpen = true
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)

    SendNUIMessage({
        type = 'open_character_paste',
        pedType = pedType,
        pedModel = pedModel,
        placeholderName = placeholderName,
        placeholderAge = placeholderAge
    })

    self:StartThread()
end

function NuiHelper:Copy(data)
    SendNUIMessage({ type = "copy", text = json.encode(data) })
end

function NuiHelper:PlaySound(sound, set)
    StopSoundWithName(sound, set)
    PlaySoundFrontend(sound, set, true, 0)
end

function NuiHelper:StartThread()
    local VK_BACK <const> = 0x08
    local lastUsingKbd = nil

    CreateThread(function()
        while self.importOpen do
            for i = 0, 10 do
                DisableAllControlActions(i)
            end

            local usingKbd = IsUsingKeyboardAndMouse(0)
            if usingKbd ~= lastUsingKbd then
                lastUsingKbd = usingKbd
                SendNUIMessage({ type = usingKbd and 'using_keyboard' or 'using_controller' })
            end

            if IsDisabledControlJustReleased(0, `INPUT_GAME_MENU_ACCEPT`) then
                SendNUIMessage({ type = 'trigger_accept' })
            end

            local backspace = IsRawKeyPressed(VK_BACK) or IsRawKeyReleased(VK_BACK)
            if not backspace and IsDisabledControlJustReleased(0, `INPUT_GAME_MENU_CANCEL`) then
                SendNUIMessage({ type = 'trigger_cancel' })
            end

            Wait(0)
        end
    end)
end

function NuiHelper:OnPasted(data)
    if not self.importOpen then return end

    NuiHelper:PlaySound("SELECT", "RDRO_Character_Creator_Sounds")

    self.importOpen = false
    SetNuiFocusKeepInput(false)
    SetNuiFocus(false, false)

    Utils:Debug("Successfully received JSON:", json.encode(data.data))

    SignalBus:emit("character_paste_closed")
    SignalBus:emit("character_pasted", data.data)
end

function NuiHelper:OnClose()
    if not self.importOpen then return end

    self:PlaySound("BACK", "RDRO_Character_Creator_Sounds")

    self.importOpen = false
    SetNuiFocusKeepInput(false)
    SetNuiFocus(false, false)

    SignalBus:emit("character_paste_closed")
end

RegisterNUICallback('character_pasted', function(data, cb)
    NuiHelper:OnPasted(data)
    cb('ok')
end)

RegisterNUICallback('character_paste_closed', function(_, cb)
    NuiHelper:OnClose()
    cb('ok')
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    NuiHelper:OnClose()
end)
