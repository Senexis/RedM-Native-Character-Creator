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
    local shouldUse24 = Citizen.InvokeNative(Natives.ShouldUse24HourClock) == 1

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
    local hasName = Character.name and Character.name ~= ""
    local rerolling = self.rerolling or false
    local hasCreated = self.created or false

    local presetRandomized = false
    if Creator.config == EDITOR_CONFIG.MALE and Intro:IsFlagSet(INTRO_FLAG.MALE_PED_RANDOMIZED) then
        presetRandomized = true
    elseif Creator.config == EDITOR_CONFIG.FEMALE and Intro:IsFlagSet(INTRO_FLAG.FEMALE_PED_RANDOMIZED) then
        presetRandomized = true
    end

    local nameDisplay = {
        Visible = hasName,
        Text = Character.name,
        Centered = true,
        IconVisible = true,
        IconTextureDictionary = "blips_mp",
        IconTexture = "blip_ambient_vip",
    }

    local defaultLabel = rerolling and "Edit Character" or "Create Character"
    local defaultDescription = rerolling and "Make changes to your character's appearance." or "Create a new character to play as. If you like the starting appearance, you may choose to skip."
    local exitLabel = rerolling and "Exit" or "Back"

    local confirmDisabled = rerolling and "~e~You have not made changes to your character." or "~e~Create a character first."
    if not hasName then
        confirmDisabled = "~e~Name your character first."
    end

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
                Footer = "Press ~INPUT_GAME_MENU_RS~ to import a character.",
                Data = {
                    ItemDescription = "Name your character. You may choose a randomized name to get inspired.",
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
                            Character:RandomizeName()
                            self:Refresh()
                        end,
                    },
                    Info = {
                        Label = "Import",
                        Action = function()
                            Creator:Import()
                        end,
                    }
                },
            },
            {
                Id = "ACTION_DEFAULT",
                Type = "TEXT",
                Label = defaultLabel,
                Disabled = not hasName,
                Footer = "Hold ~INPUT_GAME_MENU_LS~ in the Creator to switch modes.",
                Data = {
                    DisabledFooter = "~e~Name your character first.",
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
                Label = "Advanced Options",
                Disabled = not hasName,
                Footer = "Hold ~INPUT_GAME_MENU_LS~ in the Creator to switch modes.",
                Data = {
                    DisabledFooter = "~e~Name your character first.",
                    ItemDescription = "Make various advanced adjustments to your character to fine-tune their appearance.",
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
                Scene = "ITEM_LIST_DESCRIPTION",
                Title = "SETTINGS",
                Subtitle = "Creator Settings",
                Footer = "Hold ~INPUT_GAME_MENU_TAB_LEFT_SECONDARY~ in the Creator to access settings.",
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
                                [CHARACTER_CLOTHING_LEVEL.DEFAULT] = "Default",
                                [CHARACTER_CLOTHING_LEVEL.HATLESS] = "Hatless",
                                [CHARACTER_CLOTHING_LEVEL.TOPLESS] = "Topless",
                                [CHARACTER_CLOTHING_LEVEL.NUDE]    = "Nude"
                            },
                            StepperValue = self.settingClothing or CHARACTER_CLOTHING_LEVEL.DEFAULT,
                            StepperVisible = true,
                        },
                        Prompts = {
                            Adjust = {
                                Action = function(event)
                                    local value = event.Data.StepperValue or CHARACTER_CLOTHING_LEVEL.DEFAULT
                                    Character:ApplyClothingLevel(value, false, true)
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
                }
            },
            {
                Id = "ACTION_CONFIRM",
                Type = "TEXT",
                Label = "Confirm",
                Disabled = not hasName or not hasCreated,
                Footer = "Press ~INPUT_GAME_MENU_RS~ to export your character.",
                Data = {
                    DisabledFooter = confirmDisabled,
                    ItemDescription = "Take a picture of your character and confirm your appearance.",
                    ItemInfo1 = nameDisplay,
                },
                Prompts = {
                    Select = {
                        Action = function()
                            self:Close()
                            Creator:Finish(true)
                        end,
                    },
                    Info = {
                        Label = "Export",
                        Action = function()
                            Intro:ExportCharacter()
                        end,
                    }
                },
            },
        },
    }
end

SignalBus:on("character_pasted", function()
    CreatorMenu.created = true
    CreatorMenu:Refresh()
end)

ShopApi.RegisterDynamic(MENU_ID, function()
    return CreatorMenu:GetMenu()
end)

AddEventHandler("native_shop:closing", function(menu)
    if menu == SETTINGS_ID then
        local mode = Creator:GetMode()
        Creator:OpenEditor(mode, true)
    elseif menu == MENU_ID then
        Creator:Finish(false)
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    CreatorMenu:Close()
    ClearTimecycleModifier()
end)
