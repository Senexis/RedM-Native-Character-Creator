local function GetDefaultData()
    return {
        config = 0,
        flags = EDITOR_FLAG.CLEAR,
        state = EDITOR_STATE.INIT,
        stateChangeTime = 0,
        headRequests = {},
        bodyRequests = {},
        mode = CREATOR_MODE.DEFAULT,
        restoreTarget = 0,
    }
end

local defaults = GetDefaultData()
Creator = setmetatable({}, { __index = defaults })

function Creator:Reset()
    defaults = GetDefaultData()

    for k, v in pairs(defaults) do
        if type(v) ~= "function" then
            self[k] = v
        end
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

function Creator:OpenEditor(mode, restore)
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    if restore then
        self.restoreTarget = CreatorEvents.currentPage or 0
        self:SetFlag(EDITOR_FLAG.RESTORE)
    end

    self:SetMode(mode)
    self:SetFlag(EDITOR_FLAG.EDITOR_ACTIVE)
end

function Creator:CloseEditor()
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    if CreatorMenu then
        CreatorMenu:Confirm()
    end

    self:ClearFlag(EDITOR_FLAG.EDITOR_ACTIVE)
end

function Creator:QuickSwitch()
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    Creator:SetFlag(EDITOR_FLAG.QUICK_SWITCH)
end

function Creator:QuickSettings()
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    Creator:SetFlag(EDITOR_FLAG.QUICK_SETTINGS)
end

function Creator:Rename()
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    -- Name entry via SC keyboard does not work offline / on RedM for this UI path.
    if not IntroConfig.UsesMainMenu() then
        return
    end

    local maxNameLength = CreatorConfig.MaxNameLength or 50
    NextOnscreenKeyboardResultWillDisplayUsingTheseFonts(256)
    DisplayOnscreenKeyboard(4, "NAME_TITLE_PROMPT", "", Character.name or "", "", "", "", maxNameLength)

    self:SetFlag(EDITOR_FLAG.NAME_PROMPT)
end

function Creator:Import()
    NuiHelper:Open({
        version = CHARACTER_VERSION,
        maxNameLength = CreatorConfig.MaxNameLength or 50,
        pedType = Character:GetPedType(),
        pedModel = Character:GetModel(),
        placeholderName = Character:GenerateName(),
        placeholderAge = Character:GenerateAge()
    })

    self:SetFlag(EDITOR_FLAG.IMPORT_PROMPT)
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
    elseif self.state == EDITOR_STATE.QUICK_SETTINGS then
        self:UpdateStateQuickSettings()
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
        Utils:Warn("Warning: You shouldn't be using a player ped as the editor entity directly")
        Utils:Warn("This can cause sync issues with other players, please use networked clones instead")
    end

    self:SetState(EDITOR_STATE.SETUP)
end

function Creator:UpdateStateSetup()
    DisableAllControlActions(0)

    if not CreatorXml:Initialize() then
        return
    end

    CreatorXml:RequestReset(0)

    local config = Character:GetCreatorConfig()
    if not CreatorPresets:Init(config) then
        Utils:Error(string.format("Editor config %s not defined in XML", EDITOR_CONFIG:ToString(config)))
        self:SetState(EDITOR_STATE.TEARDOWN)
        return
    end

    if not self:PreloadAnimations() then
        return
    end

    if not self:PreloadHeads() then
        return
    end

    if not self:PreloadBodies() then
        return
    end

    Character:ApplyAll()

    local startMode = IntroConfig.GetStartMode()
    if startMode == CREATOR_MODE.DEFAULT or startMode == CREATOR_MODE.ADVANCED then
        self:OpenEditor(startMode, false)
        self:SetState(EDITOR_STATE.TRANSITION_TO_EDITOR)
    else
        self:SetState(EDITOR_STATE.TRANSITION_TO_MENU)
    end
end

function Creator:UpdateStateInMenu()
    if IsUiappRunningByHash(`character_creator`) == 1 then
        CloseUiappByHash(`character_creator`)
        SignalBus:emit("character_creator_closed")
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
        local result = GetOnscreenKeyboardResult()
        Character:ApplyName(result)
        CreatorMenu:Refresh()
        self:ClearFlag(EDITOR_FLAG.NAME_PROMPT)
    end

    if not self:IsFlagSet(EDITOR_FLAG.MENU_RUNNING) then
        DisableAllControlActions(0)

        if CanLaunchUiappByHash(`shop_menu`) ~= 1 then
            return
        end

        local rerolling = self:IsFlagSet(EDITOR_FLAG.REROLLING)
        local toSettings = self:IsFlagSet(EDITOR_FLAG.QUICK_SETTINGS)
        CreatorMenu:Open(rerolling, toSettings)

        if IsUiappActiveByHash(`shop_menu`) ~= 1 then
            return
        end

        self:ClearFlag(EDITOR_FLAG.EDITOR_RUNNING)
        self:SetFlag(EDITOR_FLAG.MENU_RUNNING)
        self:ClearFlag(EDITOR_FLAG.QUICK_SETTINGS)
    end
end

function Creator:UpdateStateInEditor()
    if self:IsFlagSet(EDITOR_FLAG.NAME_PROMPT) then
        local status = UpdateOnscreenKeyboard()
        if status == 1 then
            Character:ApplyName(GetOnscreenKeyboardResult())
            CreatorDatabinding:WriteString(DATABINDING_ID.MAIN__NAME__VALUE, Character.name or "")
            self:ClearFlag(EDITOR_FLAG.NAME_PROMPT)
        elseif status == 2 or status == 3 then
            self:ClearFlag(EDITOR_FLAG.NAME_PROMPT)
        end
    else
        CancelOnscreenKeyboard()
    end

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

    if self:IsFlagSet(EDITOR_FLAG.QUICK_SETTINGS) then
        self:SetState(EDITOR_STATE.QUICK_SETTINGS)
        return
    end

    if not self:IsFlagSet(EDITOR_FLAG.EDITOR_ACTIVE) then
        if IntroConfig.UsesMainMenu() then
            self:SetState(EDITOR_STATE.TRANSITION_TO_MENU)
        else
            -- back from basic/advanced should return to gender select
            self:Finish(false)
            self:SetState(EDITOR_STATE.TEARDOWN)
        end
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

    if self:IsFlagSet(EDITOR_FLAG.RESTORE) then
        if not self.restoreTarget then
            self:ClearFlag(EDITOR_FLAG.RESTORE)
            return
        end

        if IsUiappActiveByHash(`character_creator`) ~= 1 then
            self:ClearFlag(EDITOR_FLAG.RESTORE)
            return
        end

        if IsUiappTransitioningByHash(`character_creator`) == 1 then
            return
        end

        local currentActivity = GetUiappCurrentActivityByHash(`character_creator`)
        if currentActivity == 0 or currentActivity == `character_creator` then
            Utils:Debug("No activity detected, we are not running the creator")
            self:ClearFlag(EDITOR_FLAG.RESTORE)
            return
        end

        local currentPage = UI_PAGE_ID:GetIdFromActivity(currentActivity) or UI_PAGE_ID.INVALID
        local targetPage = UI_PAGE_ID:GetIdFromHash(self.restoreTarget) or UI_PAGE_ID.INVALID

        if currentPage == UI_PAGE_ID.INVALID or targetPage == UI_PAGE_ID.INVALID then
            Utils:Error("Invalid activity or restore target:", tostring(currentActivity), tostring(self.restoreTarget))
            self:ClearFlag(EDITOR_FLAG.RESTORE)
            return
        end

        if currentPage == targetPage then
            self:ClearFlag(EDITOR_FLAG.RESTORE)
            return
        end

        local transitions = UI_PAGE_ID:GetLink(targetPage)
        if not transitions then
            Utils:Debug("No link to page found for target page:", UI_PAGE_ID:ToString(targetPage))
            self:ClearFlag(EDITOR_FLAG.RESTORE)
            return
        end

        local transition = transitions[currentPage]
        if not transition then
            Utils:Debug("No transition found for current page:", UI_PAGE_ID:ToString(currentPage))
            self:ClearFlag(EDITOR_FLAG.RESTORE)
            return
        end

        local lastTransition = nil
        for _, v in pairs(transitions) do
            lastTransition = v
        end

        if lastTransition == transition then
            Utils:Debug("Clearing restore flag before transitioning to", tostring(transition))
            self:ClearFlag(EDITOR_FLAG.RESTORE)
        else
            Utils:Debug("Transitioning to", tostring(transition))
        end

        if RequestUiappTransitionByHash(`character_creator`, transition) ~= 1 then
            Utils:Warn("Failed to transition into", tostring(transition))
        end
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
        SignalBus:emit("character_creator_closed")
    end

    if IsUiappRunningByHash(`shop_menu`) == 1 then
        CreatorMenu:Close()
    end

    if IsUiappTransitioningByHash(`character_creator`) or IsUiappTransitioningByHash(`shop_menu`) then
        return
    end

    self:ReleaseHeads()
    self:ReleaseBodies()
    RemoveAnimDict("face_human@gen_male@base")

    if self:IsFlagSet(EDITOR_FLAG.CONFIRMED) then
        SignalBus:emit("menu_confirm")
    elseif self:IsFlagSet(EDITOR_FLAG.CANCELLED) then
        SignalBus:emit("menu_cancel")
    end

    IntroXml:Reset()
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
        SignalBus:emit("character_creator_closed")
    end

    if CanLaunchUiappByHash(`character_creator`) ~= 1 then
        return
    end

    self:ClearFlag(EDITOR_FLAG.QUICK_SWITCH)
    self:ClearFlag(EDITOR_FLAG.MENU_RUNNING)
    self:ClearFlag(EDITOR_FLAG.EDITOR_RUNNING)

    if self:IsAdvancedMode() then
        self:OpenEditor(CREATOR_MODE.DEFAULT, true)
    else
        self:OpenEditor(CREATOR_MODE.ADVANCED, true)
    end

    self:SetState(EDITOR_STATE.TRANSITION_TO_EDITOR)
end

function Creator:UpdateStateQuickSettings()
    if not self:IsFlagSet(EDITOR_FLAG.ACTIVE) then
        return
    end

    DisableAllControlActions(0)

    if IsUiappRunningByHash(`character_creator`) == 1 then
        CloseUiappByHash(`character_creator`)
        SignalBus:emit("character_creator_closed")
    end

    if CanLaunchUiappByHash(`shop_menu`) ~= 1 then
        return
    end

    self:ClearFlag(EDITOR_FLAG.MENU_RUNNING)
    self:ClearFlag(EDITOR_FLAG.EDITOR_ACTIVE)
    self:ClearFlag(EDITOR_FLAG.EDITOR_RUNNING)

    self:SetState(EDITOR_STATE.IN_MENU)
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
    local ped = Character:GetPed()
    local pedType = GetMetaPedType(ped)
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
    if not self:IsFlagSet(EDITOR_FLAG.HEADS_REQUESTED) then
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

function Creator:InitBodyRequests()
    local ped = Character:GetPed()
    local pedType = GetMetaPedType(ped)
    local skintones = CreatorPresets:GetSkintones()
    local bodyBuilds = CreatorPresets:GetBodyBuilds()

    for _, skintoneItem in ipairs(skintones) do
        for _, buildItem in ipairs(bodyBuilds) do
            local build = CreatorPresets:GetBodyBuild(buildItem.index)
            local body = CreatorPresets:GetBodyShopItems(skintoneItem.skintone, build)

            if body.upper then
                local upperHandle = RequestMetaPedComponent(pedType, body.upper, 0, 1, 1)
                self.bodyRequests[#self.bodyRequests + 1] = {
                    hash = body.upper,
                    handle = upperHandle,
                    loaded = false,
                }
            end

            if body.lower then
                local lowerHandle = RequestMetaPedComponent(pedType, body.lower, 0, 1, 1)
                self.bodyRequests[#self.bodyRequests + 1] = {
                    hash = body.lower,
                    handle = lowerHandle,
                    loaded = false,
                }
            end
        end
    end
end

function Creator:PreloadBodies()
    if not self:IsFlagSet(EDITOR_FLAG.BODIES_REQUESTED) then
        self:InitBodyRequests()
        self:SetFlag(EDITOR_FLAG.BODIES_REQUESTED)
        return false
    end

    local allLoaded = true
    for _, request in ipairs(self.bodyRequests) do
        request.loaded = HasMetaPedAssetLoaded(request.handle) == 1
        if not request.loaded then allLoaded = false end
    end

    return allLoaded
end

function Creator:ReleaseBodies()
    for _, item in ipairs(self.bodyRequests) do
        ReleaseMetaPedAssetRequest(item.handle)
        item.loaded = false
    end

    self:ClearFlag(EDITOR_FLAG.BODIES_REQUESTED)
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

SignalBus:on("character_paste_opened", function()
    Creator:SetFlag(EDITOR_FLAG.IMPORT_PROMPT)
end)

SignalBus:on("character_paste_closed", function()
    Creator:ClearFlag(EDITOR_FLAG.IMPORT_PROMPT)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Creator:UpdateStateTeardown()
end)
