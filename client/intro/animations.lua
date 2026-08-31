--- @class IntroAnim
IntroAnimations = {
    flags = 0,
    bodySize = 0.5,
    lastFidget = {},
    nextFidget = {},
    headingFixTimer = 0,
    showTeeth = false,
    showEyes = false,
}

function IntroAnimations:Reset()
    self.flags = 0
    self.bodySize = 0.5
    self.lastFidget = {}
    self.nextFidget = {}
end

function IntroAnimations:IsFlagSet(flag)
    return (self.flags & flag) ~= 0
end

function IntroAnimations:SetFlag(flag)
    Utils:Debug("IntroAnimations:SetFlag - CCMN - setting flag: ", INTRO_ANIMATION_FLAG:ToString(flag))
    self.flags = self.flags | flag
end

function IntroAnimations:ClearFlag(flag)
    Utils:Debug("IntroAnimations:ClearFlag - CCMN - clearing flag: ", INTRO_ANIMATION_FLAG:ToString(flag))
    self.flags = self.flags & (~flag)
end

function IntroAnimations:MaintainFidgets(preset, ped)
    SetRandomSeed(GetGameTimer() + ped)

    local delay = GetRandomFloatInRange(
        (IntroConfig.FidgetCooldownMin or 30) + 0.1,
        (IntroConfig.FidgetCooldownMax or 60) + 0.1
    )

    if not self.lastFidget[preset] then
        self.lastFidget[preset] = -1
    end

    if not self.nextFidget[preset] then
        self.nextFidget[preset] = GetGameTimer() + (delay * 1000)
    end

    if GetGameTimer() < self.nextFidget[preset] then
        return
    end

    if not EDITOR_VIEW:GetSupportsFidgets(Intro.currentEditViewId) then
        self.nextFidget[preset] = GetGameTimer() + (delay * 1000)
        Utils:Debug("CHARACTER_EDITOR_MAINTAIN_FIDGETS - CCMN - preset: ", EDITOR_CONFIG:ToString(preset), " - fidget skipped due to edit view: ", EDITOR_VIEW:ToString(Intro.currentEditViewId))
        return
    end

    if Intro:IsFlagSet(INTRO_FLAG.SUPPRESS_FIDGETS) then
        self.nextFidget[preset] = GetGameTimer() + (delay * 1000)
        Utils:Debug("CHARACTER_EDITOR_MAINTAIN_FIDGETS - CCMN - preset: ", EDITOR_CONFIG:ToString(preset), " - fidget skipped due to suppress flag or zoom input")
        return
    end

    local gender = preset == EDITOR_CONFIG.MALE and "male" or "female"
    local dictionary = string.format("mp_character_creator@%s@fidgets", gender)

    local FIDGETS <const> = {
        "fidget_a", "fidget_b",
        "fidget_c", "fidget_d",
        "fidget_e", "fidget_f",
        "fidget_g", "fidget_h",
    }

    local index = GetRandomIntInRange(0, #FIDGETS)
    if index == self.lastFidget[preset] then
        index = (index + 1) % #FIDGETS
    end

    local fidget = FIDGETS[index + 1]

    Utils:Debug("CHARACTER_EDITOR_MAINTAIN_FIDGETS - CCMN - preset: ", EDITOR_CONFIG:ToString(preset), " - fidget playing: ", fidget)
    TaskPlayAnim(ped, dictionary, fidget, 1.5, -1.5, -1, 67108880, 0.0, false, 65536, false, "", false)

    self.lastFidget[preset] = index
    self.nextFidget[preset] = GetGameTimer() + (delay * 1000)
end

function IntroAnimations:MaintainAnimations(preset, ped)
    if DoesEntityExist(ped) ~= 1 then
        Utils:Debug("MAINTAIN_ANIMATIONS - CCMN - ped does not exist for preset: ", EDITOR_CONFIG:ToString(preset))
        return
    end

    if IsTaskMoveNetworkActive(ped) ~= 1 then
        Utils:Debug("NET_CHAR_CREATOR__MOVE_NET__MAINTAIN_NEUTRAL - CCMN - trying out this move network ")
        self:InitializeMoveNetwork(preset, ped)
        return
    end

    self:MaintainMoveNetwork(preset, ped)
end

function IntroAnimations:InitializeMoveNetwork(preset, ped)
    self.bodySize = self:GetBodySize()

    local gender = preset == EDITOR_CONFIG.MALE and "male" or "female"
    local clipset = string.format("clipset@mp_character_creator@%s", gender)

    local position = GetEntityCoords(ped, true)
    local rotation = GetEntityRotation(ped, 2)

    local struct = DataView.ArrayBuffer(512)
    struct:SetInt32(0 * 8, joaat(clipset))
    struct:SetInt32(1 * 8, joaat(clipset))
    struct:SetInt64(4 * 8, VarString(10, "LITERAL_STRING", "BODY_SIZE"))
    struct:SetFloat32(5 * 8, self.bodySize or 0.5)
    struct:SetInt64(7 * 8, VarString(10, "LITERAL_STRING", "STEP_SIGNAL"))
    struct:SetFloat32(8 * 8, 0.5)
    struct:SetInt64(30 * 8, VarString(10, "LITERAL_STRING", "Idle_State"))

    if IsTaskMoveNetworkActive(ped) ~= 1 then
        -- TASK::TASK_MOVE_NETWORK_ADVANCED_BY_NAME_WITH_INIT_PARAMS
        Citizen.InvokeNative(0x7B6A04F98BBAFB2C, ped, "Character_Creator", struct:Buffer(), position.x, position.y, position.z, rotation.x, rotation.y, rotation.z, 2, 0.3, 0, 0, 2, 0)
    end

    SetTaskMoveNetworkSignalFloat(ped, "BODY_SIZE", self.bodySize or 0.5)
    ForcePedMotionState(ped, "MotionState_DoNothing", false, 0, false)
    FreezeEntityPosition(ped, false)
end

function IntroAnimations:MaintainMoveNetwork(preset, ped)
    local suppressAnimation = Intro:IsFlagSet(INTRO_FLAG.SUPPRESS_ANIMATION)
    local suppressRotation = Intro:IsFlagSet(INTRO_FLAG.SUPPRESS_ROTATION)

    local gender = preset == EDITOR_CONFIG.MALE and "male" or "female"
    local clipset = string.format("clipset@mp_character_creator@%s", gender)

    Citizen.InvokeNative(0x615DC4A82E90BB48, ped, joaat(clipset), 184808581)
    ForcePedMotionState(ped, "MotionState_DoNothing", false, 0, false)

    local inputLeft = IsControlPressed(2, `INPUT_GAME_MENU_TAB_LEFT`)
    local inputRight = IsControlPressed(2, `INPUT_GAME_MENU_TAB_RIGHT`)
    local isZoomed = EDITOR_VIEW:GetIsZoom(Intro.currentEditViewId)

    if IsUiappRunningByHash("character_creator") ~= 1 then
        inputLeft = false
        inputRight = false
    end

    if (suppressAnimation or suppressRotation) and (inputLeft or inputRight) then
        local current = GetEntityHeading(ped)

        if inputLeft then
            current = current - 3.0
        elseif inputRight then
            current = current + 3.0
        end

        if current < 0.0 then
            current = 360.0 + current
        elseif current > 360.0 then
            current = current - 360.0
        end

        SetPedDesiredHeading(ped, current)
        SetEntityHeading(ped, current)
    end

    if suppressAnimation or isZoomed then
        if not self:IsFlagSet(INTRO_ANIMATION_FLAG.ZOOM_MOOD) then
            SetFacialIdleAnimOverride(ped, "mood_normal_zoom", "face_human@gen_male@base")
            self:SetFlag(INTRO_ANIMATION_FLAG.ZOOM_MOOD)
        end

        -- Check transition into Still Idle
        if not self:IsFlagSet(INTRO_ANIMATION_FLAG.STILL_IDLE) then
            if not self:IsFlagSet(INTRO_ANIMATION_FLAG.TURNING) then
                local netState = GetTaskMoveNetworkState(ped)

                if netState == "Idle_State" then
                    if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                        local headingState = self:GetHeadingState(ped)

                        SetTaskMoveNetworkSignalFloat(ped, "CURRENT_HEADING", headingState)
                        RequestTaskMoveNetworkStateTransition(ped, "Turn_to_Face_Transition")

                        self:SetFlag(INTRO_ANIMATION_FLAG.TURNING)
                        self:ClearFlag(INTRO_ANIMATION_FLAG.STEP_LEFT_ACTIVE)
                        self:ClearFlag(INTRO_ANIMATION_FLAG.STEP_RIGHT_ACTIVE)
                    else
                        if netState == "Turn_to_Face_Transition" then
                            self:SetFlag(INTRO_ANIMATION_FLAG.TURNING)
                        end
                    end
                else
                    -- Not in Idle_State, handle Stops/Steps
                    if netState == "Stop_Right_State" then
                        if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                            RequestTaskMoveNetworkStateTransition(ped, "Idle_State")
                        end
                    elseif netState == "Stop_Left_State" then
                        if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                            RequestTaskMoveNetworkStateTransition(ped, "Idle_State")
                        end
                    elseif netState == "Step_Right_State" then
                        if IsTaskMoveNetworkReadyForTransition(ped) == 1 and HasAnimEventFired(ped, 1752866596) then
                            RequestTaskMoveNetworkStateTransition(ped, "Stop_Right_State")
                        end
                    elseif netState == "Step_Left_State" then
                        if IsTaskMoveNetworkReadyForTransition(ped) == 1 and HasAnimEventFired(ped, -1187150655) then
                            RequestTaskMoveNetworkStateTransition(ped, "Stop_Left_State")
                        end
                    end
                end
            elseif
                GetTaskMoveNetworkState(ped) == "Turn_to_Face_Transition" and
                (GetTaskMoveNetworkEvent(ped, "Turn_to_Face_TransitionClipFinished") or self:GetHeadingState(ped) == 0.5) and
                IsTaskMoveNetworkReadyForTransition(ped) == 1
            then
                RequestTaskMoveNetworkStateTransition(ped, "Still_Idle")
                self:SetFlag(INTRO_ANIMATION_FLAG.STILL_IDLE)
            else
                if GetTaskMoveNetworkState(ped) == "Still_Idle" then
                    self:SetFlag(INTRO_ANIMATION_FLAG.STILL_IDLE)
                    self:ClearFlag(INTRO_ANIMATION_FLAG.TURNING)
                end
                if GetTaskMoveNetworkState(ped) == "Idle_State" then
                    self:ClearFlag(INTRO_ANIMATION_FLAG.TURNING)
                end
            end
        end

        -- Handle Still Idle Inputs (Zoom Active)
        if self:IsFlagSet(INTRO_ANIMATION_FLAG.STILL_IDLE) then
            if not suppressAnimation and not suppressRotation and inputRight then
                if not self:IsFlagSet(INTRO_ANIMATION_FLAG.LOOK_LEFT) then
                    if GetTaskMoveNetworkState(ped) == "Still_Idle" then
                        if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                            RequestTaskMoveNetworkStateTransition(ped, "Look_Left_Idle")
                            self:SetFlag(INTRO_ANIMATION_FLAG.LOOK_LEFT)
                        end
                    elseif not inputLeft then
                        if self:IsFlagSet(INTRO_ANIMATION_FLAG.LOOK_RIGHT) then
                            if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                                SetTaskMoveNetworkSignalFloat(ped, "CURRENT_HEADING", 0.5)
                                RequestTaskMoveNetworkStateTransition(ped, "Still_Idle")
                                self:ClearFlag(INTRO_ANIMATION_FLAG.LOOK_RIGHT)
                            end
                        end
                    end
                end
            elseif not suppressAnimation and not suppressRotation and inputLeft then
                if not self:IsFlagSet(INTRO_ANIMATION_FLAG.LOOK_RIGHT) then
                    if GetTaskMoveNetworkState(ped) == "Still_Idle" then
                        if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                            RequestTaskMoveNetworkStateTransition(ped, "Look_Right_Idle")
                            self:SetFlag(INTRO_ANIMATION_FLAG.LOOK_RIGHT)
                        end
                    elseif not inputRight then
                        if self:IsFlagSet(INTRO_ANIMATION_FLAG.LOOK_LEFT) then
                            if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                                SetTaskMoveNetworkSignalFloat(ped, "CURRENT_HEADING", 0.5)
                                RequestTaskMoveNetworkStateTransition(ped, "Still_Idle")
                                self:ClearFlag(INTRO_ANIMATION_FLAG.LOOK_LEFT)
                            end
                        end
                    end
                end
            elseif self:IsFlagSet(INTRO_ANIMATION_FLAG.LOOK_LEFT) or self:IsFlagSet(INTRO_ANIMATION_FLAG.LOOK_RIGHT) then
                -- No inputs, return to Still Idle
                if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                    SetTaskMoveNetworkSignalFloat(ped, "CURRENT_HEADING", 0.5)
                    RequestTaskMoveNetworkStateTransition(ped, "Still_Idle")
                    self:ClearFlag(INTRO_ANIMATION_FLAG.LOOK_LEFT)
                    self:ClearFlag(INTRO_ANIMATION_FLAG.LOOK_RIGHT)
                end
            end
        end
    else
        -- Clear Zoom Mood
        if self:IsFlagSet(INTRO_ANIMATION_FLAG.ZOOM_MOOD) then
            ClearFacialIdleAnimOverride(ped)
            self:ClearFlag(INTRO_ANIMATION_FLAG.ZOOM_MOOD)
        end

        -- Exit Still Idle
        if self:IsFlagSet(INTRO_ANIMATION_FLAG.STILL_IDLE) then
            if GetTaskMoveNetworkState(ped) == "Still_Idle" then
                if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                    RequestTaskMoveNetworkStateTransition(ped, "Idle_State")
                    self:ClearFlag(INTRO_ANIMATION_FLAG.STILL_IDLE)
                end
            elseif GetTaskMoveNetworkState(ped) == "Look_Right_Idle" or GetTaskMoveNetworkState(ped) == "Look_Left_Idle" then
                if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                    RequestTaskMoveNetworkStateTransition(ped, "Still_Idle")
                end
            elseif GetTaskMoveNetworkState(ped) == "Idle_State" then
                self:ClearFlag(INTRO_ANIMATION_FLAG.STILL_IDLE)
            end
        end

        -- Exit Turning
        if self:IsFlagSet(INTRO_ANIMATION_FLAG.TURNING) then
            if GetTaskMoveNetworkState(ped) == "Idle_State" then
                self:ClearFlag(INTRO_ANIMATION_FLAG.TURNING)
            elseif
                GetTaskMoveNetworkState(ped) == "Turn_to_Face_Transition" and
                IsTaskMoveNetworkReadyForTransition(ped) == 1 and
                (GetTaskMoveNetworkEvent(ped, "Turn_to_Face_TransitionClipFinished") or self:GetHeadingState(ped) == 0.5)
            then
                RequestTaskMoveNetworkStateTransition(ped, "Idle_State")
                self:ClearFlag(INTRO_ANIMATION_FLAG.TURNING)
            end
        end

        if not self:IsFlagSet(INTRO_ANIMATION_FLAG.STEP_LEFT_ACTIVE) then
            if not suppressRotation and inputRight and not self:IsFlagSet(INTRO_ANIMATION_FLAG.STEP_RIGHT_ACTIVE) then
                local netState = GetTaskMoveNetworkState(ped)
                if netState == "Idle_State" or netState == "Stop_Left_State" or (netState == "Step_Right_State" and HasAnimEventFired(ped, 1752866596)) then
                    if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                        RequestTaskMoveNetworkStateTransition(ped, "Step_Left_State")
                        self:ClearFlag(INTRO_ANIMATION_FLAG.STEP_RIGHT_ACTIVE)
                        self:SetFlag(INTRO_ANIMATION_FLAG.STEP_LEFT_ACTIVE)
                    end
                end
            end
        else
            -- Stepping Left Active
            if not inputRight then
                if GetTaskMoveNetworkState(ped) == "Step_Left_State" then
                    if IsTaskMoveNetworkReadyForTransition(ped) == 1 and HasAnimEventFired(ped, -1187150655) then
                        RequestTaskMoveNetworkStateTransition(ped, "Stop_Left_State")
                        self:ClearFlag(INTRO_ANIMATION_FLAG.STEP_LEFT_ACTIVE)
                    end
                end
            end
        end

        if not self:IsFlagSet(INTRO_ANIMATION_FLAG.STEP_RIGHT_ACTIVE) then
            if not suppressRotation and inputLeft and not self:IsFlagSet(INTRO_ANIMATION_FLAG.STEP_LEFT_ACTIVE) then
                local netState = GetTaskMoveNetworkState(ped)
                if netState == "Idle_State" or netState == "Stop_Right_State" or (netState == "Step_Left_State" and HasAnimEventFired(ped, -1187150655)) then
                    if IsTaskMoveNetworkReadyForTransition(ped) == 1 then
                        RequestTaskMoveNetworkStateTransition(ped, "Step_Right_State")
                        self:ClearFlag(INTRO_ANIMATION_FLAG.STEP_LEFT_ACTIVE)
                        self:SetFlag(INTRO_ANIMATION_FLAG.STEP_RIGHT_ACTIVE)
                    end
                end
            end
        else
            -- Stepping Right Active
            if not inputLeft then
                if GetTaskMoveNetworkState(ped) == "Step_Right_State" then
                    if IsTaskMoveNetworkReadyForTransition(ped) == 1 and HasAnimEventFired(ped, 1752866596) then
                        RequestTaskMoveNetworkStateTransition(ped, "Stop_Right_State")
                        self:ClearFlag(INTRO_ANIMATION_FLAG.STEP_RIGHT_ACTIVE)
                    end
                end
            end
        end

        -- Handle final cleanup back to Idle from Stop states
        if not inputRight then
            if GetTaskMoveNetworkState(ped) == "Stop_Left_State" then
                if IsTaskMoveNetworkReadyForTransition(ped) == 1 and HasAnimEventFired(ped, -1727958697) then
                    RequestTaskMoveNetworkStateTransition(ped, "Idle_State")
                end
            end
        end

        if not inputLeft then
            if GetTaskMoveNetworkState(ped) == "Stop_Right_State" then
                if IsTaskMoveNetworkReadyForTransition(ped) == 1 and HasAnimEventFired(ped, 993220401) then
                    RequestTaskMoveNetworkStateTransition(ped, "Idle_State")
                end
            end
        end

        self:HandleBodySizeTransition(ped)
    end

    self:HandleSpecialAnimations(ped)

    if not suppressAnimation and not suppressRotation then
        self:HandlePositionFix(ped)
    end
end

function IntroAnimations:HandleBodySizeTransition(ped)
    local current = self.bodySize or 0.5
    local expected = self:GetBodySize()

    if math.abs(current - expected) >= 0.025 then
        if current < expected then
            current = current + 0.025
        elseif current > expected then
            current = current - 0.025
        end

        if current < 0.0 then current = 0.0 end
        if current > 1.0 then current = 1.0 end

        self.bodySize = current
    end

    SetTaskMoveNetworkSignalFloat(ped, "BODY_SIZE", current)
end

function IntroAnimations:HandleSpecialAnimations(ped)
    local AF_LOOPING <const> = (1 << 0)
    local AF_SECONDARY <const> = (1 << 4)

    local faceDentistryInTime = GetEntityAnimCurrentTime(ped, "face_human@gen_male@base", "Face_Dentistry_In")
    local eyesWideEnterTime = GetEntityAnimCurrentTime(ped, "face_human@gen_male@base", "eyes_wide_enter")

    if self.showTeeth then
        if not self:IsFlagSet(INTRO_ANIMATION_FLAG.MOUTH_STARTED) then
            TaskPlayAnim(ped, "face_human@gen_male@base", "Face_Dentistry_In", 1.5, -4.0, -1, AF_SECONDARY, 0.0, false, 0, false, "", false)
            self:SetFlag(INTRO_ANIMATION_FLAG.MOUTH_STARTED)
        elseif not self:IsFlagSet(INTRO_ANIMATION_FLAG.MOUTH_OPENED) and faceDentistryInTime > 0.95 then
            TaskPlayAnim(ped, "face_human@gen_male@base", "Face_Dentistry_Loop", 8.0, -4.0, -1, (AF_LOOPING | AF_SECONDARY), 0.0, false, 0, false, "", false)
            self:SetFlag(INTRO_ANIMATION_FLAG.MOUTH_OPENED)
        end
    elseif self:IsFlagSet(INTRO_ANIMATION_FLAG.MOUTH_OPENED) or (self:IsFlagSet(INTRO_ANIMATION_FLAG.MOUTH_STARTED) and faceDentistryInTime > 0.95) then
        TaskPlayAnim(ped, "face_human@gen_male@base", "Face_Dentistry_Out", 4.0, -1.5, -1, AF_SECONDARY, 0.0, false, 0, false, "", false)
        self:ClearFlag(INTRO_ANIMATION_FLAG.MOUTH_OPENED)
        self:ClearFlag(INTRO_ANIMATION_FLAG.MOUTH_STARTED)
    end

    if self.showEyes then
        if not self:IsFlagSet(INTRO_ANIMATION_FLAG.EYES_STARTED) then
            TaskPlayAnim(ped, "face_human@gen_male@base", "eyes_wide_enter", 1.5, -4.0, -1, AF_SECONDARY, 0.0, false, 0, false, "", false)
            self:SetFlag(INTRO_ANIMATION_FLAG.EYES_STARTED)
        elseif not self:IsFlagSet(INTRO_ANIMATION_FLAG.EYES_WIDENED) and eyesWideEnterTime > 0.95 then
            TaskPlayAnim(ped, "face_human@gen_male@base", "mood_normal_eyes_wide", 8.0, -4.0, -1, (AF_LOOPING | AF_SECONDARY), 0.0, false, 0, false, "", false)
            self:SetFlag(INTRO_ANIMATION_FLAG.EYES_WIDENED)
        end
    elseif self:IsFlagSet(INTRO_ANIMATION_FLAG.EYES_WIDENED) or (self:IsFlagSet(INTRO_ANIMATION_FLAG.EYES_STARTED) and eyesWideEnterTime > 0.95) then
        TaskPlayAnim(ped, "face_human@gen_male@base", "eyes_wide_exit", 4.0, -1.5, -1, AF_SECONDARY, 0.0, false, 0, false, "", false)
        self:ClearFlag(INTRO_ANIMATION_FLAG.EYES_WIDENED)
        self:ClearFlag(INTRO_ANIMATION_FLAG.EYES_STARTED)
    end
end

function IntroAnimations:HandlePositionFix(ped)
    if self.headingFixTimer > 0 then
        self.headingFixTimer = self.headingFixTimer - GetFrameTime()
        return
    end

    if GetTaskMoveNetworkState(ped) ~= "Idle_State" then
        return
    end

    -- Prevents the player from slowly rotating away over time
    if self:GetHeadingState(ped) == 0.5 then
        SetEntityHeading(ped, 90.0)
    end

    self.headingFixTimer = 1.0
end

function IntroAnimations:GetHeadingState(ped)
    local heading = GetEntityHeading(ped)

    if heading > 112.5 and heading <= 157.5 then
        return 0.375
    elseif heading > 157.5 and heading <= 202.5 then
        return 0.25
    elseif heading > 202.5 and heading <= 247.5 then
        return 0.125
    elseif heading > 247.5 and heading <= 292.5 then
        return 0.0
    elseif heading > 292.5 and heading <= 337.5 then
        return 0.875
    elseif heading > 337.5 or heading <= 22.5 then
        return 0.75
    elseif heading > 22.5 and heading <= 67.5 then
        return 0.625
    end

    return 0.5
end

function IntroAnimations:GetBodySize()
    local bodyBuild = Character:GetBodyBuild()
    return CHARACTER_BODY_BUILD:GetMoveNetSignal(bodyBuild) or 0.5
end

SignalBus:on("show_teeth", function(value)
    IntroAnimations.showTeeth = value
end)

SignalBus:on("show_eyes", function(value)
    IntroAnimations.showEyes = value
end)
