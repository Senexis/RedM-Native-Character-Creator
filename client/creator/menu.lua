local MENU_ID <const> = "NCC_MAIN_MENU"
local SETTINGS_ID <const> = "NCC_SETTINGS_MENU"
local TIMES <const> = { 10, 12, 14, 16, 18, 20, 6, 8 }

CreatorMenu = {
    rerolling = false,
    created = false,
    settingLighting = nil,
    settingTime = nil,
    settingClothing = nil,
    settingAnimations = nil,
    settingRotation = nil,
}

function CreatorMenu:Open(rerolling, toSettings)
    self.rerolling = rerolling or false

    local target = toSettings and SETTINGS_ID or MENU_ID
    ShopApi.Open(target)
end

function CreatorMenu:Close()
    ShopApi.Close()
end

function CreatorMenu:Hide()
    ShopApi.Hide()
end

function CreatorMenu:Refresh()
    ShopApi.RefreshRoot(MENU_ID)
    ShopApi.RefreshMenu(MENU_ID)
end

function CreatorMenu:Reset()
    self.created = false
    self.settingLighting = nil
    self.settingTime = nil
    self.settingClothing = nil
    self.settingAnimations = nil
    self.settingRotation = nil
    self:Refresh()
end

function CreatorMenu:Confirm()
    self.created = true
    self:Refresh()
end

function CreatorMenu:GenerateName(config)
    SetRandomSeed(GetGameTimer() + config)

    local firstList = IntroConfig.Names[config] or {}
    local lastList = IntroConfig.Names.surnames or {}

    if #firstList == 0 or #lastList == 0 then
        if config == EDITOR_CONFIG.MALE then
            return "John Doe"
        elseif config == EDITOR_CONFIG.FEMALE then
            return "Jane Doe"
        else
            ShowAlert(
                "ERROR",
                "ALERT",
                "Failed to generate a random name due to an invalid character being used. Contact the server staff.",
                { acceptHash = `IB_DISMISS` }
            )

            return ""
        end
    end

    local firstIndex = GetRandomIntInRange(1, #firstList + 1)
    local lastIndex = GetRandomIntInRange(1, #lastList + 1)

    return firstList[firstIndex] .. " " .. lastList[lastIndex]
end

function CreatorMenu:GetTimecycleLabels()
    local labels = {}

    for _, timecycle in pairs(IntroConfig.TimecycleModifiers) do
        labels[#labels + 1] = timecycle.label
    end

    return labels
end

function CreatorMenu:GetTimecycleValue(value)
    local config = IntroConfig.TimecycleModifiers[value or 1]
    if not config then return "Online_Character_Editor" end
    return config.value or "Online_Character_Editor"
end

function CreatorMenu:GetTimeOfDayLabels()
    -- MISC::_SHOULD_USE_24_HOUR_CLOCK
    local shouldUse24 = Citizen.InvokeNative(0x0177CF20345F44DD) == 1

    local labels = {}
    for _, hour in pairs(TIMES) do
        local suffix12 = hour > 12 and "PM" or "AM"
        local hour12 = hour > 12 and hour - 12 or hour

        local label = shouldUse24
            and string.format("%02d:00", hour)
            or string.format("%d:00 %s", hour12, suffix12)

        labels[#labels + 1] = label
    end

    return labels
end

function CreatorMenu:GetTimeOfDayValue(value)
    return TIMES[value or 1]
end

function CreatorMenu:GetMenu()
    local presetRandomized = false
    if Creator.config == EDITOR_CONFIG.MALE and Intro:IsFlagSet(INTRO_FLAG.MALE_PED_RANDOMIZED) then
        presetRandomized = true
    elseif Creator.config == EDITOR_CONFIG.FEMALE and Intro:IsFlagSet(INTRO_FLAG.FEMALE_PED_RANDOMIZED) then
        presetRandomized = true
    end

    local nameDisplay = {
        Visible = Character.name ~= "",
        Text = Character.name,
        Centered = true,
        IconVisible = true,
        IconTextureDictionary = "blips_mp",
        IconTexture = "blip_ambient_vip",
    }

    local hasName = Character.name ~= ""
    local rerolling = self.rerolling or false
    local hasCreated = self.created or false

    local defaultLabel = rerolling and "Edit Character" or "Create Character"
    local defaultDescription = rerolling and "Edit your character's appearance." or "Create a new character to play as."
    local confirmDescription = rerolling and "Save your changes and exit." or "Confirm your character and enter the world."
    local exitLabel = rerolling and "Exit" or "Back"

    local skipPrompt = {
        Visible = not rerolling and not hasCreated,
        Enabled = not rerolling and not hasCreated,
        Label = "Skip",
        Action = function()
            self.created = true
            self:Refresh()
        end,
    }

    if rerolling or hasCreated or not presetRandomized then
        skipPrompt = {}
    end

    return {
        Title = "CHARACTER",
        Subtitle = "Main Menu",
        Scene = "ITEM_LIST_DESCRIPTION",
        Prompts = {
            Back = {
                Visible = true,
                Label = exitLabel,
            }
        },
        Items = {
            {
                Id = "ACTION_NAME",
                Type = "TEXT",
                Label = "Name",
                Data = {
                    ItemDescription = "Set your character's name.",
                    Equipped = not rerolling and hasName,
                    ItemInfo1 = nameDisplay,
                },
                Prompts = {
                    Select = {
                        Action = function()
                            Creator:Rename()
                        end,
                    },
                    Toggle = {
                        Label = "Randomize",
                        Action = function()
                            Character.name = self:GenerateName(Creator.config)
                            self:Refresh()
                        end,
                    },
                },
            },
            {
                Id = "ACTION_DEFAULT",
                Type = "TEXT",
                Label = defaultLabel,
                Disabled = not rerolling and not hasName,
                Data = {
                    DisabledFooter = "~e~Set a name first.",
                    ItemDescription = defaultDescription,
                    Equipped = not rerolling and hasCreated,
                    ItemInfo1 = nameDisplay,
                },
                Prompts = {
                    Select = {
                        Action = function()
                            self:Hide()
                            Creator:OpenEditor(CREATOR_MODE.DEFAULT, false)
                        end,
                    },
                    Toggle = skipPrompt
                }
            },
            {
                Id = "ACTION_ADVANCED",
                Type = "TEXT",
                Label = "Advanced Mode",
                Disabled = not rerolling and not hasName,
                Data = {
                    DisabledFooter = "~e~Set a name first.",
                    ItemDescription = "Optional. Tweak various character attributes.",
                    Equipped = not rerolling and hasCreated,
                    ItemInfo1 = nameDisplay,
                },
                Prompts = {
                    Select = {
                        Action = function()
                            self:Hide()
                            Creator:OpenEditor(CREATOR_MODE.ADVANCED, false)
                        end,
                    },
                    Toggle = skipPrompt
                }

            },
            {
                Id = SETTINGS_ID,
                Type = "TEXT",
                Label = "Settings",
                Title = "SETTINGS",
                Subtitle = "Creator Settings",
                Data = {
                    ItemDescription = "Adjust various settings like camera zoom, lighting, animations, and more for the character creator.",
                    ItemInfo1 = nameDisplay,
                },
                Items = {
                    {
                        Id = "SETTING_ZOOM",
                        Type = "STEPPER",
                        Label = "Zoom",
                        Data = {
                            ItemDescription = "Toggle whether the camera zoom controls are held or toggled.",
                            StepperOptions = {
                                [ZOOM_MODE.HOLD]   = "Hold",
                                [ZOOM_MODE.TOGGLE] = "Toggle"
                            },
                            StepperValue = self.settingZoom or ZOOM_MODE.HOLD,
                            StepperVisible = true,
                        },
                        Prompts = {
                            Adjust = {
                                Action = function(event)
                                    local value = event.Data.StepperValue or ZOOM_MODE.HOLD
                                    SignalBus:emit("zoom_mode_changed", value)
                                    self.settingZoom = value
                                end,
                            },
                        },
                    },
                    {
                        Id = "SETTING_LIGHTING",
                        Type = "STEPPER",
                        Label = "Lighting Preset",
                        Data = {
                            ItemDescription = "Change the lighting preset used.",
                            StepperOptions = self:GetTimecycleLabels(),
                            StepperValue = self.settingLighting or 1,
                            StepperVisible = true,
                        },
                        Prompts = {
                            Adjust = {
                                Action = function(event)
                                    local value = event.Data.StepperValue or 0
                                    local timecycle = self:GetTimecycleValue(value)
                                    SignalBus:emit("timecycle_changed", timecycle)
                                    self.settingLighting = value
                                end,
                            },
                        },
                    },
                    {
                        Id = "SETTING_TIME",
                        Type = "STEPPER",
                        Label = "Time of Day",
                        Data = {
                            ItemDescription = "Change the time of day. Depending on the lighting preset, certain times of day may cause visual issues.",
                            StepperOptions = self:GetTimeOfDayLabels(),
                            StepperValue = self.settingTime or 1,
                            StepperVisible = true,
                        },
                        Prompts = {
                            Adjust = {
                                Action = function(event)
                                    local value = event.Data.StepperValue or 1
                                    local time = self:GetTimeOfDayValue(value)
                                    SignalBus:emit("timeofday_changed", time)
                                    self.settingTime = value
                                end,
                            },
                        }
                    },
                    {
                        Id = "SETTING_CLOTHING",
                        Type = "STEPPER",
                        Label = "Clothing",
                        Data = {
                            ItemDescription = "Toggle character creation clothing.",
                            StepperOptions = {
                                [CLOTHING_SETTING.DEFAULT] = "Default",
                                [CLOTHING_SETTING.HATLESS] = "Hatless",
                                [CLOTHING_SETTING.TOPLESS] = "Topless",
                                [CLOTHING_SETTING.NUDE]    = "Nude"
                            },
                            StepperValue = self.settingClothing or CLOTHING_SETTING.DEFAULT,
                            StepperVisible = true,
                        },
                        Prompts = {
                            Adjust = {
                                Action = function(event)
                                    local value = event.Data.StepperValue or CLOTHING_SETTING.DEFAULT
                                    Intro:SetClothingLevel(value)
                                    self.settingClothing = value
                                end,
                            },
                        },
                    },
                    {
                        Id = "SETTING_ANIMATIONS",
                        Type = "STEPPER",
                        Label = "Animations",
                        Data = {
                            ItemDescription = "Toggle character creation animations.",
                            StepperOptions = {
                                [ANIMATION_SETTING.DEFAULT]  = "Default",
                                [ANIMATION_SETTING.REDUCED]  = "Reduced",
                                [ANIMATION_SETTING.DISABLED] = "Disabled"
                            },
                            StepperValue = self.settingAnimations or ANIMATION_SETTING.DEFAULT,
                            StepperVisible = true,
                        },
                        Prompts = {
                            Adjust = {
                                Action = function(event)
                                    local value = event.Data.StepperValue or ANIMATION_SETTING.DEFAULT
                                    Intro:SetAnimationLevel(value)
                                    self.settingAnimations = value
                                    self:Refresh()
                                end,
                            },
                        },
                    },
                    {
                        Id = "SETTING_ROTATION",
                        Type = "STEPPER",
                        Label = "Rotation",
                        Disabled = self.settingAnimations == ANIMATION_SETTING.DISABLED,
                        Data = {
                            DisabledFooter = "~e~Animations are disabled.",
                            ItemDescription = "Toggles whether character rotation is animated or smooth.",
                            StepperOptions = {
                                [ROTATION_SETTING.ANIMATED] = "Animated",
                                [ROTATION_SETTING.SMOOTH]   = "Smooth"
                            },
                            StepperValue = self.settingRotation or ROTATION_SETTING.ANIMATED,
                            StepperVisible = true,
                        },
                        Prompts = {
                            Adjust = {
                                Action = function(event)
                                    local value = event.Data.StepperValue or ROTATION_SETTING.ANIMATED
                                    Intro:SetRotationLevel(value)
                                    self.settingRotation = value
                                end,
                            },
                        },
                    },
                    {
                        Id = "SETTING_HERITAGE_LIMITS",
                        Type = "STEPPER",
                        Label = "Heritage Limits",
                        Footer = "~COLOR_YELLOW~This may cause the character to change.",
                        Data = {
                            ItemDescription = "Toggles whether heritage Fine Tune limits are ignored.",
                            StepperOptions = {
                                "Enabled",
                                "Disabled",
                            },
                            StepperValue = self.settingHeritageLimits or 1,
                            StepperVisible = true,
                        },
                        Prompts = {
                            Adjust = {
                                Action = function(event)
                                    local value = event.Data.StepperValue or 1
                                    Character.ignoreHeritageLimits = value == 2
                                    Character:ApplyAll()
                                    self.settingHeritageLimits = value
                                end,
                            },
                        },
                    },
                    {
                        Id = "SETTING_OVERLAY_LIMITS",
                        Type = "STEPPER",
                        Label = "Overlay Limits",
                        Footer = "~COLOR_YELLOW~This may cause the character to change.",
                        Data = {
                            ItemDescription = "Toggles whether overlay opacity limits are ignored.",
                            StepperOptions = {
                                "Enabled",
                                "Disabled",
                            },
                            StepperValue = self.settingOverlayLimits or 1,
                            StepperVisible = true,
                        },
                        Prompts = {
                            Adjust = {
                                Action = function(event)
                                    local value = event.Data.StepperValue or 1
                                    Character.ignoreOverlayLimits = value == 2
                                    Character:ApplyAll()
                                    self.settingOverlayLimits = value
                                end,
                            },
                        },
                    },
                    {
                        Id = "SETTING_EXPORT",
                        Type = "TEXT",
                        Label = "Export Character",
                        Disabled = not rerolling and not hasName,
                        Data = {
                            DisabledFooter = "~e~Set a name first.",
                            ItemDescription = "Export your character's appearance data to your clipboard.",
                        },
                        Prompts = {
                            Select = {
                                Action = function()
                                    local data = Character:Export()
                                    SendNUIMessage({
                                        type = "copy",
                                        text = json.encode(data, { indent = true })
                                    })
                                end,
                            },
                        },
                    }
                }
            },
            {
                Id = "ACTION_CONFIRM",
                Type = "TEXT",
                Label = "Confirm",
                Disabled = not rerolling and (not hasName or not hasCreated),
                Data = {
                    DisabledFooter = "~e~Create a character first.",
                    ItemDescription = confirmDescription,
                    ItemInfo1 = nameDisplay,
                },
                Action = function()
                    self:Close()
                    Creator:Finish(true)
                end,
            },
        },
    }
end

ShopApi.RegisterDynamic(MENU_ID, function()
    return CreatorMenu:GetMenu()
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    CreatorMenu:Close()
    ClearTimecycleModifier()
end)

AddEventHandler("native_shop:closing", function(menu)
    if menu == SETTINGS_ID then
        local mode = Creator:GetMode()
        Creator:OpenEditor(mode, true)
    elseif menu == MENU_ID then
        Creator:Finish(false)
    end
end)
