CharacterApplier = {
    queue = {},
    current = nil,
    nextId = 0,
}

local TIMEOUT <const> = 15000

local function toUnsigned(hash)
    local value = math.tointeger(tonumber(hash))
    if not value or value == 0 then return nil end
    return value & 0xFFFFFFFF
end

local function waitFor(condition, timeout)
    local deadline = GetGameTimer() + (timeout or TIMEOUT)

    while not condition() do
        if GetGameTimer() > deadline then
            return false
        end

        Wait(0)
    end

    return true
end

local function isCreatorBusy()
    if Intro.state ~= INTRO_STATE.WAITING_TO_START then return true end
    if Creator:IsFlagSet(EDITOR_FLAG.ACTIVE) then return true end
    return false
end

local function decodeData(data)
    if type(data) == "table" then
        return data
    end

    if type(data) ~= "string" then
        return nil, string.format("Expected character data as a table or JSON string, got %s", type(data))
    end

    local ok, decoded = pcall(json.decode, data)
    if not ok or type(decoded) ~= "table" then
        return nil, "Character data is not valid JSON"
    end

    return decoded
end

local function setPlayerModel(ped, model)
    if GetEntityModel(ped) & 0xFFFFFFFF == model then
        return ped
    end

    -- Only the player's model can be changed
    if ped ~= PlayerPedId() then
        return nil, "The ped does not use the model of the character"
    end

    if IsModelValid(model) ~= 1 then
        return nil, string.format("The model %d of the character is not valid", model)
    end

    RequestModel(model, false)
    if not waitFor(function() return HasModelLoaded(model) == 1 end) then
        return nil, "Timed out loading the model of the character"
    end

    SetPlayerModel(PlayerId(), model, false)
    SetModelAsNoLongerNeeded(model)

    ped = PlayerPedId()
    SetRandomOutfitVariation(ped, true)

    return ped
end

function CharacterApplier:Run(request)
    local data, decodeError = decodeData(request.data)
    if not data then return false, decodeError end

    local ped = request.ped or PlayerPedId()
    request.target = ped

    if ped == 0 or DoesEntityExist(ped) ~= 1 then
        return false, "The ped does not exist"
    end

    local model = toUnsigned(data.pedModel)
    if model then
        local newPed, modelError = setPlayerModel(ped, model)
        if not newPed then return false, modelError end

        ped = newPed
        request.target = ped
    end

    if IsPedHuman(ped) ~= 1 then
        return false, "The ped is not human"
    end

    if not waitFor(function() return DoesEntityExist(ped) == 1 and IsPedReadyToRender(ped) == 1 end) then
        return false, "Timed out waiting for the ped to be ready"
    end

    Character:Attach(ped)

    local loadError
    local loaded = waitFor(function()
        local ready, err = Character:LoadEditorData()
        loadError = err
        return ready or err ~= nil
    end)

    if loadError then return false, loadError end
    if not loaded then return false, "Timed out loading the editor data" end

    -- The creator UI is not open, so there is nothing to signal
    SignalBus:mute()
    local ok, importError = pcall(Character.Import, Character, data, true)
    SignalBus:unmute()

    if not ok then return false, tostring(importError) end

    CharacterAssets:Request(false)
    if not waitFor(function() return CharacterAssets:IsLoaded() end) then
        return false, "Timed out loading the head and body of the character"
    end

    SignalBus:mute()
    ok, importError = pcall(Character.ApplyAll, Character)
    SignalBus:unmute()

    if not ok then return false, tostring(importError) end

    local applied = waitFor(function()
        return DoesEntityExist(ped) ~= 1 or not Character:IsUpdating()
    end)

    if DoesEntityExist(ped) ~= 1 then
        return false, "The ped was removed while applying the character"
    end

    if not applied then
        return false, "Timed out applying the character"
    end

    return true
end

function CharacterApplier:Process(request)
    waitFor(function() return not isCreatorBusy() end, math.huge)

    self.current = request

    local ok, success, err = pcall(self.Run, self, request)
    if not ok then
        success, err = false, tostring(success)
    end

    if not success then
        Utils:Error("Failed to apply character:", err)
    end

    -- Resetting detaches the character, which keeps the overlays on the ped
    CharacterAssets:Release()
    Character:Reset()
    CreatorPresets:ClearCache()
    CreatorXml:Reset()

    self.current = nil

    local target = request.target or 0

    if request.callback then
        local callbackOk, callbackError = pcall(request.callback, success, target, err)
        if not callbackOk then
            Utils:Error("Character apply callback failed:", tostring(callbackError))
        end
    end

    TriggerEvent("native_cc:character_applied", request.id, success, target, err)
end

---@param data table|string The exported character data, as a table or JSON string
---@param ped number|nil The ped to apply the character to, defaults to the player's ped
---@param callback fun(success: boolean, ped: number, err: string|nil)|nil
---@return number id The ID that is passed to the native_cc:character_applied event
function CharacterApplier:Apply(data, ped, callback)
    self.nextId = self.nextId + 1

    if ped == 0 then ped = nil end

    self.queue[#self.queue + 1] = {
        id = self.nextId,
        data = data,
        ped = ped,
        callback = callback,
    }

    return self.nextId
end

function CharacterApplier:IsBusy()
    return self.current ~= nil or #self.queue > 0
end

CreateThread(function()
    while true do
        local request = table.remove(CharacterApplier.queue, 1)
        if request then
            CharacterApplier:Process(request)
        else
            Wait(100)
        end
    end
end)

exports("ApplyCharacter", function(data, ped, callback)
    return CharacterApplier:Apply(data, ped, callback)
end)

exports("IsApplyingCharacter", function()
    return CharacterApplier:IsBusy()
end)

RegisterNetEvent("native_cc:apply_character", function(data, ped)
    -- Peds of the server are not valid on the client, so those always apply to the player
    if tonumber(source) then
        ped = nil
    end

    CharacterApplier:Apply(data, ped)
end)
