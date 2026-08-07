local defaults = {
    config = 0,
    flags = EDITOR_FLAG.CLEAR,
    state = EDITOR_STATE.INIT,
    stateChangeTime = 0,
    headRequests = {},
    mode = CREATOR_MODE.DEFAULT,
}

Creator = setmetatable({}, { __index = defaults })

function Creator:Reset()
    for k in pairs(self) do
        if type(self[k]) == "function" then
            goto continue
        end
        self[k] = nil
        ::continue::
    end
end

function Creator:Initialize()
    self:SetFlag(EDITOR_FLAG.INITIALIZE)
end

function Creator:Start()
    if not self:IsFlagSet(EDITOR_FLAG.INITIALIZE) then
        self:Initialize()
    end

    self:SetFlag(EDITOR_FLAG.STARTED)
end

function Creator:Open(rerolling, config)
    if rerolling then
        self:SetFlag(EDITOR_FLAG.REROLLING)
    else
        self:ClearFlag(EDITOR_FLAG.REROLLING)
    end

    self.config = config or 0
    self:SetFlag(EDITOR_FLAG.ACTIVE)
end

function Creator:Finish(confirmed)
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    if confirmed then
        self:SetFlag(EDITOR_FLAG.CONFIRMED)
    else
        self:SetFlag(EDITOR_FLAG.CANCELLED)
    end

    self:SetFlag(EDITOR_FLAG.END_REQUESTED)
end

function Creator:OpenEditor(mode)
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    self:SetMode(mode)
    self:SetFlag(EDITOR_FLAG.EDITOR_ACTIVE)
end

function Creator:CloseEditor(confirmed)
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    if confirmed and CreatorMenu then
        CreatorMenu:SetConfirmed(self:GetMode(), true)
    end

    self:ClearFlag(EDITOR_FLAG.EDITOR_ACTIVE)
end

function Creator:QuickSwitch()
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    Creator:SetFlag(EDITOR_FLAG.QUICK_SWITCH)
end

function Creator:Rename()
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    local maxNameLength = CreatorConfig.MaxNameLength or 50
    NextOnscreenKeyboardResultWillDisplayUsingTheseFonts(256)
    DisplayOnscreenKeyboard(4, "NAME_TITLE_PROMPT", "", Character.name or "", "", "", "", maxNameLength)

    self:SetFlag(EDITOR_FLAG.NAME_PROMPT)
end

function Creator:SetState(newState)
    Utils:Debug(string.format("Changing state from %s to %s", EDITOR_STATE:ToString(self.state), EDITOR_STATE:ToString(newState)))

    self.state = newState
    self.stateChangeTime = GetGameTimer()
end

function Creator:Maintain()
    if self.state == EDITOR_STATE.INIT then
        self:UpdateStateInit()
    elseif self.state == EDITOR_STATE.LOAD_XML then
        self:UpdateStateLoadXml()
    elseif self.state == EDITOR_STATE.REGISTER_DATABINDINGS then
        self:UpdateStateRegisterDatabindings()
    elseif self.state == EDITOR_STATE.WAIT_TO_START then
        self:UpdateStateWaitToStart()
    elseif self.state == EDITOR_STATE.SETUP then
        self:UpdateStateSetup()
    elseif self.state == EDITOR_STATE.IN_MENU then
        self:UpdateStateInMenu()
    elseif self.state == EDITOR_STATE.IN_EDITOR then
        self:UpdateStateInEditor()
    elseif self.state == EDITOR_STATE.TRANSITION_TO_MENU then
        self:UpdateStateTransitionToMenu()
    elseif self.state == EDITOR_STATE.TRANSITION_TO_EDITOR then
        self:UpdateStateTransitionToEditor()
    elseif self.state == EDITOR_STATE.QUICK_SWITCH then
        self:UpdateStateQuickSwitch()
    elseif self.state == EDITOR_STATE.TEARDOWN then
        self:UpdateStateTeardown()
    else
        self:SetState(EDITOR_STATE.INIT)
    end
end

function Creator:UpdateStateInit()
    if not self:IsFlagSet(EDITOR_FLAG.INITIALIZE) then
        return
    end

    CreatorRenderer:UpdateText()

    local maxNameLength = CreatorConfig.MaxNameLength or 50
    AddTextEntry("NAME_TITLE_PROMPT", string.format("What's your name? (Max %d characters)", maxNameLength))

    self:SetState(EDITOR_STATE.LOAD_XML)
end

function Creator:UpdateStateLoadXml()
    if not CreatorXml:Initialize() then
        return
    end

    self:SetState(EDITOR_STATE.REGISTER_DATABINDINGS)
end

function Creator:UpdateStateRegisterDatabindings()
    if not CreatorDatabinding:Initialize() then
        return
    end

    self:SetState(EDITOR_STATE.WAIT_TO_START)
end

function Creator:UpdateStateWaitToStart()
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    if not Character:Exists() then
        return
    end

    if Character:IsOtherPlayer() then
        error("Opening the character creator with another player is not allowed")
    end

    if Character:IsPlayer() then
        Utils:Debug("Warning: You shouldn't be using a player ped as the editor entity directly")
        Utils:Debug("This can cause sync issues with other players, please use networked clones instead")
    end

    self:SetState(EDITOR_STATE.SETUP)
end

function Creator:UpdateStateSetup()
    DisableAllControlActions(0)

    CreatorXml:RequestReset(0)

    local config = Character:GetCreatorConfig()
    if not CreatorPresets:Init(config) then
        Utils:Debug(string.format("Editor config %s not defined in XML", EDITOR_CONFIG:ToString(config)))
        self:SetState(EDITOR_STATE.TEARDOWN)
        return
    end

    if not self:PreloadAnimations() then
        return
    end

    if not self:PreloadHeads() then
        return
    end

    Character:ApplyAll()

    self:SetState(EDITOR_STATE.TRANSITION_TO_MENU)
end

function Creator:UpdateStateInMenu()
    if IsUiappRunningByHash(`character_creator`) == 1 then
        CloseUiappByHash(`character_creator`)
    end

    if self:IsFlagSet(EDITOR_FLAG.END_REQUESTED) then
        self:SetState(EDITOR_STATE.TEARDOWN)
        return
    end

    if self:IsFlagSet(EDITOR_FLAG.EDITOR_ACTIVE) then
        self:SetState(EDITOR_STATE.TRANSITION_TO_EDITOR)
        return
    end

    if self:IsFlagSet(EDITOR_FLAG.NAME_PROMPT) and UpdateOnscreenKeyboard() == 1 then
        Character.name = GetOnscreenKeyboardResult()
        CreatorMenu:Refresh()
        self:ClearFlag(EDITOR_FLAG.NAME_PROMPT)
    end

    if not self:IsFlagSet(EDITOR_FLAG.MENU_RUNNING) then
        DisableAllControlActions(0)

        if CanLaunchUiappByHash(`shop_menu`) ~= 1 then
            return
        end

        local rerolling = self:IsFlagSet(EDITOR_FLAG.REROLLING)
        CreatorMenu:Open(rerolling)

        if IsUiappActiveByHash(`shop_menu`) ~= 1 then
            return
        end

        self:ClearFlag(EDITOR_FLAG.EDITOR_RUNNING)
        self:SetFlag(EDITOR_FLAG.MENU_RUNNING)
    end
end

function Creator:UpdateStateInEditor()
    CancelOnscreenKeyboard()

    if IsUiappRunningByHash(`shop_menu`) == 1 then
        CloseUiappByHash(`shop_menu`)
    end

    if self:IsFlagSet(EDITOR_FLAG.END_REQUESTED) then
        self:SetState(EDITOR_STATE.TEARDOWN)
        return
    end

    if self:IsFlagSet(EDITOR_FLAG.QUICK_SWITCH) then
        self:SetState(EDITOR_STATE.QUICK_SWITCH)
        return
    end

    if not self:IsFlagSet(EDITOR_FLAG.EDITOR_ACTIVE) then
        self:SetState(EDITOR_STATE.TRANSITION_TO_MENU)
        return
    end

    SetControlContext(4, `Creator`)

    CreatorEvents:Maintain()

    if not self:IsFlagSet(EDITOR_FLAG.EDITOR_RUNNING) then
        DisableAllControlActions(0)

        if CanLaunchUiappByHash(`character_creator`) ~= 1 then
            return
        end

        LaunchUiappByHashWithEntry(`character_creator`, `sp_missions`)

        if IsUiappActiveByHash(`character_creator`) ~= 1 then
            return
        end

        self:ClearFlag(EDITOR_FLAG.MENU_RUNNING)
        self:SetFlag(EDITOR_FLAG.EDITOR_RUNNING)
    end
end

function Creator:UpdateStateTransitionToMenu()
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    DisableAllControlActions(0)

    self:SetState(EDITOR_STATE.IN_MENU)
end

function Creator:UpdateStateTransitionToEditor()
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    DisableAllControlActions(0)

    if not CreatorRenderer:RequestSwatchTextures() then
        return
    end

    if not CreatorDatabinding:FilloutUiData() then
        return
    end

    self:SetState(EDITOR_STATE.IN_EDITOR)
end

function Creator:UpdateStateTeardown()
    CancelOnscreenKeyboard()

    if IsUiappRunningByHash(`character_creator`) == 1 then
        CloseUiappByHash(`character_creator`)
    end

    if IsUiappRunningByHash(`shop_menu`) == 1 then
        CreatorMenu:Close()
    end

    if IsUiappTransitioningByHash(`character_creator`) or IsUiappTransitioningByHash(`shop_menu`) then
        return
    end

    self:ReleaseHeads()
    RemoveAnimDict("face_human@gen_male@base")

    if self:IsFlagSet(EDITOR_FLAG.CONFIRMED) then
        SignalBus:emit("menu_confirm")
    elseif self:IsFlagSet(EDITOR_FLAG.CANCELLED) then
        SignalBus:emit("menu_cancel")
    end

    CreatorXml:Reset()
    CreatorMenu:Reset()

    self:Reset()
end

function Creator:UpdateStateQuickSwitch()
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    DisableAllControlActions(0)

    if IsUiappRunningByHash(`character_creator`) == 1 then
        CloseUiappByHash(`character_creator`)
    end

    if CanLaunchUiappByHash(`character_creator`) ~= 1 then
        return
    end

    self:ClearFlag(EDITOR_FLAG.QUICK_SWITCH)
    self:ClearFlag(EDITOR_FLAG.MENU_RUNNING)
    self:ClearFlag(EDITOR_FLAG.EDITOR_RUNNING)

    if self:IsAdvancedMode() then
        self:OpenEditor(CREATOR_MODE.DEFAULT)
    else
        self:OpenEditor(CREATOR_MODE.ADVANCED)
    end

    self:SetState(EDITOR_STATE.TRANSITION_TO_EDITOR)
end

function Creator:PreloadAnimations()
    for _, dict in ipairs({ "face_human@gen_male@base", "mp_character_creator@male@fidgets", "mp_character_creator@female@fidgets" }) do
        RequestAnimDict(dict)
        if HasAnimDictLoaded(dict) ~= 1 then
            return false
        end
    end

    RequestMoveNetworkDef("Character_Creator")
    if HasMoveNetworkDefLoaded("Character_Creator") ~= 1 then
        return false
    end

    for _, clipset in ipairs({ "clipset@mp_character_creator@male", "clipset@mp_character_creator@female" }) do
        RequestClipSet(clipset)
        if HasClipSetLoaded(clipset) ~= 1 then
            return false
        end
    end

    return true
end

function Creator:InitHeadRequests()
    local pedType = GetMetaPedType(Character.ped)
    local heritages = CreatorPresets:GetHeritages()

    for _, heritage in ipairs(heritages) do
        CreatorPresets:SetHeritage(heritage.index)

        local items = CreatorPresets:GetHeadShopItems()
        for _, item in ipairs(items) do
            local requestHandle = RequestMetaPedComponent(pedType, item.id, 0, 1, 1)

            self.headRequests[#self.headRequests + 1] = {
                hash = item.id,
                handle = requestHandle,
                loaded = false,
            }
        end
    end
end

function Creator:PreloadHeads()
    if self:IsFlagSet(EDITOR_FLAG.HEADS_REQUESTED) then
        self:InitHeadRequests()
        self:SetFlag(EDITOR_FLAG.HEADS_REQUESTED)
        return false
    end

    local allLoaded = true
    for _, request in ipairs(self.headRequests) do
        request.loaded = HasMetaPedAssetLoaded(request.handle) == 1
        if not request.loaded then allLoaded = false end
    end

    return allLoaded
end

function Creator:ReleaseHeads()
    for _, item in ipairs(self.headRequests) do
        ReleaseMetaPedAssetRequest(item.handle)
        item.loaded = false
    end

    self:ClearFlag(EDITOR_FLAG.HEADS_REQUESTED)
end

function Creator:SetMode(mode)
    self.mode = mode
    CreatorRenderer:UpdateText()
end

function Creator:GetMode()
    return self.mode
end

function Creator:IsDefaultMode()
    return self.mode == CREATOR_MODE.DEFAULT
end

function Creator:IsAdvancedMode()
    return self.mode == CREATOR_MODE.ADVANCED
end

function Creator:IsFlagSet(flag)
    return (self.flags & flag) ~= 0
end

function Creator:SetFlag(flag)
    Utils:Debug(string.format("Setting flag %s", EDITOR_FLAG:ToString(flag)))
    self.flags = (self.flags or 0) | flag
end

function Creator:ClearFlag(flag)
    Utils:Debug(string.format("Clearing flag %s", EDITOR_FLAG:ToString(flag)))
    self.flags = (self.flags or 0) & (~flag)
end

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Creator:UpdateStateTeardown()
end)
