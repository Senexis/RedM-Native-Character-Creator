local TIMEOUT_INIT = 1000 * 60
local TIMEOUT_LOAD = 1000 * 60
local TIMEOUT_GENERIC = 1000 * 30

local INTRO_IPLS <const> = {
    `MP001_MP_LOBBY_CHARMILO`,
    `MP001_MP_LOBBY_CHARMILO_EXT`,
    `MP001_MP_LOBBY_CHARMILO_VEG`,
}

local function GetDefaultData()
    return {
        flags = INTRO_FLAG.CLEAR,
        state = INTRO_STATE.WAITING_TO_START,
        stateChangeTime = 0,

        toEditState = INTRO_TO_EDIT_STATE.INIT,
        backStartState = INTRO_BACK_START_STATE.INIT,
        toPhotoState = INTRO_TO_PHOTO_STATE.INIT,
        backEditState = INTRO_BACK_EDIT_STATE.INIT,
        mugshotState = INTRO_MUGSHOT_STATE.PROMPT,
        subStateChangeTime = 0,

        editorLastTime = 0,
        editorResult = INTRO_EDITOR_STATUS.STOPPED,

        playerPedId = 0,
        playerId = 0,
        playerIndex = 0,
        playerExitPosition = vector3(0, 0, 0),
        playerExitHeading = 0.0,

        config = {},
        guardPed = 0,
        sheriffPed = 0,
        presetPeds = {},
        presetData = {},

        selectedPreset = 0,

        initCamera = 0,
        presetCameras = {},
        editCamera = 0,
        editCameraInterp = 0,
        currentEditViewId = EDITOR_VIEW.INVALID,
        currentEditViewData = {},
        currentEditorCameraData = {},
        portraitCamera = 0,

        dialogParticipants = {},
        nextCustomizeTime = 0,
        nextCustomizeLine = 0,

        alertHandle = 0,
        prompts = {},
        objectiveShown = false,

        animScene = 0,
        lightrig = 0,

        mugshotTimer = 3,
        mugshotShowUi = true,
        photoPostfx = 0,

        clothingLevel = CLOTHING_SETTING.DEFAULT,
        savedOutfitItems = {},
    }
end

local defaults = GetDefaultData()
Intro = setmetatable({}, { __index = defaults })

function Intro:Reset()
    defaults = GetDefaultData()

    for k, v in pairs(defaults) do
        if type(v) ~= "function" then
            self[k] = v
        end
    end
end

function Intro:SetState(state, sub)
    if sub == "TO_EDIT" then
        self.toEditState = state
    elseif sub == "BACK_START" then
        self.backStartState = state
    elseif sub == "TO_PHOTO" then
        self.toPhotoState = state
    elseif sub == "BACK_EDIT" then
        self.backEditState = state
    elseif sub == "MUGSHOT" then
        self.mugshotState = state
    else
        self.state = state
    end

    if sub then
        self.subStateChangeTime = GetGameTimer()
    else
        self.stateChangeTime = GetGameTimer()
    end
end

function Intro:Start()
    self:SetState(INTRO_STATE.INIT)
end

function Intro:Reroll(data)
    if data then
        self.rerollImportData = data
    end
    self:SetFlag(INTRO_FLAG.IS_REROLLING)
    self:SetState(INTRO_STATE.INIT)
end

function Intro:Maintain()
    if self.state == INTRO_STATE.WAITING_TO_START then
        Wait(250)
        return
    end

    local ok, result = false, nil
    if self.state == INTRO_STATE.INIT then
        ok, result = pcall(self.MaintainInit, self)
    elseif self.state == INTRO_STATE.LOAD_ASSETS then
        ok, result = pcall(self.MaintainLoadAssets, self)
    elseif self.state == INTRO_STATE.LOAD_AREA then
        ok, result = pcall(self.MaintainLoadArea, self)
    elseif self.state == INTRO_STATE.CREATE_MOCAP_PEDS then
        ok, result = pcall(self.MaintainCreateMocapPeds, self)
    elseif self.state == INTRO_STATE.CREATE_PED_PRESETS then
        ok, result = pcall(self.MaintainCreatePedPresets, self)
    elseif self.state == INTRO_STATE.APPLY_RANDOMIZATION then
        ok, result = pcall(self.MaintainApplyRandomization, self)
    elseif self.state == INTRO_STATE.APPLY_CLOTHES then
        ok, result = pcall(self.MaintainApplyClothes, self)
    elseif self.state == INTRO_STATE.INIT_CAM then
        ok, result = pcall(self.MaintainInitCam, self)
    elseif self.state == INTRO_STATE.INTRO then
        ok, result = pcall(self.MaintainIntro, self)
    elseif self.state == INTRO_STATE.SELECT_GENDER then
        ok, result = pcall(self.MaintainSelectGender, self)
    elseif self.state == INTRO_STATE.TRANSITION_TO_CUSTOMIZE then
        ok, result = pcall(self.MaintainTransitionToCustomize, self)
    elseif self.state == INTRO_STATE.TRANSITION_BACK_TO_INTRO then
        ok, result = pcall(self.MaintainTransitionBackToIntro, self)
    elseif self.state == INTRO_STATE.CUSTOMIZE then
        ok, result = pcall(self.MaintainCustomizePed, self)
    elseif self.state == INTRO_STATE.TRANSITION_TO_MUGSHOT then
        ok, result = pcall(self.MaintainTransitionToMugshot, self)
    elseif self.state == INTRO_STATE.TRANSITION_BACK_TO_CUSTOMIZE then
        ok, result = pcall(self.MaintainTransitionBackToCustomize, self)
    elseif self.state == INTRO_STATE.MUGSHOT then
        ok, result = pcall(self.MaintainMugshot, self)
    elseif self.state == INTRO_STATE.CANCEL_BACK_TO_FREEROAM then
        ok, result = pcall(self.MaintainCancelBackToFreeroam, self)
    elseif self.state == INTRO_STATE.EXIT then
        ok, result = pcall(self.MaintainExit, self)
    end

    if not ok then
        local code = (self.state * 100) + 99
        self:Error("An unexpected error occurred. Please try again.", code)
        print("[NativeCC] ERROR: " .. result)
    end
end

function Intro:MaintainInit()
    if GetGameTimer() - self.stateChangeTime > TIMEOUT_INIT then
        self:Error("Failed to initialize. Please try again.", 0101)
        return
    end

    if not self:FadeOutScreen(2000) then
        return
    end

    CloseAllUiapps()
    UiFeedClearAllChannels()

    self.playerId = PlayerId()
    self.playerPedId = PlayerPedId()
    self.playerIndex = GetPlayerIndex()
    self.playerExitPosition = GetEntityCoords(self.playerPedId)
    self.playerExitHeading = GetEntityHeading(self.playerPedId)

    SetOverrideWeather(`SUNNY`)
    NetworkClockTimeOverride(10, 0, 0, 0, true)
    SetTimecycleModifier("Online_Character_Editor")
    ReserveNetworkClientMissionPeds(4)

    for _, ipl in ipairs(INTRO_IPLS) do
        self:RequestIplHashSafe(ipl)
    end

    TextBlockRequest("NETCHAR")
    EnableHudContext(`HUD_CTX_CHARACTER_CREATOR`)
    RequestAnimDict("mech_loco@generic@handcuffed")

    self:SetState(INTRO_STATE.LOAD_ASSETS)
end

function Intro:MaintainLoadAssets()
    if HasAnimDictLoaded("mech_loco@generic@handcuffed") ~= 1 then
        Utils:Debug("MAINTAIN_LOAD_ASSETS - waiting for animation to load")
        return
    end

    if not self:LoadAnimations() then
        Utils:Debug("MAINTAIN_LOAD_ASSETS - ANIM not loaded! | EXIT")
        return
    end

    if PrepareSoundset("RDRO_Character_Creator_Sounds", false) ~= 1 then
        if GetGameTimer() - self.stateChangeTime < 1000 then
            Utils:Debug("MAINTAIN_LOAD_ASSETS - Sound not loaded! - RDRO_Character_Creator_Sounds | EXIT")
            return
        end

        Utils:Debug("MAINTAIN_LOAD_ASSETS - Sound not loaded! - RDRO_Character_Creator_Sounds | SKIP")
    end

    if PrepareSoundset("HUD_Donate_Sounds", false) ~= 1 then
        if GetGameTimer() - self.stateChangeTime < 1000 then
            Utils:Debug("MAINTAIN_LOAD_ASSETS - Sound not loaded! - HUD_Donate_Sounds | EXIT")
            return
        end

        Utils:Debug("MAINTAIN_LOAD_ASSETS - Sound not loaded! - HUD_Donate_Sounds | SKIP")
    end

    if TextBlockIsLoaded("CHARAUD") ~= 1 then
        TextBlockRequest("CHARAUD")
        Utils:Debug("MAINTAIN_LOAD_ASSETS - waiting for subtitle block 'CHARAUD' to load")
        return
    end

    if TextBlockIsLoaded("NETCHAR") ~= 1 then
        TextBlockRequest("NETCHAR")
        Utils:Debug("MAINTAIN_LOAD_ASSETS - waiting for text block 'NETCHAR' to load")
        return
    end

    if not IntroXml:Initialize() then
        if GetGameTimer() - self.stateChangeTime > TIMEOUT_GENERIC then
            self:Error("Failed to initialize required data. Please try again.", 0201)
        end

        Utils:Debug("MAINTAIN_LOAD_ASSETS - waiting for parsed data to load")
        return
    end

    if not self:LoadConfiguration() then
        if GetGameTimer() - self.stateChangeTime > TIMEOUT_GENERIC then
            self:Error("Failed to load required data. Please try again.", 0202)
        end

        Utils:Debug("MAINTAIN_LOAD_ASSETS - failed to load configuration")
        return
    end

    IntroXml:Reset()
    CreatorXml:Reset()
    Creator:Initialize()

    SetAmbientZoneListState("AZL_RDRO_Character_Creation_Area", true, true)
    SetAmbientZoneListState("AZL_RDRO_Character_Creation_Area_Other_Zones_Disable", false, true)
    Utils:Debug("MAINTAIN_LOAD_ASSETS - Sound loaded")

    self:TriggerMusicEventSafe("MP_CHARACTER_CREATION_START", false)

    AnimpostfxPreloadPostfx("RespawnPulse01")

    self:SetState(INTRO_STATE.LOAD_AREA)
end

function Intro:MaintainLoadArea()
    local pos = vector3(-561.4, -3782.6, 237.6)
    local heading = 166.8

    if not self:IsFlagSet(INTRO_FLAG.PLAYER_POSITION_IN_INTRO) then
        Utils:Debug("MAINTAIN_LOAD_AREA - placing player at the editor position")

        if IsEntityDead(self.playerPedId) then
            Utils:Debug("MAINTAIN_LOAD_AREA - resurrecting the player's ped")
            ResurrectPed(self.playerPedId)
        end

        for _, ipl in ipairs(INTRO_IPLS) do
            if IsIplActiveHash(ipl) ~= 1 then
                Utils:Debug("MAINTAIN_LOAD_AREA - loading IPL ", ipl)
                return
            end
        end

        SetEntityCoordsAndHeading(self.playerPedId, pos.x, pos.y, pos.z, heading, true, false, true)
        SetEntityVisible(self.playerPedId, false)
        SetPlayerInvincible(self.playerIndex, true)

        LoadSceneStartSphere(pos.x, pos.y, pos.z, 50.0, 4)

        self:SetFlag(INTRO_FLAG.PLAYER_POSITION_IN_INTRO)
    end

    if IsLoadSceneActive() ~= 1 then
        Utils:Debug("MAINTAIN_LOAD_AREA - load scene is not active, re-starting it")
        LoadSceneStartSphere(pos.x, pos.y, pos.z, 50.0, 0)
        return
    end

    if IsLoadSceneLoaded() ~= 1 then
        if GetGameTimer() - self.stateChangeTime > TIMEOUT_LOAD then
            Utils:Debug("MAINTAIN_LOAD_AREA - load scene timed out!")
            goto load_timeout
        end

        return
    end

    ::load_timeout::

    LoadSceneStop()
    ClearArea(pos.x, pos.y, pos.z, 50.0, 1 << 14)

    self:SetState(INTRO_STATE.CREATE_MOCAP_PEDS)
end

function Intro:MaintainCreateMocapPeds()
    if self:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
        self:SetState(INTRO_STATE.CREATE_PED_PRESETS)
        return
    end

    if HasModelLoaded(self.config.guardPedModel) ~= 1 then
        Utils:Debug("MAINTAIN_CREATE_MOCAP_PEDS - waiting for guard ped model to load")
        return
    end

    if HasModelLoaded(self.config.sheriffPedModel) ~= 1 then
        Utils:Debug("MAINTAIN_CREATE_MOCAP_PEDS - waiting for sheriff ped model to load")
        return
    end

    if CanRegisterMissionPeds(4) ~= 1 then
        Utils:Debug("MAINTAIN_CREATE_MOCAP_PEDS - waiting to be able to register mission peds to spawn peds")
        return
    end

    if DoesEntityExist(self.guardPed) ~= 1 then
        local model = self.config.guardPedModel
        local outfit = self.config.guardPedOutfit
        local pos = self.config.guardPedPosition
        local heading = self.config.guardPedHeading

        local ped = CreatePed(model, pos.x, pos.y, pos.z, heading, true, true, false, false)
        SetEntityInvincible(ped, true)
        EquipMetaPedOutfit(ped, outfit)
        UpdatePedVariation(ped, false, true, true, true, false)
        StopPedSpeaking(ped, true)
        AddEntityToAudioMixGroup(ped, "rdro_character_creator_guard_group", 0.0)

        self:SetLockonDisabled(ped)
        self:AddDialogueParticipant(ped, "CHAR_DEPMARSHAL")

        GiveWeaponToPed(ped, `WEAPON_REPEATER_CARBINE`, 100, true, false, 0, false, 0.5, 1.0, `ADD_REASON_DEFAULT`, false, 0.0, false)
        Utils:Debug("MAINTAIN_CREATE_MOCAP_PEDS - CCAS - carbine given to deputy")

        self.guardPed = ped

        Utils:Debug("MAINTAIN_CREATE_MOCAP_PEDS - creating guard ped")
        return
    end

    FreezeEntityPosition(self.guardPed, true)

    if DoesEntityExist(self.sheriffPed) ~= 1 then
        local model = self.config.sheriffPedModel
        local outfit = self.config.sheriffPedOutfit
        local pos = self.config.sheriffPedPosition
        local heading = self.config.sheriffPedHeading

        local ped = CreatePed(model, pos.x, pos.y, pos.z, heading, true, true, false, false)
        SetEntityInvincible(ped, true)
        EquipMetaPedOutfit(ped, outfit)
        UpdatePedVariation(ped, false, true, true, true, false)
        StopPedSpeaking(ped, true)
        AddEntityToAudioMixGroup(ped, "rdro_character_creator_guard_group", 0.0)

        self:SetLockonDisabled(ped)
        self:AddDialogueParticipant(ped, "BLW_Police_Chief")

        self.sheriffPed = ped

        Utils:Debug("MAINTAIN_CREATE_MOCAP_PEDS - creating sheriff ped")
        return
    end

    FreezeEntityPosition(self.sheriffPed, true)

    self:SetState(INTRO_STATE.CREATE_PED_PRESETS)
end

function Intro:MaintainCreatePedPresets()
    if self:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
        if IsPedModel(self.playerPedId, `MP_MALE`) then
            ClonePedToTarget(self.playerPedId, self.presetPeds[EDITOR_CONFIG.MALE])
        else
            ClonePedToTarget(self.playerPedId, self.presetPeds[EDITOR_CONFIG.FEMALE])
        end
    end

    if not self:CreatePedPreset(EDITOR_CONFIG.MALE) then
        if GetGameTimer() - self.stateChangeTime > TIMEOUT_GENERIC then
            self:Error("Failed to create the male character. Please try again.", 0501)
        end

        Utils:Debug("MAINTAIN_CREATE_PED_PRESETS - waiting for male ped preset to be created")
        return
    end

    if not self:CreatePedPreset(EDITOR_CONFIG.FEMALE) then
        if GetGameTimer() - self.stateChangeTime > TIMEOUT_GENERIC then
            self:Error("Failed to create the female character. Please try again.", 0502)
        end

        Utils:Debug("MAINTAIN_CREATE_PED_PRESETS - waiting for female ped preset to be created")
        return
    end

    if self:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
        if IsPedModel(self.playerPedId, `MP_MALE`) then
            ClonePedToTarget(self.playerPedId, self.presetPeds[EDITOR_CONFIG.MALE])
        else
            ClonePedToTarget(self.playerPedId, self.presetPeds[EDITOR_CONFIG.FEMALE])
        end

        self:SetState(INTRO_STATE.INIT_CAM)
    else
        self:SetState(INTRO_STATE.APPLY_CLOTHES)
    end
end

function Intro:MaintainApplyClothes()
    local malePed = self.presetPeds[EDITOR_CONFIG.MALE]
    local maleOutfits = IntroConfig.Outfits[EDITOR_CONFIG.MALE]
    local femalePed = self.presetPeds[EDITOR_CONFIG.FEMALE]
    local femaleOutfits = IntroConfig.Outfits[EDITOR_CONFIG.FEMALE]

    if IsPedReadyToRender(malePed) ~= 1 or IsPedReadyToRender(femalePed) ~= 1 then
        if GetGameTimer() - self.stateChangeTime > TIMEOUT_GENERIC then
            self:Error("Failed to create the characters. Please try again.", 0601)
        end

        return
    end

    local maleOutfitIndex = GetRandomIntInRange(1, #maleOutfits + 1)
    local maleOutfitClothes = maleOutfits[maleOutfitIndex] or {}

    for _, item in ipairs(maleOutfitClothes) do
        ApplyShopItemToPed(malePed, item, false, true, false)
    end

    self.savedOutfitItems[EDITOR_CONFIG.MALE] = maleOutfitClothes
    Utils:Debug("MAINTAIN_APPLY_CLOTHES - applied clothes to male ped")

    local femaleOutfitIndex = GetRandomIntInRange(1, #femaleOutfits + 1)
    local femaleOutfitClothes = femaleOutfits[femaleOutfitIndex] or {}

    for _, item in ipairs(femaleOutfitClothes) do
        ApplyShopItemToPed(femalePed, item, false, true, false)
    end

    self.savedOutfitItems[EDITOR_CONFIG.FEMALE] = femaleOutfitClothes
    Utils:Debug("MAINTAIN_APPLY_CLOTHES - applied clothes to female ped")

    self:SetState(INTRO_STATE.APPLY_RANDOMIZATION)
end

function Intro:MaintainApplyRandomization()
    local malePed = self.presetPeds[EDITOR_CONFIG.MALE]
    local femalePed = self.presetPeds[EDITOR_CONFIG.FEMALE]

    if IsPedReadyToRender(malePed) ~= 1 or IsPedReadyToRender(femalePed) ~= 1 then
        if GetGameTimer() - self.stateChangeTime > TIMEOUT_GENERIC then
            self:Error("Failed to create the characters. Please try again.", 0701)
        end

        return
    end

    if Character:IsFlagSet(CHARACTER_FLAG.DIRTY) then
        Utils:Debug("MAINTAIN_APPLY_RANDOMIZATION - waiting for character to be ready")
        return
    end

    if not self:IsFlagSet(INTRO_FLAG.MALE_PED_RANDOMIZED) then
        if not CreatorPresets:Init(EDITOR_CONFIG.MALE) then
            if GetGameTimer() - self.stateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to create the male character. Please try again.", 0702)
            end

            Utils:Debug("MAINTAIN_APPLY_RANDOMIZATION - failed to initialize male character presets")
            return
        end

        Utils:Debug("MAINTAIN_APPLY_RANDOMIZATION - initializing male character preset")

        Character:Reset()
        Character:SetPed(malePed)
        Character:RandomizeAll()

        self.presetData[EDITOR_CONFIG.MALE] = Character:Export()
        Utils:Debug("MAINTAIN_APPLY_RANDOMIZATION - male character randomized")

        self:SetFlag(INTRO_FLAG.MALE_PED_RANDOMIZED)

        return
    end

    if not self:IsFlagSet(INTRO_FLAG.FEMALE_PED_RANDOMIZED) then
        if not CreatorPresets:Init(EDITOR_CONFIG.FEMALE) then
            if GetGameTimer() - self.stateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to create the female character. Please try again.", 0703)
            end

            Utils:Debug("MAINTAIN_APPLY_RANDOMIZATION - failed to initialize female character presets")
            return
        end

        Utils:Debug("MAINTAIN_APPLY_RANDOMIZATION - initializing female character preset")

        Character:Reset()
        Character:SetPed(femalePed)
        Character:RandomizeAll()

        self.presetData[EDITOR_CONFIG.FEMALE] = Character:Export()
        Utils:Debug("MAINTAIN_APPLY_RANDOMIZATION - female character randomized")

        self:SetFlag(INTRO_FLAG.FEMALE_PED_RANDOMIZED)

        return
    end

    -- Reset to be ready for the editor
    Character:Reset()

    self:SetState(INTRO_STATE.INIT_CAM)
end

function Intro:MaintainInitCam()
    if DoesCamExist(self.initCamera) ~= 1 then
        self.initCamera = CreateCamera(`DEFAULT_SCRIPTED_CAMERA`, false)
        Utils:Debug("MAINTAIN_INIT_CAM - creating init camera")
    end

    if IsLoadingScreenVisible() then
        ShutdownLoadingScreen()
        Utils:Debug("MAINTAIN_INIT_CAM - shutting down the loading screen")
        return
    end

    if IsAnyUiappRunning() then
        CloseAllUiapps()
        Utils:Debug("MAINTAIN_INIT_CAM - closing all ui apps")
    end

    StartAnimScene(self.lightrig)
    SetAnimScenePlayList(self.lightrig, "Pl_Main", true)

    SetAnimSceneEntity(self.animScene, "Male_MP", self.presetPeds[EDITOR_CONFIG.MALE], 0)
    SetAnimSceneEntity(self.animScene, "Female_MP", self.presetPeds[EDITOR_CONFIG.FEMALE], 0)
    SetAnimSceneEntity(self.animScene, "Deputy", self.guardPed, 0)
    SetAnimSceneEntity(self.animScene, "Sheriff", self.sheriffPed, 0)
    StartAnimScene(self.animScene)

    if IntroConfig.UseCutscene ~= true or self:IsFlagSet(INTRO_FLAG.PED_PRESET_SELECTED) then
        local position = self.config.initCamPosition
        local rotation = self.config.initCamRotation
        local fov = self.config.initCamFov
        local focus = self.config.initCamFocus

        SetCamCoord(self.initCamera, position.x, position.y, position.z)
        SetCamRot(self.initCamera, rotation.x, rotation.y, rotation.z, 2)
        SetCamFov(self.initCamera, fov)
        SetCamFocusDistance(self.initCamera, focus)
        SetCamActive(self.initCamera, true)
        RenderScriptCams(true, false, 3000, true, false, 0)

        SetAnimScenePlayList(self.animScene, "pl_start_idle", true)
        Utils:Debug("MAINTAIN_INIT_CAM - CCAS - starting with idle")
    else
        SetAnimScenePlayList(self.animScene, "pl_intro", true)
        Utils:Debug("MAINTAIN_INIT_CAM - CCAS - starting with proper intro")
    end

    self:SetState(INTRO_STATE.INTRO)
end

function Intro:MaintainIntro()
    if self:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
        self:SetState(INTRO_STATE.SELECT_GENDER)
    elseif IsScreenFadedIn() ~= 1 then
        if not self:IsFlagSet(INTRO_FLAG.DELAYED_SCREEN_FADE_IN) then
            Utils:Debug("MAINTAIN_INTRO - waiting 1 more frame before fading in")
            self:SetFlag(INTRO_FLAG.DELAYED_SCREEN_FADE_IN)
            return
        end

        Utils:Debug("MAINTAIN_INTRO - fading in now")
        StopCurrentLoadingProgressTimer()
        DoScreenFadeIn(0)
        AnimpostfxPlay("RespawnPulse01")
    end

    DisableAllControlActions(0)
    EnableControlAction(0, `INPUT_FRONTEND_PAUSE`, true)

    if IsAnimSceneInSection(self.animScene, "s_start_idle", true) == 1 then
        if not self:IsFlagSet(INTRO_FLAG.PED_PRESET_SELECTED) then
            local target = EDITOR_CONFIG.MALE
            if GetRandomIntInRange(0, 2) == 0 then
                target = EDITOR_CONFIG.FEMALE
            end

            self:SetActivePedPreset(target, true)
            Utils:Debug("MAINTAIN_INTRO - active editor ped ", EDITOR_CONFIG:ToString(self.selectedPreset))
        end

        StartAudioSceneset("select_gender", "rdro_character_creator_scenes")
        Utils:Debug("MAINTAIN_INTRO - starting sceneset ")

        self:SetFlag(INTRO_FLAG.PED_PRESET_SELECTED)

        AnimpostfxStop("RespawnPulse01")
        Utils:Debug("MAINTAIN_INTRO - all peds positioned, moving to gender selection")

        self:SetState(INTRO_STATE.SELECT_GENDER)
    end

    if not self:IsFlagSet(INTRO_FLAG.PED_PRESET_SELECTED) and HasAnimEventFired(self.sheriffPed, 0x378A4083) then
        Utils:Debug("MAINTAIN_INTRO - CCAS - sheriff has finished his intro animation, starting idle")

        local position = self.config.initCamPosition
        local rotation = self.config.initCamRotation
        local fov = self.config.initCamFov
        local focus = self.config.initCamFocus

        SetCamCoord(self.initCamera, position.x, position.y, position.z)
        SetCamRot(self.initCamera, rotation.x, rotation.y, rotation.z, 2)
        SetCamFov(self.initCamera, fov)
        SetCamFocusDistance(self.initCamera, focus)
        SetCamActive(self.initCamera, true)
        RenderScriptCams(true, false, 3000, true, false, 0)
    end
end

function Intro:MaintainSelectGender()
    if self:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
        Utils:Debug("MAINTAIN_SELECT_GENDER - REROLL - Skipping this because you are in a reroll.. ")

        self.selectedPreset = EDITOR_CONFIG.MALE
        if IsPedModel(self.playerPedId, `MP_FEMALE`) then
            self.selectedPreset = EDITOR_CONFIG.FEMALE
        end

        Utils:Debug("MAINTAIN_SELECT_GENDER - REROLL - character editor started, transition to customize")
        self:SetFlag(INTRO_FLAG.GENDER_SELECT_SCENESET_SET)

        self:SetState(INTRO_STATE.TRANSITION_TO_CUSTOMIZE)
        return
    end

    if not self:FadeInScreen(2000) then
        Utils:Debug("MAINTAIN_SELECT_GENDER - still fading in... ")
        return
    end

    if self:IsFlagSet(INTRO_FLAG.RESET_CHARACTER) then
        if not self:ResetCharacter() then
            return
        end

        self:ClearFlag(INTRO_FLAG.RESET_CHARACTER)
    end

    if not self:IsFlagSet(INTRO_FLAG.IDLE_DIALOG_PLAYED) and GetGameTimer() - self.stateChangeTime > 1000 * 30 then
        self:CreateConversation("CHAR_IDLE")
        self:SetFlag(INTRO_FLAG.IDLE_DIALOG_PLAYED)
    end

    DisableAllControlActions(0)
    EnableControlAction(0, `INPUT_FRONTEND_PAUSE`, true)
    EnableControlAction(0, `INPUT_STICKY_FEED_ACCEPT`, true)
    EnableControlAction(0, `INPUT_STICKY_FEED_CANCEL`, true)
    EnableControlAction(0, `INPUT_STICKY_FEED_X`, true)
    EnableControlAction(0, `INPUT_STICKY_FEED_Y`, true)

    if not self.objectiveShown then
        self:CreateObjective("Choose a character")
        Utils:Debug("MAINTAIN_SELECT_GENDER - create objective text")
    end

    IntroAnimations:MaintainFidgets(EDITOR_CONFIG.MALE, self.presetPeds[EDITOR_CONFIG.MALE] or 0)
    IntroAnimations:MaintainFidgets(EDITOR_CONFIG.FEMALE, self.presetPeds[EDITOR_CONFIG.FEMALE] or 0)

    if self:IsFlagSet(INTRO_FLAG.FORCE_SELECT_ACTIVE_PED) then
        Utils:Debug("MAINTAIN_SELECT_GENDER - force selecting active ped")
        self:ClearFlag(INTRO_FLAG.FORCE_SELECT_ACTIVE_PED)
        self:SetState(INTRO_STATE.TRANSITION_TO_CUSTOMIZE)
        return
    end

    if not self:IsFlagSet(INTRO_FLAG.GENDER_SELECT_SCENESET_SET) then
        SetAudioSceneset("select_gender", "rdro_character_creator_scenes")
        Utils:Debug("MAINTAIN_SELECT_GENDER - setting gender sceneset")
        self:SetFlag(INTRO_FLAG.GENDER_SELECT_SCENESET_SET)
    end

    local presetCamera = self.presetCameras[self.selectedPreset] or 0
    if IsCamInterpolating(presetCamera) then
        DisableAllControlActions(0)
        EnableControlAction(0, `INPUT_FRONTEND_PAUSE`, true)
        self:RegisterCharacterPrompts(false)

        return
    end

    if self.selectedPreset == 0 then
        EnableControlAction(0, `INPUT_GAME_MENU_LEFT`, true)
        EnableControlAction(0, `INPUT_GAME_MENU_RIGHT`, true)
    elseif self.selectedPreset == EDITOR_CONFIG.MALE then
        EnableControlAction(0, `INPUT_GAME_MENU_RIGHT`, true)
        EnableControlAction(0, `INPUT_GAME_MENU_ACCEPT`, true)

        if self:IsFlagSet(INTRO_FLAG.MALE_PED_RANDOMIZED) then
            EnableControlAction(0, `INPUT_GAME_MENU_EXTRA_OPTION`, true)
        end
    elseif self.selectedPreset == EDITOR_CONFIG.FEMALE then
        EnableControlAction(0, `INPUT_GAME_MENU_LEFT`, true)
        EnableControlAction(0, `INPUT_GAME_MENU_ACCEPT`, true)

        if self:IsFlagSet(INTRO_FLAG.FEMALE_PED_RANDOMIZED) then
            EnableControlAction(0, `INPUT_GAME_MENU_EXTRA_OPTION`, true)
        end
    end

    self:RegisterCharacterPrompts(true)

    if IsControlJustPressed(0, `INPUT_GAME_MENU_LEFT`) then
        self:PlaySound("gender_left", "RDRO_Character_Creator_Sounds")
        self:SetActivePedPreset(EDITOR_CONFIG.MALE, false)
    elseif IsControlJustPressed(0, `INPUT_GAME_MENU_RIGHT`) then
        self:PlaySound("gender_right", "RDRO_Character_Creator_Sounds")
        self:SetActivePedPreset(EDITOR_CONFIG.FEMALE, false)
    elseif self.prompts.reset and UiPromptGetProgress(self.prompts.reset) == 1.0 then
        UiPromptRestartModes(self.prompts.reset)
        self:PlaySound("SELECT", "RDRO_Character_Creator_Sounds")
        self:SetFlag(INTRO_FLAG.RESET_CHARACTER)
    elseif IsControlJustPressed(0, `INPUT_GAME_MENU_ACCEPT`) then
        self:PlaySound("SELECT", "RDRO_Character_Creator_Sounds")
        self:DestroyPrompts()

        self:StopAllConversations()
        self:CreateConversation("CHAR_CHOOSE")
        self:SetupMirrorInteriorGroup()

        self:SetState(INTRO_STATE.TRANSITION_TO_CUSTOMIZE)
    end
end

function Intro:MaintainTransitionToCustomize()
    local presetPed = self.presetPeds[self.selectedPreset] or 0
    local genderModel = self.selectedPreset == EDITOR_CONFIG.MALE and "Male_MP" or "Female_MP"

    DisableAllControlActions(0)
    EnableControlAction(0, `INPUT_FRONTEND_PAUSE`, true)
    UiFeedClearChannel(3, true, false)

    if self.toEditState == INTRO_TO_EDIT_STATE.INIT then
        if not self:AnimSceneLoading(false) then
            return
        end

        self:SetupEditor()

        SetAnimSceneEntity(self.animScene, "Male_MP", self.presetPeds[EDITOR_CONFIG.MALE], 0)
        SetAnimSceneEntity(self.animScene, "Female_MP", self.presetPeds[EDITOR_CONFIG.FEMALE], 0)
        SetAnimSceneEntity(self.animScene, "Deputy", self.guardPed, 0)
        SetAnimSceneEntity(self.animScene, "Sheriff", self.sheriffPed, 0)

        if IsAnimSceneRunning(self.animScene, false) ~= 1 then
            StartAnimScene(self.animScene)
        end

        local playlist = self.selectedPreset == EDITOR_CONFIG.MALE and "Pl_Start_to_Edit_Male" or "Pl_Start_to_Edit_Female"
        SetAnimScenePlayList(self.animScene, playlist, true)

        self:SetupMirrorInteriorGroup()
        Utils:Debug("MAINTAIN_TRANSITION_TO_CUSTOMIZE - CCAS - start to edit playlist triggered")

        self:SetState(INTRO_TO_EDIT_STATE.CAM, "TO_EDIT")
    elseif self.toEditState == INTRO_TO_EDIT_STATE.CAM then
        if HasAnimEventFired(presetPed, 0x378A4083) ~= 1 then
            if GetGameTimer() - self.subStateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to transition. Please try again.", 1101)
            end

            return
        end

        if not DoesCamExist(self.editCamera) then
            self.editCamera = CreateCamera(`DEFAULT_SCRIPTED_CAMERA`, false)
        end

        local viewData = self.config.editorViews and self.config.editorViews[self.selectedPreset] and self.config.editorViews[self.selectedPreset][EDITOR_VIEW.FULL_BODY]
        if viewData then
            SetCamCoord(self.editCamera, viewData.position.x, viewData.position.y, viewData.position.z)
            SetCamRot(self.editCamera, viewData.rotation.x, viewData.rotation.y, viewData.rotation.z, 2)
            SetCamFov(self.editCamera, viewData.fov)
            SetCamFocusDistance(self.editCamera, viewData.focus)
            self.currentEditViewData = viewData
        end

        SetCamActive(self.editCamera, true)
        RenderScriptCams(true, false, 3000, true, false, 0)

        Utils:Debug("MAINTAIN_TRANSITION_TO_CUSTOMIZE - CCAS - cam set")

        self:SetState(INTRO_TO_EDIT_STATE.MOVE_NET, "TO_EDIT")
    elseif self.toEditState == INTRO_TO_EDIT_STATE.MOVE_NET then
        local exited = HasEntityExitedAnimScene(self.animScene, genderModel) == 1
        local exiting = IsEntityExitingAnimSceneThisFrame(self.animScene, genderModel) == 1
        local finished = HasAnimEventFired(presetPed, 0x63590D57) == 1

        if not (exited or exiting or finished) then
            return
        end

        IntroAnimations:MaintainAnimations(self.selectedPreset, presetPed)
        FreezeEntityPosition(presetPed, false)

        StartAudioSceneset("customization", "rdro_character_creator_scenes")
        Utils:Debug("MAINTAIN_TRANSITION_TO_CUSTOMIZE - CCAS - char made it to edit room")

        self:SetState(INTRO_TO_EDIT_STATE.COMPLETE, "TO_EDIT")
    elseif self.toEditState == INTRO_TO_EDIT_STATE.COMPLETE then
        IntroAnimations:MaintainAnimations(self.selectedPreset, presetPed)

        self:SetState(INTRO_STATE.CUSTOMIZE)
        self:SetState(INTRO_TO_EDIT_STATE.INIT, "TO_EDIT")
    end
end

function Intro:MaintainTransitionBackToIntro()
    local presetPed = self.presetPeds[self.selectedPreset] or 0

    self:ResetEditorSettings()

    DisableAllControlActions(0)
    EnableControlAction(0, `INPUT_FRONTEND_PAUSE`, true)

    if self.backStartState == INTRO_BACK_START_STATE.INIT then
        if not self:AnimSceneLoading(false) then
            return
        end

        SetAnimSceneEntity(self.animScene, "Male_MP", self.presetPeds[EDITOR_CONFIG.MALE], 0)
        SetAnimSceneEntity(self.animScene, "Female_MP", self.presetPeds[EDITOR_CONFIG.FEMALE], 0)
        SetAnimSceneEntity(self.animScene, "Deputy", self.guardPed, 0)
        SetAnimSceneEntity(self.animScene, "Sheriff", self.sheriffPed, 0)

        if IsAnimSceneRunning(self.animScene, false) ~= 1 then
            StartAnimScene(self.animScene)
        end

        local playlist = self.selectedPreset == EDITOR_CONFIG.MALE and "Pl_Edit_to_Start_Male" or "Pl_Edit_to_Start_Female"
        SetAnimScenePlayList(self.animScene, playlist, true)

        self:StopAllConversations()
        self:CreateConversation("CHAR_BACKSELECT")

        Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__TRANSITION_BACK_TO_INTRO - CCAS - char going back to selection room")

        self:SetState(INTRO_BACK_START_STATE.CAM, "BACK_START")
    elseif self.backStartState == INTRO_BACK_START_STATE.CAM then
        if HasAnimEventFired(presetPed, 0x378A4083) ~= 1 then
            if GetGameTimer() - self.subStateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to transition. Please try again.", 1201)
            end

            return
        end

        local camera = self.presetCameras[self.selectedPreset] or 0
        local data = self.config.presets[self.selectedPreset]
        local position = data.lineupCamPosition
        local rotation = data.lineupCamRotation
        local fov = data.lineupCamFov
        local focus = data.lineupCamFocus

        if DoesCamExist(camera) ~= 1 then
            camera = CreateCamera(`DEFAULT_SCRIPTED_CAMERA`, false)
            Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__TRANSITION_BACK_TO_INTRO - CCAS - creating gender select camera")
        end

        SetCamCoord(camera, position.x, position.y, position.z)
        SetCamRot(camera, rotation.x, rotation.y, rotation.z, 2)
        SetCamFov(camera, fov)
        SetCamFocusDistance(camera, focus)
        SetCamActive(camera, true)
        RenderScriptCams(true, false, 3000, true, false, 0)

        self.presetCameras[self.selectedPreset] = camera
        self:SetState(INTRO_BACK_START_STATE.COMPLETE, "BACK_START")
    elseif self.backStartState == INTRO_BACK_START_STATE.COMPLETE then
        if IsAnimSceneInSection(self.animScene, "s_start_idle", true) then
            self:SetState(INTRO_BACK_START_STATE.INIT, "BACK_START")
            self:SetState(INTRO_STATE.INTRO)
        end
    end
end

function Intro:MaintainCustomizePed()
    local presetPed = self.presetPeds[self.selectedPreset] or 0

    if self:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
        if IsScreenFadedIn() ~= 1 then
            if not self:IsFlagSet(INTRO_FLAG.DELAYED_SCREEN_FADE_IN) then
                Utils:Debug("MAINTAIN_CUSTOMIZE - waiting 1 more frame before fading in")
                self:SetFlag(INTRO_FLAG.DELAYED_SCREEN_FADE_IN)
                return
            end

            Utils:Debug("MAINTAIN_CUSTOMIZE - fading in now")
            StopCurrentLoadingProgressTimer()
            DoScreenFadeIn(0)
            AnimpostfxPlay("RespawnPulse01")
        end
    end

    if self:IsFlagSet(INTRO_FLAG.RESET_CHARACTER) then
        if not self:ResetCharacter() then
            return
        end

        self:ClearFlag(INTRO_FLAG.RESET_CHARACTER)
    end

    if not self:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
        self:CustomizeConversationUpdate()
    end

    if not self:IsFlagSet(INTRO_FLAG.CUSTOMIZATION_SCENESET_SET) then
        SetAudioSceneset("customization", "rdro_character_creator_scenes")
        Utils:Debug("MAINTAIN_CUSTOMIZE - setting custom sceneset")
        self:SetFlag(INTRO_FLAG.CUSTOMIZATION_SCENESET_SET)
    end

    if not self:AnimSceneLoading(false) then
        return
    end

    IntroAnimations:MaintainAnimations(self.selectedPreset, presetPed)

    if self.editorResult == INTRO_EDITOR_STATUS.STOPPED then
        if CanLaunchUiappByHash("shop_menu") ~= 1 then
            return
        end

        Utils:Debug("MAINTAIN_CUSTOMIZE - starting the character creator uiapp")
        local rerolling = self:IsFlagSet(INTRO_FLAG.IS_REROLLING)
        Creator:Open(rerolling, self.selectedPreset)

        self.editorLastTime = GetGameTimer()
        self.editorResult = INTRO_EDITOR_STATUS.RUNNING
    end

    if IsAnyUiappRunning() ~= 1 and UpdateOnscreenKeyboard() ~= 0 then
        if GetGameTimer() - self.editorLastTime > TIMEOUT_GENERIC then
            self:Error("Failed to start the Character Creator. Please try again.", 1301)
        end
    else
        self.editorLastTime = GetGameTimer()
    end

    if IsUiappRunningByHash("character_creator") == 1 and IsUiappTransitioningByHash("character_creator") ~= 1 then
        self:RegisterEditorPrompts(true)

        if IsControlJustPressed(2, `INPUT_GAME_MENU_TAB_LEFT_SECONDARY`) then
            self:PlaySound("SELECT", "RDRO_Character_Creator_Sounds")
            self:DestroyPrompts()
            Creator:QuickSettings()
        elseif IsControlJustPressed(2, `INPUT_GAME_MENU_LS`) then
            self:PlaySound("SELECT", "RDRO_Character_Creator_Sounds")
            self:DestroyPrompts()
            Creator:QuickSwitch()
        elseif self.prompts.reset and UiPromptGetProgress(self.prompts.reset) == 1.0 then
            UiPromptRestartModes(self.prompts.reset)
            self:PlaySound("SELECT", "RDRO_Character_Creator_Sounds")
            self:SetFlag(INTRO_FLAG.RESET_CHARACTER)
        end
    else
        self:DestroyPrompts()
    end

    if self.editorResult == INTRO_EDITOR_STATUS.RUNNING then
        IntroAnimations:MaintainFidgets(self.selectedPreset, presetPed)
    elseif self.editorResult == INTRO_EDITOR_STATUS.CANCEL then
        self.presetData[self.selectedPreset] = Character:Export()
        CancelOnscreenKeyboard()
        if self:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
            Utils:Debug("MAINTAIN_CUSTOMIZE - REROLL - player selected to cancel, going back to freeroam")
            self:SetState(INTRO_STATE.CANCEL_BACK_TO_FREEROAM)
        else
            Utils:Debug("MAINTAIN_CUSTOMIZE - REROLL - player selected to cancel, going back to gender selection")
            ResetAnimScene(self.animScene, "")
            self:SetState(INTRO_STATE.TRANSITION_BACK_TO_INTRO)
        end
        self.editorResult = INTRO_EDITOR_STATUS.STOPPED
    elseif self.editorResult == INTRO_EDITOR_STATUS.CONFIRM then
        self.presetData[self.selectedPreset] = Character:Export()
        CancelOnscreenKeyboard()
        ResetAnimScene(self.animScene, "")
        self:SetState(INTRO_STATE.TRANSITION_TO_MUGSHOT)
        self.editorResult = INTRO_EDITOR_STATUS.STOPPED
    else
        self:Error("Character Creator encountered an error. Please try again.", 1302)
        self.editorResult = INTRO_EDITOR_STATUS.STOPPED
    end
end

function Intro:MaintainTransitionToMugshot()
    local presetPed = self.presetPeds[self.selectedPreset] or 0

    self:ResetEditorSettings()

    DisableAllControlActions(0)
    EnableControlAction(0, `INPUT_FRONTEND_PAUSE`, true)

    if self.toPhotoState > INTRO_TO_PHOTO_STATE.INIT then
        SetPedCanPlayAmbientAnims(presetPed, false)
    end

    if self.toPhotoState == INTRO_TO_PHOTO_STATE.INIT then
        if not self:AnimSceneLoading(false) then
            return
        end

        SetAnimSceneEntity(self.animScene, "Male_MP", self.presetPeds[EDITOR_CONFIG.MALE], 0)
        SetAnimSceneEntity(self.animScene, "Female_MP", self.presetPeds[EDITOR_CONFIG.FEMALE], 0)
        SetAnimSceneEntity(self.animScene, "Deputy", self.guardPed, 0)
        SetAnimSceneEntity(self.animScene, "Sheriff", self.sheriffPed, 0)

        if IsAnimSceneRunning(self.animScene, false) ~= 1 then
            StartAnimScene(self.animScene)
        end

        local playlist = self.selectedPreset == EDITOR_CONFIG.MALE and "Pl_Edit_to_Photo_Male" or "Pl_Edit_to_Photo_Female"
        SetAnimScenePlayList(self.animScene, playlist, true)

        if not self:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
            self:StopAllConversations()
            self:CreateConversation("CHAR_CONFIRM")
        end

        self.photoPostfx = AnimpostfxGetStackhash("MP_CharacterCreatorPhoto")
        Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__TRANSITION_TO_MUGSHOT: fx tag hash: ", self.photoPostfx)

        AnimpostfxPreloadPostfxByStackhash(self.photoPostfx)
        Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__TRANSITION_TO_MUGSHOT - CCAS - char going to seat")

        self:SetState(INTRO_TO_PHOTO_STATE.CAM, "TO_PHOTO")
    elseif self.toPhotoState == INTRO_TO_PHOTO_STATE.CAM then
        if HasAnimEventFired(presetPed, 0x378A4083) ~= 1 then
            if GetGameTimer() - self.subStateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to transition. Please try again.", 1401)
            end

            return
        end

        local data = self.config.presets[self.selectedPreset]
        local position = data.portraitCamPosition
        local rotation = data.portraitCamRotation
        local fov = data.portraitCamFov
        local focus = data.portraitCamFocus

        if DoesCamExist(self.portraitCamera) ~= 1 then
            self.portraitCamera = CreateCamera(`DEFAULT_SCRIPTED_CAMERA`, false)
            Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__MUGSHOT - creating portrait camera")
        end

        SetCamCoord(self.portraitCamera, position.x, position.y, position.z)
        SetCamRot(self.portraitCamera, rotation.x, rotation.y, rotation.z, 2)
        SetCamFov(self.portraitCamera, fov)
        SetCamFocusDistance(self.portraitCamera, focus)
        SetCamActive(self.portraitCamera, true)
        RenderScriptCams(true, false, 3000, true, false, 0)

        if AnimpostfxIsRunning("CameraViewfinder") ~= 1 then
            AnimpostfxPlay("CameraViewfinder")
        end

        self:SetState(INTRO_TO_PHOTO_STATE.CHECK, "TO_PHOTO")
    elseif self.toPhotoState == INTRO_TO_PHOTO_STATE.CHECK then
        if GetGameTimer() - self.subStateChangeTime < 1000 then
            return
        end

        if not self:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
            self:CreateConversation("CHAR_RAISEHANDS")
        end

        self:SetState(INTRO_TO_PHOTO_STATE.COMPLETE, "TO_PHOTO")
    elseif self.toPhotoState == INTRO_TO_PHOTO_STATE.COMPLETE then
        local section = self.selectedPreset == EDITOR_CONFIG.MALE and "S_Male_Photo_Idle" or "S_Female_Photo_Idle"
        if IsAnimSceneInSection(self.animScene, section, true) ~= 1 then
            if GetGameTimer() - self.subStateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to transition. Please try again.", 1402)
            end

            return
        end

        local playlist = self.selectedPreset == EDITOR_CONFIG.MALE and "PI_Show_Hands_Male" or "PI_Show_Hands_Female"
        SetAnimScenePlayList(self.animScene, playlist, true)

        self:SetState(INTRO_STATE.MUGSHOT)
        self:SetState(INTRO_TO_PHOTO_STATE.INIT, "TO_PHOTO")
    end
end

function Intro:MaintainTransitionBackToCustomize()
    local presetPed = self.presetPeds[self.selectedPreset] or 0

    DisableAllControlActions(0)
    EnableControlAction(0, `INPUT_FRONTEND_PAUSE`, true)

    if self.backEditState == INTRO_BACK_EDIT_STATE.INIT then
        if not self:AnimSceneLoading(false) then
            return
        end

        Intro:SetupEditor()

        SetAnimSceneEntity(self.animScene, "Male_MP", self.presetPeds[EDITOR_CONFIG.MALE], 0)
        SetAnimSceneEntity(self.animScene, "Female_MP", self.presetPeds[EDITOR_CONFIG.FEMALE], 0)
        SetAnimSceneEntity(self.animScene, "Deputy", self.guardPed, 0)
        SetAnimSceneEntity(self.animScene, "Sheriff", self.sheriffPed, 0)

        if IsAnimSceneRunning(self.animScene, false) ~= 1 then
            StartAnimScene(self.animScene)
        end

        local playlist = self.selectedPreset == EDITOR_CONFIG.MALE and "Pl_Photo_to_Edit_Male" or "Pl_Photo_to_Edit_Female"
        SetAnimScenePlayList(self.animScene, playlist, true)

        SetAudioSceneset("customization", "rdro_character_creator_scenes")

        Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__TRANSITION_BACK_TO_CUTOMIZE - CCAS - char going back to editing stance")
        self:SetState(INTRO_BACK_EDIT_STATE.CAM, "BACK_EDIT")
    elseif self.backEditState == INTRO_BACK_EDIT_STATE.CAM then
        if HasAnimEventFired(presetPed, 0x378A4083) ~= 1 then
            if GetGameTimer() - self.subStateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to transition. Please try again.", 1501)
            end

            return
        end

        self:SetState(INTRO_BACK_EDIT_STATE.OVERLAY, "BACK_EDIT")
    elseif self.backEditState == INTRO_BACK_EDIT_STATE.OVERLAY then
        if AnimpostfxIsRunning("CameraViewfinder") then
            AnimpostfxStop("CameraViewfinder")
        end

        self:SetState(INTRO_BACK_EDIT_STATE.WALK, "BACK_EDIT")
    elseif self.backEditState == INTRO_BACK_EDIT_STATE.WALK then
        if HasAnimEventFired(presetPed, 0x378A4083) ~= 1 then
            if GetGameTimer() - self.subStateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to transition. Please try again.", 1502)
            end

            return
        end

        if not DoesCamExist(self.editCamera) then
            self.editCamera = CreateCamera(`DEFAULT_SCRIPTED_CAMERA`, false)
        end

        local viewData = self.config.editorViews and self.config.editorViews[self.selectedPreset] and self.config.editorViews[self.selectedPreset][EDITOR_VIEW.FULL_BODY]
        if viewData then
            SetCamCoord(self.editCamera, viewData.position.x, viewData.position.y, viewData.position.z)
            SetCamRot(self.editCamera, viewData.rotation.x, viewData.rotation.y, viewData.rotation.z, 2)
            SetCamFov(self.editCamera, viewData.fov)
            SetCamFocusDistance(self.editCamera, viewData.focus)
            self.currentEditViewData = viewData
        end
        SetCamActive(self.editCamera, true)
        RenderScriptCams(true, false, 3000, true, false, 0)

        self:SetState(INTRO_BACK_EDIT_STATE.ANIM_FINISH, "BACK_EDIT")
    elseif self.backEditState == INTRO_BACK_EDIT_STATE.ANIM_FINISH then
        if HasAnimEventFired(presetPed, 0x63590D57) ~= 1 and IsAnimSceneFinished(self.animScene, false) ~= 1 then
            if GetGameTimer() - self.subStateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to transition. Please try again.", 1503)
            end

            return
        end

        IntroAnimations:MaintainAnimations(self.selectedPreset)
        FreezeEntityPosition(presetPed, false)

        self:SetState(INTRO_BACK_EDIT_STATE.COMPLETE, "BACK_EDIT")
    elseif self.backEditState == INTRO_BACK_EDIT_STATE.COMPLETE then
        IntroAnimations:MaintainAnimations(self.selectedPreset)
        Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__TRANSITION_TO_CUSTOMIZE - CCAS - char waiting for back edit anim scene to finish")

        if IsAnimSceneFinished(self.animScene, false) ~= 1 then
            if GetGameTimer() - self.subStateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to transition. Please try again.", 1504)
            end

            return
        end

        self:SetState(INTRO_BACK_EDIT_STATE.INIT, "BACK_EDIT")
        self:SetState(INTRO_STATE.CUSTOMIZE)
    end
end

function Intro:MaintainMugshot()
    SetControlContext(4, `GAMEMENU`)
    DisableAllControlActions(0)

    if not self:IsFlagSet(INTRO_FLAG.PED_IN_PHOTO_SEAT) then
        CancelOnscreenKeyboard()

        local randomId = GetRandomIntInRange(10000, 99999)
        self.mugshotTitle = tostring(randomId)
        Utils:Debug("MAINTAIN_MUGSHOT - mugshot title: ", self.mugshotTitle)

        local data = self.config.presets[self.selectedPreset]
        local position = data.portraitCamPosition
        local rotation = data.portraitCamRotation
        local fov = data.portraitCamFov
        local focus = data.portraitCamFocus

        if DoesCamExist(self.portraitCamera) ~= 1 then
            self.portraitCamera = CreateCamera(`DEFAULT_SCRIPTED_CAMERA`, false)
            Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__MUGSHOT - creating portrait camera")
        end

        SetCamCoord(self.portraitCamera, position.x, position.y, position.z)
        SetCamRot(self.portraitCamera, rotation.x, rotation.y, rotation.z, 2)
        SetCamFov(self.portraitCamera, fov)
        SetCamFocusDistance(self.portraitCamera, focus)
        SetCamActive(self.portraitCamera, true)
        RenderScriptCams(true, false, 3000, true, false, 0)

        Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__MUGSHOT - CCAS - char is in seat")
        self:SetFlag(INTRO_FLAG.PED_IN_PHOTO_SEAT)
        return
    end

    if GetGameTimer() - self.stateChangeTime < 1000 then
        if AnimpostfxIsRunning("CameraViewfinder") ~= 1 then
            AnimpostfxPlay("CameraViewfinder")
        end

        return
    end

    local maxTitleLength = CreatorConfig.MaxNameLength or 50
    AddTextEntry("MUGSHOT_TITLE_PROMPT", string.format("Enter a title for your mugshot (Max %d characters)", maxTitleLength))

    if self.mugshotState == INTRO_MUGSHOT_STATE.PROMPT then
        EnableControlAction(0, `INPUT_GAME_MENU_ACCEPT`, true)
        EnableControlAction(0, `INPUT_GAME_MENU_CANCEL`, true)
        EnableControlAction(0, `INPUT_GAME_MENU_LEFT`, true)
        EnableControlAction(0, `INPUT_GAME_MENU_RIGHT`, true)
        EnableControlAction(0, `INPUT_FRONTEND_PAUSE`, true)
        EnableControlAction(0, `INPUT_SHOP_CHANGE_CURRENCY`, true)
        EnableControlAction(0, `INPUT_GAME_MENU_OPTION`, true)

        local held = IsControlPressed(0, `INPUT_SHOP_CHANGE_CURRENCY`) == 1
        self:RegisterMugshotPrompts(true, held)

        if self:IsFlagSet(INTRO_FLAG.MUGSHOT_TITLE_PROMPT) and UpdateOnscreenKeyboard() == 0 then
            return
        end

        if self:IsFlagSet(INTRO_FLAG.MUGSHOT_TITLE_PROMPT) and UpdateOnscreenKeyboard() == 1 then
            self.mugshotTitle = GetOnscreenKeyboardResult()
            Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__MUGSHOT - player entered a title: ", self.mugshotTitle)
            self:ClearFlag(INTRO_FLAG.MUGSHOT_TITLE_PROMPT)
        end

        if held then
            if IsControlJustPressed(0, `INPUT_GAME_MENU_LEFT`) then
                self:PlaySound("Amount_Decrease", "HUD_Donate_Sounds")
                self.mugshotTimer = math.max(self.mugshotTimer - 1, 3)
            elseif IsControlJustPressed(0, `INPUT_GAME_MENU_RIGHT`) then
                self:PlaySound("Amount_Increase", "HUD_Donate_Sounds")
                self.mugshotTimer = math.min(self.mugshotTimer + 1, 30)
            elseif IsControlJustPressed(0, `INPUT_GAME_MENU_ACCEPT`) then
                self:PlaySound("SELECT", "RDRO_Character_Creator_Sounds")
                self.mugshotShowUi = not self.mugshotShowUi
            elseif self.mugshotShowUi and IsControlJustPressed(0, `INPUT_GAME_MENU_OPTION`) then
                self:PlaySound("SELECT", "RDRO_Character_Creator_Sounds")
                NextOnscreenKeyboardResultWillDisplayUsingTheseFonts(256)
                DisplayOnscreenKeyboard(4, "MUGSHOT_TITLE_PROMPT", "", self.mugshotTitle or "", "", "", "", maxTitleLength)
                self:SetFlag(INTRO_FLAG.MUGSHOT_TITLE_PROMPT)
            end

            return
        end

        if IsControlJustPressed(0, `INPUT_GAME_MENU_CANCEL`) then
            Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__MUGSHOT - player declined to confirm their character")

            self:PlaySound("BACK", "RDRO_Character_Creator_Sounds")
            self:DestroyPrompts()

            if not self:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
                self:StopAllConversations()
                self:CreateConversation("CHAR_BACKCUST")
            end

            Citizen.InvokeNative(Natives.GraphicsReleasePostfx, self.photoPostfx)

            self:SetState(INTRO_STATE.TRANSITION_BACK_TO_CUSTOMIZE)
            self:SetState(INTRO_MUGSHOT_STATE.PROMPT, "MUGSHOT")
        elseif IsControlJustPressed(0, `INPUT_GAME_MENU_ACCEPT`) then
            Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__MUGSHOT - player selected to confirm their character.")

            self:DestroyPrompts()

            if self.mugshotShowUi then
                local root = DatabindingAddDataContainerFromPath("", "CharacterCreationRoot")
                local overlay = DatabindingAddDataContainer(root, "photoOverlay")

                DatabindingAddDataBool(overlay, "showPhotoOverlay", true)
                DatabindingAddDataString(overlay, "gamertag", Character.name or "")
                DatabindingAddDataString(overlay, "socialClubId", self.mugshotTitle or "")

                LaunchUiappByHashWithEntry(`character_creator`, `photo_overlay`)
            end

            self:SetState(INTRO_MUGSHOT_STATE.INIT, "MUGSHOT")
        end
    elseif self.mugshotState == INTRO_MUGSHOT_STATE.INIT then
        CancelOnscreenKeyboard()
        self:DestroyPrompts()

        if PedmugshotTake() ~= 1 then
            if GetGameTimer() - self.subStateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to take the mugshot. Please try again.", 1601)
            end

            return
        end

        if AnimpostfxIsRunning("CameraViewfinder") then
            AnimpostfxStop("CameraViewfinder")
        end

        if AnimpostfxIsStackhashPlaying(self.photoPostfx) ~= 1 then
            AnimpostfxPlayTag(self.photoPostfx)
            Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__MUGSHOT: fx tag started")
        else
            Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__MUGSHOT: fx tag already playing?")
        end

        TogglePausedRenderphases(false)

        self:PlaySound("Camera_Flash", "RDRO_Character_Creator_Sounds")
        SetAudioSceneset("character_photo", "rdro_character_creator_scenes")

        self:SetState(INTRO_MUGSHOT_STATE.WETPLATE, "MUGSHOT")
    elseif self.mugshotState == INTRO_MUGSHOT_STATE.WETPLATE then
        if GetGameTimer() - self.subStateChangeTime > (self.mugshotTimer * 1000) then
            self:SetState(INTRO_MUGSHOT_STATE.FADE, "MUGSHOT")
        end
    elseif self.mugshotState == INTRO_MUGSHOT_STATE.FADE then
        if IsScreenFadedOut() then
            AnimpostfxStopStackhashPostfx(self.photoPostfx)

            self:SetState(INTRO_MUGSHOT_STATE.COMPLETE, "MUGSHOT")
        elseif IsScreenFadingOut() ~= 1 then
            DoScreenFadeOut(1000)
            Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__MUGSHOT - fading out the screen")
        end
    elseif self.mugshotState == INTRO_MUGSHOT_STATE.COMPLETE then
        if IsScreenFadedOut() ~= 1 then
            if GetGameTimer() - self.subStateChangeTime > TIMEOUT_GENERIC then
                self:Error("Failed to complete the mugshot. Please try again.", 1602)
            end

            return
        end

        if AnimpostfxIsStackhashPlaying(self.photoPostfx) then
            AnimpostfxStopStackhashPostfx(self.photoPostfx)
            Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__MUGSHOT: fx hash stopped")
        else
            Utils:Debug("NET_CHAR_CREATOR_UPDATE_MISSION_STATE__EDITOR__MUGSHOT: fx hash not playing")
        end

        CloseUiappByHash(`character_creator`)

        Citizen.InvokeNative(Natives.GraphicsReleasePostfx, self.photoPostfx)
        TogglePausedRenderphases(true)

        self:SetState(INTRO_STATE.EXIT)
    end
end

function Intro:MaintainCancelBackToFreeroam()
    if self:IsFlagSet(INTRO_FLAG.REROLL_CANCEL_ALERT_CONFIRM) then
        Utils:Debug("MAINTAIN_CANCEL_BACK_TO_FREEROAM - player confirmed to exit the character creator")

        self:ClearFlag(INTRO_FLAG.REROLL_CANCEL_ALERT_CONFIRM)
        self:SetState(INTRO_STATE.EXIT)
        return
    end

    if self:IsFlagSet(INTRO_FLAG.REROLL_CANCEL_ALERT_CANCEL) then
        Utils:Debug("MAINTAIN_CANCEL_BACK_TO_FREEROAM - player canceled the exit, going back to customize")

        Intro:SetupEditor()

        self:ClearFlag(INTRO_FLAG.REROLL_CANCEL_ALERT_CANCEL)
        self:SetState(INTRO_STATE.CUSTOMIZE)
        return
    end

    if not self:IsFlagSet(INTRO_FLAG.REROLL_CANCEL_ALERT_CREATED) then
        self.alertHandle = ShowAlert(
            "WARNING",
            "CONFIRM",
            "Are you sure you want to exit the Character Creator?~n~All changes will be discarded and you will not be charged.",
            { acceptHash = `IB_YES`, backHash = `IB_NO` }
        )

        self:SetFlag(INTRO_FLAG.REROLL_CANCEL_ALERT_CREATED)
    end
end

function Intro:MaintainExit()
    if self.alertHandle then
        UiStickyFeedClearMessage(self.alertHandle)
        self.alertHandle = 0
    end

    CancelOnscreenKeyboard()

    if self.state == INTRO_STATE.WAITING_TO_START then
        self:ClearFlag(INTRO_FLAG.FORCE_EXIT)
        return
    end

    if not self:IsFlagSet(INTRO_FLAG.FORCE_EXIT) then
        if not self:FadeOutScreen(1000) then
            return
        end
    end

    local pos = self.playerExitPosition
    local heading = self.playerExitHeading

    if not self:IsFlagSet(INTRO_FLAG.FORCE_EXIT) then
        if self:IsFlagSet(INTRO_FLAG.PLAYER_POSITION_IN_INTRO) then
            LoadSceneStartSphere(pos.x, pos.y, pos.z, 50.0, 4)
            self:ClearFlag(INTRO_FLAG.PLAYER_POSITION_IN_INTRO)
        end

        if IsLoadSceneActive() ~= 1 then
            Utils:Debug("MAINTAIN_EXIT - load scene is not active, re-starting it")
            LoadSceneStartSphere(pos.x, pos.y, pos.z, 50.0, 0)
            return
        end

        if IsLoadSceneLoaded() ~= 1 then
            if GetGameTimer() - self.stateChangeTime > TIMEOUT_LOAD then
                Utils:Debug("MAINTAIN_EXIT - load scene timed out!")
                goto load_timeout
            end

            return
        end

        ::load_timeout::

        LoadSceneStop()
        ClearArea(pos.x, pos.y, pos.z, 50.0, 1 << 14)
    end

    ClearOverrideWeather()
    ClearTimecycleModifier()
    NetworkClearClockTimeOverride()
    DisableHudContext(`HUD_CTX_CHARACTER_CREATOR`)

    self:StopAllConversations()

    StopAudioSceneset("rdro_character_creator_scenes")
    ReleaseSoundset("RDRO_Character_Creator_Sounds")
    ReleaseSoundset("HUD_Donate_Sounds")
    SetAmbientZoneListState("AZL_RDRO_Character_Creation_Area", false, true)
    SetAmbientZoneListState("AZL_RDRO_Character_Creation_Area_Other_Zones_Disable", true, true)
    TriggerMusicEvent("MP_CHARACTER_CREATION_STOP")

    RemoveMoveNetworkDef("Character_Creator")

    for _, ipl in ipairs(INTRO_IPLS) do
        if IsIplActiveByHash(ipl) == 1 then
            RemoveIplByHash(ipl)
        end
    end

    if AnimpostfxIsRunning("CameraViewfinder") then
        AnimpostfxStop("CameraViewfinder")
    end

    if AnimpostfxIsStackhashPlaying(self.photoPostfx) then
        AnimpostfxStopStackhashPostfx(self.photoPostfx)
    end

    self:DestroyPrompts()
    self:DestroyObjective()
    self:DestroyAnimScenes()
    self:DestroyAllPeds()
    self:DestroyAllCameras()

    IntroXml:Reset()
    IntroAnimations:Reset()

    Creator:Finish(false)

    SetEntityCoordsAndHeading(self.playerPedId, pos.x, pos.y, pos.z, heading, true, false, true)
    SetPlayerInvincible(self.playerIndex, false)
    SetEntityVisible(self.playerPedId, true)

    DoScreenFadeIn(0)
    AnimpostfxPlay("RespawnPulse01")

    self:Reset()
end

function Intro:SetupEditor()
    Character:Reset()

    -- Reset clothing level so each new editing session starts fully clothed.
    self.clothingLevel = CLOTHING_SETTING.DEFAULT

    if self:IsFlagSet(INTRO_FLAG.IS_REROLLING) and self.rerollImportData then
        Character:Import(self.rerollImportData)
        self.presetData[self.selectedPreset] = self.rerollImportData
        self.rerollImportData = nil
    else
        Character:Import(self.presetData[self.selectedPreset] or {})
    end

    Character:SetPed(self.presetPeds[self.selectedPreset])
    Creator:Start()
end

function Intro:SetClothingLevel(level)
    local presetPed = self.presetPeds[self.selectedPreset] or 0
    if presetPed == 0 or DoesEntityExist(presetPed) ~= 1 then return end

    self.clothingLevel = level

    -- Always restore to the original state first to get a clean baseline,
    -- then strip the appropriate layers for the chosen level.
    Character:ApplyDefaultClothing()

    if level ~= CLOTHING_SETTING.DEFAULT then
        Character:ApplyClothingLevel(level)
    end
end

function Intro:SetAnimationLevel(level)
    if level == ANIMATION_SETTING.REDUCED then
        self:SetFlag(INTRO_FLAG.SUPPRESS_FIDGETS)
        self:ClearFlag(INTRO_FLAG.SUPPRESS_ANIMATION)
    elseif level == ANIMATION_SETTING.DISABLED then
        self:SetFlag(INTRO_FLAG.SUPPRESS_FIDGETS)
        self:SetFlag(INTRO_FLAG.SUPPRESS_ANIMATION)
    else
        self:ClearFlag(INTRO_FLAG.SUPPRESS_FIDGETS)
        self:ClearFlag(INTRO_FLAG.SUPPRESS_ANIMATION)
    end
end

function Intro:SetRotationLevel(level)
    if level == ROTATION_SETTING.SMOOTH then
        self:SetFlag(INTRO_FLAG.SUPPRESS_ROTATION)
    else
        self:ClearFlag(INTRO_FLAG.SUPPRESS_ROTATION)
    end
end

function Intro:RequestIplHashSafe(hash)
    if IsIplActiveHash(hash) then
        return true
    end

    RequestIplHash(hash)
    return false
end

function Intro:TriggerMusicEventSafe(event, prepare)
    if not event or event == "" then
        return true
    end

    if prepare and PrepareMusicEvent(event) ~= 1 then
        return false
    end

    if TriggerMusicEvent(event) then
        return true
    end

    return false
end

function Intro:LoadAnimations()
    local ANIM_DICTS <const> = {
        "script_common@tailor_shop",
        "mech_loco_f@type@cowgirl@normal@unarmed@idle",
        "mp_character_creator@male@fidgets",
        "mp_character_creator@female@fidgets",
    }

    for _, dict in ipairs(ANIM_DICTS) do
        RequestAnimDict(dict)
        if HasAnimDictLoaded(dict) ~= 1 then
            return false
        end
    end

    RequestMoveNetworkDef("Character_Creator")
    if HasMoveNetworkDefLoaded("Character_Creator") ~= 1 then
        Utils:Debug("NET_CHAR_EDITOR_LOAD_ANIMATIONS - CCMN - loading move network: Character_Creator")
        return false
    end

    local CLIPSETS <const> = {
        "clipset@mp_character_creator@male",
        "clipset@mp_character_creator@female",
    }

    for _, clipset in ipairs(CLIPSETS) do
        RequestClipSet(clipset)
        if HasClipSetLoaded(clipset) ~= 1 then
            Utils:Debug("NET_CHAR_EDITOR_LOAD_ANIMATIONS - CCMN - loading clipset: ", clipset)
            return false
        end
    end

    if not self:AnimSceneLoading(true) then
        Utils:Debug("NET_CHAR_EDITOR_LOAD_ANIMATIONS - CCMN - waiting for anim scene to load")
        return false
    end

    return true
end

function Intro:LoadConfiguration()
    local CONFIGS <const> = { EDITOR_CONFIG.MALE, EDITOR_CONFIG.FEMALE }
    local presets = {}

    for _, config in ipairs(CONFIGS) do
        local pedPreset = EDITOR_CONFIG:GetPedPreset(config)

        local configNode = IntroXml:GetHash(INTRO_XML_QUERY.PRESET__EDITOR_CONFIG, pedPreset)
        if not configNode then return false end

        local spawnPosition = IntroXml:GetVector(INTRO_XML_QUERY.PRESET__SPAWN_POSITION, pedPreset)
        if not spawnPosition then return false end

        local spawnHeading = IntroXml:GetFloat(INTRO_XML_QUERY.PRESET__SPAWN_HEADING, pedPreset)
        if not spawnHeading then return false end

        local pedModel = IntroXml:GetHash(INTRO_XML_QUERY.PRESET__PED_MODEL, pedPreset)
        if not pedModel then return false end

        RequestModel(pedModel, false)

        local lineupPedPosition = IntroXml:GetVector(INTRO_XML_QUERY.PRESET__LINEUP_PED_POSITION, pedPreset)
        if not lineupPedPosition then return false end

        local lineupPedHeading = IntroXml:GetFloat(INTRO_XML_QUERY.PRESET__LINEUP_PED_HEADING, pedPreset)
        if not lineupPedHeading then return false end

        local lineupCamPosition = IntroXml:GetVector(INTRO_XML_QUERY.PRESET__LINEUP_CAM_POSITION, pedPreset)
        if not lineupCamPosition then return false end

        local lineupCamRotation = IntroXml:GetVector(INTRO_XML_QUERY.PRESET__LINEUP_CAM_ROTATION, pedPreset)
        if not lineupCamRotation then return false end

        local lineupCamFov = IntroXml:GetFloat(INTRO_XML_QUERY.PRESET__LINEUP_CAM_FOV, pedPreset)
        if not lineupCamFov then return false end

        local lineupCamFocus = IntroXml:GetFloat(INTRO_XML_QUERY.PRESET__LINEUP_CAM_FOCUS, pedPreset)
        if not lineupCamFocus then return false end

        local portraitCamPosition = IntroXml:GetVector(INTRO_XML_QUERY.PRESET__PORTRAIT_CAM_POSITION, pedPreset)
        if not portraitCamPosition then return false end

        local portraitCamRotation = IntroXml:GetVector(INTRO_XML_QUERY.PRESET__PORTRAIT_CAM_ROTATION, pedPreset)
        if not portraitCamRotation then return false end

        local portraitCamFov = IntroXml:GetFloat(INTRO_XML_QUERY.PRESET__PORTRAIT_CAM_FOV, pedPreset)
        if not portraitCamFov then return false end

        local portraitCamFocus = IntroXml:GetFloat(INTRO_XML_QUERY.PRESET__PORTRAIT_CAM_FOCUS, pedPreset)
        if not portraitCamFocus then return false end

        presets[config] = {
            pedPreset = pedPreset,
            configNode = configNode,
            spawnPosition = spawnPosition,
            spawnHeading = spawnHeading,
            pedModel = pedModel,
            lineupPedPosition = lineupPedPosition,
            lineupPedHeading = lineupPedHeading,
            lineupCamPosition = lineupCamPosition,
            lineupCamRotation = lineupCamRotation,
            lineupCamFov = lineupCamFov,
            lineupCamFocus = lineupCamFocus,
            portraitCamPosition = portraitCamPosition,
            portraitCamRotation = portraitCamRotation,
            portraitCamFov = portraitCamFov,
            portraitCamFocus = portraitCamFocus,
        }
    end

    local guardPedModel = IntroXml:GetHash(INTRO_XML_QUERY.MOCAP__PED_GUARD_MODEL)
    if not guardPedModel then return false end

    RequestModel(guardPedModel, false)

    local guardPedOutfit = IntroXml:GetHash(INTRO_XML_QUERY.MOCAP__PED_GUARD_OUTFIT)
    if not guardPedOutfit then return false end

    RequestMetaPedOutfit(guardPedModel, guardPedOutfit)

    local guardPedPosition = IntroXml:GetVector(INTRO_XML_QUERY.MOCAP__PED_GUARD_PED_POSITION)
    if not guardPedPosition then return false end

    local guardPedHeading = IntroXml:GetFloat(INTRO_XML_QUERY.MOCAP__PED_GUARD_PED_HEADING)
    if not guardPedHeading then return false end

    local sheriffPedModel = IntroXml:GetHash(INTRO_XML_QUERY.MOCAP__PED_SHERIFF_MODEL)
    if not sheriffPedModel then return false end

    RequestModel(sheriffPedModel, false)

    local sheriffPedOutfit = IntroXml:GetHash(INTRO_XML_QUERY.MOCAP__PED_SHERIFF_OUTFIT)
    if not sheriffPedOutfit then return false end

    RequestMetaPedOutfit(sheriffPedModel, sheriffPedOutfit)

    local sheriffPedPosition = IntroXml:GetVector(INTRO_XML_QUERY.MOCAP__PED_SHERIFF_PED_POSITION)
    if not sheriffPedPosition then return false end

    local sheriffPedHeading = IntroXml:GetFloat(INTRO_XML_QUERY.MOCAP__PED_SHERIFF_PED_HEADING)
    if not sheriffPedHeading then return false end

    local initCamPosition = IntroXml:GetVector(INTRO_XML_QUERY.INIT_CAM_POSITION)
    if not initCamPosition then return false end

    local initCamRotation = IntroXml:GetVector(INTRO_XML_QUERY.INIT_CAM_ROTATION)
    if not initCamRotation then return false end

    local initCamFov = IntroXml:GetFloat(INTRO_XML_QUERY.INIT_CAM_FOV)
    if not initCamFov then return false end

    local initCamFocus = IntroXml:GetFloat(INTRO_XML_QUERY.INIT_CAM_FOCUS)
    if not initCamFocus then return false end

    -- Load editor view camera data from CHARACTER_EDITOR_DATA
    if not CreatorXml:Initialize() then return false end

    local EDITOR_VIEW_IDS <const> = {
        EDITOR_VIEW.FULL_BODY,
        EDITOR_VIEW.FULL_BODY_CLOSE,
        EDITOR_VIEW.FACE,
        EDITOR_VIEW.FACE_CLOSE,
        EDITOR_VIEW.EYES,
    }

    local editorViews = {}
    for _, config in ipairs(CONFIGS) do
        local configHash = presets[config].configNode
        editorViews[config] = {}

        for _, viewId in ipairs(EDITOR_VIEW_IDS) do
            local viewHash = EDITOR_VIEW:GetHash(viewId)
            if not viewHash or viewHash == 0 then goto next_view end

            CreatorXml:RequestReset(0)
            if not CreatorXml:GetNode(EDITOR_XML_QUERY.EDITOR_VIEW_NODE, configHash, viewHash) then
                goto next_view
            end

            local camPosition = CreatorXml:GetVector(EDITOR_XML_QUERY.EDITOR_VIEW__CAMERA__POSITION)
            local camRotation = CreatorXml:GetVector(EDITOR_XML_QUERY.EDITOR_VIEW__CAMERA__ROTATION)
            local camFov = CreatorXml:GetFloat(EDITOR_XML_QUERY.EDITOR_VIEW__CAMERA__FIELD_OF_VIEW)
            local camFocus = CreatorXml:GetFloat(EDITOR_XML_QUERY.EDITOR_VIEW__CAMERA__FOCUS_DISTANCE)

            editorViews[config][viewId] = {
                position = camPosition,
                rotation = camRotation,
                fov = camFov,
                focus = camFocus,
            }

            ::next_view::
        end
    end

    self.config = {
        presets = presets,
        guardPedModel = guardPedModel,
        guardPedOutfit = guardPedOutfit,
        guardPedPosition = guardPedPosition,
        guardPedHeading = guardPedHeading,
        sheriffPedModel = sheriffPedModel,
        sheriffPedOutfit = sheriffPedOutfit,
        sheriffPedPosition = sheriffPedPosition,
        sheriffPedHeading = sheriffPedHeading,
        initCamPosition = initCamPosition,
        initCamRotation = initCamRotation,
        initCamFov = initCamFov,
        initCamFocus = initCamFocus,
        editorViews = editorViews,
    }

    Utils:Debug("MAINTAIN_LOAD_CONFIGURATION - loaded configuration successfully", json.encode(self.config, { indent = true }))

    return true
end

function Intro:AnimSceneLoading(loadIntro)
    if DoesAnimSceneExist(self.animScene) ~= 1 then
        self.animScene = CreateAnimScene("script@mp@character_creator@transitions", 0, "", false, true)
        Utils:Debug("NET_CHAR_EDITOR_ANIM_SCENE_LOADING - CCAS - created transitions anim scene")
    end

    if IsAnimSceneLoaded(self.animScene, true, false) ~= 1 then
        if IsAnimSceneLoading(self.animScene, true) ~= 1 then
            LoadAnimScene(self.animScene)
        end

        return false
    end

    if loadIntro then
        local INTRO_PLAYLISTS <const> = { "pl_intro", "pl_start_idle" }

        for _, playlist in ipairs(INTRO_PLAYLISTS) do
            if not self:MaintainPlaylistLoaded(self.animScene, playlist) then
                return false
            end
        end
    end

    local PLAYLISTS <const> = {
        "Pl_Start_to_Edit_Male", "Pl_Start_to_Edit_Female",
        "Pl_Edit_to_Start_Male", "Pl_Edit_to_Start_Female",
        "Pl_Edit_to_Photo_Male", "Pl_Edit_to_Photo_Female",
        "Pl_Photo_to_Edit_Male", "Pl_Photo_to_Edit_Female",
        "PI_Show_Hands_Male", "PI_Show_Hands_Female",
    }

    for _, playlist in ipairs(PLAYLISTS) do
        if not self:MaintainPlaylistLoaded(self.animScene, playlist) then
            return false
        end
    end

    if DoesAnimSceneExist(self.lightrig) ~= 1 then
        self.lightrig = CreateAnimScene("lightrig@online_character_editor", 0, "", false, true)
        Utils:Debug("NET_CHAR_EDITOR_ANIM_SCENE_LOADING - CCAS - created lightrig")
    end

    if IsAnimSceneLoaded(self.lightrig, true, false) ~= 1 then
        if IsAnimSceneLoading(self.lightrig, true) ~= 1 then
            LoadAnimScene(self.lightrig)
            Utils:Debug("NET_CHAR_EDITOR_ANIM_SCENE_LOADING - CCAS - Requesting lightrig")
        end

        Utils:Debug("NET_CHAR_EDITOR_ANIM_SCENE_LOADING - CCAS - waiting for lightrig to load")
        return false
    end

    return true
end

function Intro:MaintainPlaylistLoaded(scene, playlist)
    if IsAnimScenePlaybackListPhaseLoaded(scene, playlist) ~= 1 then
        if IsAnimScenePlaybackListPhaseLoading(scene, playlist) ~= 1 then
            RequestAnimScenePlayList(scene, playlist)
            Utils:Debug("MAINTAIN_PLAYLIST_LOADED - CCAAS - requesting anim scene playlist : ", playlist)
        else
            Utils:Debug("MAINTAIN_PLAYLIST_LOADED - CCAAS - loading anim scene playlist : ", playlist)
        end
    else
        return true
    end

    return false
end

function Intro:SetLockonDisabled(ped)
    if IsPedInjured(ped) then
        return
    end

    SetPedConfigFlag(ped, 130, true) -- PCF_DisableTalkTo
    SetPedConfigFlag(ped, 301, true) -- PCF_DisableInteractionLockonOnTargetPed
    SetPedConfigFlag(ped, 315, true) -- PCF_0xD38AEF95
end

function Intro:CreatePedPreset(config)
    local data = self.config.presets[config]
    if not data then
        Utils:Debug("MAINTAIN_CREATE_PED_PRESETS - no data for ped preset", EDITOR_CONFIG:ToString(config))
        return false
    end

    local model = data.pedModel
    local position = data.spawnPosition
    local heading = data.spawnHeading

    if HasModelLoaded(model) ~= 1 then
        Utils:Debug("MAINTAIN_CREATE_PED_PRESETS - waiting for model to load ", model)
        return false
    end

    if CanRegisterMissionPeds(1) ~= 1 then
        Utils:Debug("MAINTAIN_CREATE_PED_PRESETS - waiting to be able to register mission peds to spawn ped ", EDITOR_CONFIG:ToString(config))
        return false
    end

    Utils:Debug("MAINTAIN_CREATE_PED_PRESETS - creating ped preset ", EDITOR_CONFIG:ToString(config))
    local ped = CreatePed(model, position.x, position.y, position.z, heading, true, true, false, false)

    if DoesEntityExist(ped) ~= 1 then
        Utils:Debug("MAINTAIN_CREATE_PED_PRESETS - failed to create ped preset", EDITOR_CONFIG:ToString(config))
        return false
    end

    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    ClearPedTasksImmediately(ped, false, true)

    self:SetLockonDisabled(ped)

    local animation = "SCRIPT_COMMON@TAILOR_SHOP"
    if IsPedModel(ped, `MP_FEMALE`) then
        animation = "MECH_LOCO_F@TYPE@COWGIRL@NORMAL@UNARMED@IDLE"
    end

    TaskPlayAnim(ped, animation, "idle", 1000.0, -4.0, -1, 8193, 0.0, false, 0, false, "", false)
    Utils:Debug("MAINTAIN_CREATE_PED_PRESETS - tasking animation: ", animation, " on ped: ", ped)

    self.presetPeds[config] = ped

    return true
end

function Intro:ResetCharacter()
    if not self.selectedPreset then
        Utils:Debug("RESET_CHARACTER - no selected preset")
        return true
    end

    Utils:Debug("RESET_CHARACTER - resetting character for preset: ", EDITOR_CONFIG:ToString(self.selectedPreset))
    local ped = self.presetPeds[self.selectedPreset]

    if IsPedReadyToRender(ped) ~= 1 then
        Utils:Debug("RESET_CHARACTER - ped is not ready to render")
        return false
    end

    if Character:IsFlagSet(CHARACTER_FLAG.DIRTY) then
        Utils:Debug("RESET_CHARACTER - waiting for character to be ready")
        return false
    end

    if not CreatorPresets:Init(self.selectedPreset) then
        Utils:Debug("RESET_CHARACTER - failed to initialize character presets")
        return false
    end

    local name = Character.name or ""

    Utils:Debug("RESET_CHARACTER - resetting character")
    Character:Reset()
    Character.name = name
    Character:SetPed(ped)
    Character:ApplyAll()

    self.presetData[self.selectedPreset] = Character:Export()

    if self.state == INTRO_STATE.CUSTOMIZE then
        CreatorDatabinding:ApplyFromCharacter()
    end

    if self.selectedPreset == EDITOR_CONFIG.MALE then
        self:ClearFlag(INTRO_FLAG.MALE_PED_RANDOMIZED)
    else
        self:ClearFlag(INTRO_FLAG.FEMALE_PED_RANDOMIZED)
    end

    Character:ClearModified()
    Character:ClearRandomized()

    Utils:Debug("RESET_CHARACTER - character reset")
    return true
end

function Intro:FadeOutScreen(duration)
    if IsGameSessionStateMachineIdle() ~= 1 then
        Utils:Debug("NET_CHAR_CREATOR_FADE_OUT_SCREEN - IS_GAME_SESSION_STATE_MACHINE_IDLE has returned FALSE so don't attempt to fade out the screen. Returning FALSE")
        return false
    end

    if IsScreenFadingIn() then
        Utils:Debug("NET_CHAR_CREATOR_FADE_OUT_SCREEN - screen is currently fading in, waiting for it to finish before fading out")
        return false
    end

    if IsScreenFadedOut() ~= 1 then
        if IsScreenFadingOut() ~= 1 then
            Utils:Debug("NET_CHAR_CREATOR_FADE_OUT_SCREEN - fading out the screen")
            DoScreenFadeOut(duration)
        end

        return false
    end

    return true
end

function Intro:FadeInScreen(duration)
    if IsGameSessionStateMachineIdle() ~= 1 then
        Utils:Debug("NET_CHAR_CREATOR_FADE_IN_SCREEN - IS_GAME_SESSION_STATE_MACHINE_IDLE has returned FALSE so don't attempt to fade in the screen. Returning FALSE")
        return false
    end

    if IsScreenFadingOut() then
        Utils:Debug("NET_CHAR_CREATOR_FADE_IN_SCREEN - screen is currently fading out, waiting for it to finish before fading in")
        return false
    end

    if IsLoadingScreenVisible() then
        Utils:Debug("NET_CHAR_CREATOR_FADE_IN_SCREEN - shutting down the loading screen")
        ShutdownLoadingScreen()

        return false
    elseif IsScreenFadedIn() ~= 1 then
        if IsScreenFadingIn() ~= 1 then
            Utils:Debug("NET_CHAR_CREATOR_FADE_IN_SCREEN - fading in the screen")
            DoScreenFadeIn(duration)
            BusyspinnerOff()
        end

        return false
    end

    return true
end

function Intro:SetActivePedPreset(target, force)
    if self.selectedPreset == target then
        if not force then return end
        Utils:Debug("NET_CHAR_CREATOR_SET_ACTIVE_PED_PRESET - forcing re-activation of active ped preset")
    end

    local targetCamera = self.presetCameras[target] or 0
    if DoesCamExist(targetCamera) ~= 1 then
        targetCamera = CreateCamera(`DEFAULT_SCRIPTED_CAMERA`, false)
        Utils:Debug("NET_CHAR_CREATOR_SET_ACTIVE_PED_PRESET - creating gender select camera")
    end

    local targetConfig = self.config.presets[target]
    local targetPosition = targetConfig.lineupCamPosition
    local targetRotation = targetConfig.lineupCamRotation
    local targetFov = targetConfig.lineupCamFov
    local targetFocus = targetConfig.lineupCamFocus

    SetCamCoord(targetCamera, targetPosition.x, targetPosition.y, targetPosition.z)
    SetCamRot(targetCamera, targetRotation.x, targetRotation.y, targetRotation.z, 2)
    SetCamFov(targetCamera, targetFov)
    SetCamFocusDistance(targetCamera, targetFocus)

    if self.selectedPreset == 0 then
        SetCamActiveWithInterp(targetCamera, self.initCamera, 1200, 1, 1)
    elseif self.selectedPreset ~= target then
        local currCamera = self.presetCameras[self.selectedPreset] or 0
        local currConfig = self.config.presets[self.selectedPreset]
        local currPosition = currConfig.lineupCamPosition
        local currRotation = currConfig.lineupCamRotation
        local currFov = currConfig.lineupCamFov
        local currFocus = currConfig.lineupCamFocus

        SetCamCoord(currCamera, currPosition.x, currPosition.y, currPosition.z)
        SetCamRot(currCamera, currRotation.x, currRotation.y, currRotation.z, 2)
        SetCamFov(currCamera, currFov)
        SetCamFocusDistance(currCamera, currFocus)
        SetCamActiveWithInterp(targetCamera, currCamera, 1200, 1, 1)
    else
        SetCamActiveWithInterp(targetCamera, GetRenderingCam(), 900, 1, 1)
    end

    RenderScriptCams(true, false, 3000, true, false, 0)
    Utils:Debug("NET_CHAR_CREATOR_SET_ACTIVE_PED_PRESET - previous: ", EDITOR_CONFIG:ToString(self.selectedPreset), " next: ", EDITOR_CONFIG:ToString(target))

    self.selectedPreset = target
    self.presetCameras[target] = targetCamera
end

function Intro:MoveEditCamera(viewId)
    if not viewId or viewId == EDITOR_VIEW.INVALID then return end
    if viewId == self.currentEditViewId then return end

    local config = self.selectedPreset
    if not self.config or not self.config.editorViews then return end

    local viewData = self.config.editorViews[config] and self.config.editorViews[config][viewId]
    if not viewData then return end

    if DoesCamExist(self.editCamera) ~= 1 then
        return
    end

    -- Destroy any previous interpolation source camera
    if DoesCamExist(self.editCameraInterp) == 1 then
        DestroyCam(self.editCameraInterp, false)
        self.editCameraInterp = 0
    end

    -- Build a source camera from the current stored view data for smooth interpolation
    if self.currentEditViewData then
        local src = self.currentEditViewData
        self.editCameraInterp = CreateCamera(`DEFAULT_SCRIPTED_CAMERA`, false)
        SetCamCoord(self.editCameraInterp, src.position.x, src.position.y, src.position.z)
        SetCamRot(self.editCameraInterp, src.rotation.x, src.rotation.y, src.rotation.z, 2)
        SetCamFov(self.editCameraInterp, src.fov)
        SetCamFocusDistance(self.editCameraInterp, src.focus)
    end

    -- Move editCamera to the new view
    SetCamCoord(self.editCamera, viewData.position.x, viewData.position.y, viewData.position.z)
    SetCamRot(self.editCamera, viewData.rotation.x, viewData.rotation.y, viewData.rotation.z, 2)
    SetCamFov(self.editCamera, viewData.fov)
    SetCamFocusDistance(self.editCamera, viewData.focus)

    if DoesCamExist(self.editCameraInterp) == 1 then
        SetCamActiveWithInterp(self.editCamera, self.editCameraInterp, 900, 1, 1)
    else
        SetCamActive(self.editCamera, true)
    end

    RenderScriptCams(true, false, 3000, true, false, 0)

    self.currentEditViewId = viewId
    self.currentEditViewData = viewData
end

function Intro:SetupMirrorInteriorGroup()
    local interior = GetInteriorAtCoords(-561.8157, -3780.966, 239.0805)

    if IsValidInterior(interior) ~= 1 then
        Utils:Debug("NET_CHAR_CREATOR_SETUP_MIRROR_INTERIOR_GROUP - interior was not valid")
        return
    end

    if IsInteriorReady(interior) ~= 1 then
        Utils:Debug("NET_CHAR_CREATOR_SETUP_MIRROR_INTERIOR_GROUP - interior was not ready")
        return
    end

    local deactivate = self.selectedPreset == EDITOR_CONFIG.MALE and "mp_char_female_mirror" or "mp_char_male_mirror"
    local activate = self.selectedPreset == EDITOR_CONFIG.MALE and "mp_char_male_mirror" or "mp_char_female_mirror"

    if IsInteriorEntitySetValid(interior, deactivate) ~= 1 then
        Utils:Debug("NET_CHAR_CREATOR_SETUP_MIRROR_INTERIOR_GROUP - " .. deactivate .. " not valid")
        goto skip_deactivate
    end

    if IsInteriorEntitySetActive(interior, deactivate) == 1 then
        DeactivateInteriorEntitySet(interior, deactivate, true)
        Utils:Debug("NET_CHAR_CREATOR_SETUP_MIRROR_INTERIOR_GROUP - " .. deactivate .. " deactivated")
    else
        Utils:Debug("NET_CHAR_CREATOR_SETUP_MIRROR_INTERIOR_GROUP - " .. deactivate .. " already deactivated")
    end

    ::skip_deactivate::

    if IsInteriorEntitySetValid(interior, activate) ~= 1 then
        Utils:Debug("NET_CHAR_CREATOR_SETUP_MIRROR_INTERIOR_GROUP - " .. activate .. " not valid")
        return
    end

    if IsInteriorEntitySetActive(interior, activate) ~= 1 then
        ActivateInteriorEntitySet(interior, activate, 0)
        Utils:Debug("NET_CHAR_CREATOR_SETUP_MIRROR_INTERIOR_GROUP - " .. activate .. " activated")
    else
        Utils:Debug("NET_CHAR_CREATOR_SETUP_MIRROR_INTERIOR_GROUP - " .. activate .. " already activated")
    end
end

function Intro:AddDialogueParticipant(ped, characterName)
    if DoesEntityExist(ped) ~= 1 or IsEntityDead(ped) then
        return false
    end

    self.dialogParticipants[ped] = characterName

    return true
end

function Intro:StopAllConversations()
    StopAllScriptedConversions(true, false, false);
    Utils:Debug("NET_CHAR_CREATOR_STOP_ALL_CONVERSATIONS- Stopping all conversations created by this mission");
end

function Intro:CreateConversation(conversation, singleLine, singleLineIndex, preload, clone)
    if not IntroConfig.UseDialog then return true end

    local started = false
    if IsScriptedConversationCreated(conversation) ~= 1 then
        started = CreateNewScriptedConversation(conversation) == 1
    end

    if not started then
        Utils:Debug("NET_CHAR_CREATOR_CREATE_CONVERSATION - Couldn't play convo: ", conversation)
        return false
    end

    for ped, name in pairs(self.dialogParticipants) do
        if DoesEntityExist(ped) and IsEntityDead(ped) ~= 1 then
            if IsPedInCurrentConversation(conversation, ped, name) ~= 1 then
                AddPedToConversation(conversation, ped, name)
            end
        end
    end

    if preload then
        PreloadScriptConversation(conversation, true, true, clone)
    else
        StartScriptConversation(conversation, true, true, clone)
    end

    if singleLine then
        Citizen.InvokeNative(Natives.AudioPlaySingleConversationLine, conversation, singleLineIndex)
    end

    Utils:Debug("NET_CHAR_CREATOR_CREATE_CONVERSATION- Playing convo: ", conversation)
    return true
end

function Intro:CustomizeConversationUpdate()
    if not IntroConfig.UseDialog then return end
    if not IntroConfig.UseCustomizeDialog then return end

    if self:IsFlagSet(INTRO_FLAG.ROOM_DIALOG_PLAYED) then
        return
    end

    if self:IsFlagSet(INTRO_FLAG.ROOM_DIALOG_STARTED) and GetGameTimer() < self.nextCustomizeTime then
        return
    end

    local nextSeconds = GetRandomFloatInRange(12.0, 17.0) * 1000
    self.nextCustomizeTime = GetGameTimer() + nextSeconds

    self:CreateConversation("CHAR_OTHERROOM", true, self.nextCustomizeLine)
    self.nextCustomizeLine = self.nextCustomizeLine + 1

    if self.nextCustomizeLine >= 12 then
        self:SetFlag(INTRO_FLAG.ROOM_DIALOG_PLAYED)
    end

    self:SetFlag(INTRO_FLAG.ROOM_DIALOG_STARTED)
end

function Intro:RegisterCharacterPrompts(toggle)
    local enableReset = false
    if self.selectedPreset == EDITOR_CONFIG.MALE then
        enableReset = self:IsFlagSet(INTRO_FLAG.MALE_PED_RANDOMIZED)
    else
        enableReset = self:IsFlagSet(INTRO_FLAG.FEMALE_PED_RANDOMIZED)
    end

    self:RegisterPrompts({
        reset = {
            controls = { "INPUT_GAME_MENU_EXTRA_OPTION" },
            text = "Start Fresh",
            visible = enableReset,
            enabled = enableReset and toggle,
            hold = "MEDIUM_TIMED_EVENT",
        },
        confirm = {
            controls = { "INPUT_GAME_MENU_ACCEPT" },
            text = "Confirm",
            visible = true,
            enabled = toggle,
        },
        genderLeft = {
            controls = { "INPUT_GAME_MENU_LEFT" },
            text = "Character",
            visible = true,
            enabled = toggle,
        },
        genderRight = {
            controls = { "INPUT_GAME_MENU_RIGHT" },
            text = "Character",
            visible = true,
            enabled = toggle,
        },
    })
end

function Intro:RegisterEditorPrompts(toggle)
    local switchText = Creator:IsAdvancedMode() and "Basic Options" or "Advanced Options"
    local canReset = not self:IsFlagSet(INTRO_FLAG.RESET_CHARACTER) and self:IsFlagSet(INTRO_FLAG.CHARACTER_RESET_PROMPT)
    local enableReset = Character:IsModified() or Character:IsRandomized()

    if self.selectedPreset == EDITOR_CONFIG.MALE and self:IsFlagSet(INTRO_FLAG.MALE_PED_RANDOMIZED) then
        enableReset = true
    elseif self.selectedPreset == EDITOR_CONFIG.FEMALE and self:IsFlagSet(INTRO_FLAG.FEMALE_PED_RANDOMIZED) then
        enableReset = true
    end

    self:RegisterPrompts({
        settings = {
            controls = { "INPUT_GAME_MENU_TAB_LEFT_SECONDARY" },
            text = "Settings",
            visible = true,
            enabled = toggle,
        },
        switch = {
            controls = { "INPUT_GAME_MENU_LS" },
            text = switchText,
            visible = true,
            enabled = toggle,
        },
        reset = {
            controls = { "INPUT_GAME_MENU_EXTRA_OPTION" },
            text = "Start Fresh",
            visible = canReset and enableReset,
            enabled = canReset and enableReset and toggle,
            hold = "SHORT_TIMED_EVENT",
        },
    })
end

function Intro:RegisterMugshotPrompts(toggle, held)
    local seconds = self.mugshotTimer or 3
    local showUi = self.mugshotShowUi == true

    local confirmText = "Confirm"
    if held and showUi then
        confirmText = "Hide Details"
    elseif held and not showUi then
        confirmText = "Show Details"
    end

    self:RegisterPrompts({
        options = {
            controls = { "INPUT_SHOP_CHANGE_CURRENCY" },
            text = "Options",
            visible = true,
            enabled = toggle,
        },
        time = {
            controls = { "INPUT_GAME_MENU_LEFT", "INPUT_GAME_MENU_RIGHT" },
            text = string.format("Extra Time (%ds)", seconds),
            visible = held,
            enabled = toggle,
        },
        title = {
            controls = { "INPUT_GAME_MENU_OPTION" },
            text = "Change Title",
            visible = held,
            enabled = toggle and showUi,
        },
        confirm = {
            controls = { "INPUT_GAME_MENU_ACCEPT" },
            text = confirmText,
            visible = true,
            enabled = toggle,
        },
        cancel = {
            controls = { "INPUT_GAME_MENU_CANCEL" },
            text = "Back",
            visible = not held,
            enabled = toggle,
        },
    })
end

function Intro:RegisterPrompts(prompts)
    for key, prompt in pairs(prompts) do
        if not self.prompts[key] then
            self.prompts[key] = 0
        end

        if UiPromptIsValid(self.prompts[key]) ~= 1 then
            local handle = UiPromptRegisterBegin()

            for _, control in ipairs(prompt.controls) do
                UiPromptSetControlAction(handle, control)
            end

            if prompt.hold then
                UiPromptSetStandardizedHoldMode(handle, prompt.hold)
            else
                UiPromptSetStandardMode(handle, true)
            end

            UiPromptSetAttribute(handle, 18, true)
            UiPromptSetAttribute(handle, 17, true)
            UiPromptSetAttribute(handle, 14, true)
            UiPromptRegisterEnd(handle)

            self.prompts[key] = handle
        end

        local str = VarString(10, "LITERAL_STRING", prompt.text)
        UiPromptSetText(self.prompts[key], str)
        UiPromptSetVisible(self.prompts[key], prompt.visible)
        UiPromptSetEnabled(self.prompts[key], prompt.enabled)
    end
end

function Intro:DestroyPrompts()
    for key, prompt in pairs(self.prompts) do
        if UiPromptIsValid(prompt) then
            UiPromptDelete(prompt)
        end
        self.prompts[key] = 0
    end
end

function Intro:CreateObjective(text)
    UilogSetCachedObjective(text)
    UilogPrintCachedObjective()

    self.objectiveShown = true
end

function Intro:DestroyObjective()
    if self.objectiveShown then
        UilogClearCachedObjective()
    end

    self.objectiveShown = false
end

function Intro:DestroyAnimScenes()
    if DoesAnimSceneExist(self.animScene) then
        DeleteAnimScene(self.animScene)
    end

    if DoesAnimSceneExist(self.lightrig) then
        DeleteAnimScene(self.lightrig)
    end

    self.animScene = 0
    self.lightrig = 0
end

function Intro:DestroyAllPeds()
    local PED_HANDLES <const> = {
        self.guardPed,
        self.sheriffPed,
        self.presetPeds[EDITOR_CONFIG.MALE],
        self.presetPeds[EDITOR_CONFIG.FEMALE],
    }

    for _, ped in ipairs(PED_HANDLES) do
        if ped and DoesEntityExist(ped) then
            DeletePed(ped)
        end
    end

    self.guardPed = 0
    self.sheriffPed = 0
    self.presetPeds = {}
end

function Intro:DestroyAllCameras()
    local CAMERA_HANDLES <const> = {
        self.initCamera,
        self.presetCameras[EDITOR_CONFIG.MALE],
        self.presetCameras[EDITOR_CONFIG.FEMALE],
    }

    for _, cam in ipairs(CAMERA_HANDLES) do
        if cam and DoesCamExist(cam) then
            DestroyCam(cam, false)
        end
    end

    self.initCamera = 0
    self.presetCameras = {}

    DestroyAllCams(false)
    RenderScriptCams(false, false, 1000, true, false, 0)
end

function Intro:PlaySound(sound, set)
    StopSoundWithName(sound, set)
    PlaySoundFrontend(sound, set, true, 0)
end

function Intro:ResetEditorSettings()
    NetworkClockTimeOverride(10, 0, 0, 0, true)
    ClearTimecycleModifier()
    SetTimecycleModifier("Online_Character_Editor")

    self:ClearFlag(INTRO_FLAG.SUPPRESS_ANIMATION)
    self:ClearFlag(INTRO_FLAG.SUPPRESS_FIDGETS)
end

function Intro:IsFlagSet(flag)
    return (self.flags & flag) ~= 0
end

function Intro:SetFlag(flag)
    self.flags = (self.flags or 0) | flag
end

function Intro:ClearFlag(flag)
    self.flags = (self.flags or 0) & (~flag)
end

function Intro:Error(message, code)
    local suffix = ""
    if code then
        suffix = string.format("~n~~n~~COLOR_MENU_GREY_DARK~Error code %04d", code)
    end

    ShowAlert(
        "ERROR",
        "ALERT",
        string.format("%s~n~If this continues to happen, contact the server staff.%s", message, suffix),
        { acceptHash = `IB_DISMISS` }
    )

    self:SetState(INTRO_STATE.EXIT)
end

Citizen.CreateThread(function()
    while true do
        Intro:Maintain()
        Creator:Maintain()
        Wait(0)
    end
end)

SignalBus:on("item_focused", function(itemId)
    if itemId == UI_ITEM_ID.APPEARANCE__RANDOMIZE then
        Intro:SetFlag(INTRO_FLAG.CHARACTER_RESET_PROMPT)
    else
        Intro:ClearFlag(INTRO_FLAG.CHARACTER_RESET_PROMPT)
    end
end)

SignalBus:on("zoom_updated", function(zoomed)
    if zoomed then
        Intro:SetFlag(INTRO_FLAG.EDITOR_ZOOMED)
    else
        Intro:ClearFlag(INTRO_FLAG.EDITOR_ZOOMED)
    end

    if not Intro.currentEditorCameraData then return end

    local viewId
    if zoomed and Intro.currentEditorCameraData.Zoomed and Intro.currentEditorCameraData.Zoomed ~= EDITOR_VIEW.INVALID then
        viewId = Intro.currentEditorCameraData.Zoomed
    else
        viewId = Intro.currentEditorCameraData.Default
    end

    Intro:MoveEditCamera(viewId)
end)

SignalBus:on("camera_updated", function(data)
    if not data then return end

    Intro.currentEditorCameraData = data

    local viewId
    if Intro:IsFlagSet(INTRO_FLAG.EDITOR_ZOOMED) and data.Zoomed and data.Zoomed ~= EDITOR_VIEW.INVALID then
        viewId = data.Zoomed
    else
        viewId = data.Default
    end

    Intro:MoveEditCamera(viewId)
end)

SignalBus:on("timecycle_changed", function(name)
    ClearTimecycleModifier()
    SetTimecycleModifier(name)
end)

SignalBus:on("timeofday_changed", function(time)
    NetworkClockTimeOverride(time or 10, 0, 0, 0, true)
end)

SignalBus:on("menu_confirm", function()
    Intro.editorResult = INTRO_EDITOR_STATUS.CONFIRM
end)

SignalBus:on("menu_cancel", function()
    Intro.editorResult = INTRO_EDITOR_STATUS.CANCEL
end)

SignalBus:on("alert_accept", function(id)
    if id ~= Intro.alertHandle then return end
    Intro:ClearFlag(INTRO_FLAG.REROLL_CANCEL_ALERT_CREATED)
    Intro:SetFlag(INTRO_FLAG.REROLL_CANCEL_ALERT_CONFIRM)
end)

SignalBus:on("alert_back", function(id)
    if id ~= Intro.alertHandle then return end
    Intro:ClearFlag(INTRO_FLAG.REROLL_CANCEL_ALERT_CREATED)
    Intro:SetFlag(INTRO_FLAG.REROLL_CANCEL_ALERT_CANCEL)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Intro:SetFlag(INTRO_FLAG.FORCE_EXIT)
    Intro:MaintainExit()
end)
