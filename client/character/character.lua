local function GetDefaultData()
    return {
        -- Private
        _flags = 0,
        _ped = 0,

        -- Exported
        name = "",
        age = CreatorConfig.MinAge or 18,
        height = CreatorConfig.DefaultHeight or 2,
        weight = CreatorConfig.DefaultWeight or 10,
        weariness = CreatorConfig.MinWeariness or 0.0,
        voice = 0,

        whistleStyle = 0,
        whistlePitch = 50,
        whistleClarity = 50,

        heritage = 0,
        skintone = 0,
        bodyType = 0,
        eyeColor = 0,
        teeth = 0,

        headDrawable = 0,
        headAlbedo = 0,
        headNormal = 0,
        headMaterial = 0,

        hair = 0,
        hairColor = 0,
        beard = 0,
        beardColor = 0,

        ignoreHeritageLimits = false,
        ignoreOverlayLimits = false,

        presets = {
            [PED_EXPRESSION_ZONE.EYES]      = 0,
            [PED_EXPRESSION_ZONE.NOSE]      = 0,
            [PED_EXPRESSION_ZONE.MOUTH]     = 0,
            [PED_EXPRESSION_ZONE.JAW]       = 0,
            [PED_EXPRESSION_ZONE.EARS]      = 0,
            [PED_EXPRESSION_ZONE.CHEEKS]    = 0,

            -- Advanced
            [PED_EXPRESSION_ZONE.SHOULDERS] = 0,
            [PED_EXPRESSION_ZONE.LIMBS]     = 0,
            [PED_EXPRESSION_ZONE.MOUTH_2]   = 0,
            [PED_EXPRESSION_ZONE.TORSO]     = 0,
            [PED_EXPRESSION_ZONE.FACE]      = 0,
            [PED_EXPRESSION_ZONE.NECK]      = 0,
        },

        expressions = {
            [PED_EXPRESSION.BROW_WIDTH]          = 0.5,
            [PED_EXPRESSION.BROW_HEIGHT]         = 0.5,
            [PED_EXPRESSION.BROW_DEPTH]          = 0.5,
            [PED_EXPRESSION.EYE_WIDTH]           = 0.5,
            [PED_EXPRESSION.EYE_HEIGHT]          = 0.5,
            [PED_EXPRESSION.EYE_ANGLE]           = 0.5,
            [PED_EXPRESSION.EYE_DEPTH]           = 0.5,
            [PED_EXPRESSION.EYE_H_POS]           = 0.5,
            [PED_EXPRESSION.EYE_V_POS]           = 0.5,
            [PED_EXPRESSION.NOSE_WIDTH]          = 0.5,
            [PED_EXPRESSION.NOSE_HEIGHT]         = 0.5,
            [PED_EXPRESSION.NOSE_BREAK]          = 0.5,
            [PED_EXPRESSION.NOSE_LENGTH]         = 0.5,
            [PED_EXPRESSION.NOSTRIL_WIDTH]       = 0.5,
            [PED_EXPRESSION.NOSE_TILT]           = 0.5,
            [PED_EXPRESSION.MOUTH_WIDTH]         = 0.5,
            [PED_EXPRESSION.MOUTH_DEPTH]         = 0.5,
            [PED_EXPRESSION.MOUTH_V_POS]         = 0.5,
            [PED_EXPRESSION.UPPER_LIP_WIDTH]     = 0.5,
            [PED_EXPRESSION.UPPER_LIP_THICKNESS] = 0.5,
            [PED_EXPRESSION.LOWER_LIP_WIDTH]     = 0.5,
            [PED_EXPRESSION.LOWER_LIP_THICKNESS] = 0.5,
            [PED_EXPRESSION.UPPER_LIPDEPTH]      = 0.5,
            [PED_EXPRESSION.LOWER_LIP_DEPTH]     = 0.5,
            [PED_EXPRESSION.JAW_WIDTH]           = 0.5,
            [PED_EXPRESSION.JAW_HEIGHT]          = 0.5,
            [PED_EXPRESSION.JAW_DEPTH]           = 0.5,
            [PED_EXPRESSION.CHIN_WIDTH]          = 0.5,
            [PED_EXPRESSION.CHIN_TILT]           = 0.5,
            [PED_EXPRESSION.CHIN_DEPTH]          = 0.5,
            [PED_EXPRESSION.EAR_ROTATION]        = 0.5,
            [PED_EXPRESSION.EAR_LENGTH]          = 0.5,
            [PED_EXPRESSION.EAR_SIZE]            = 0.5,
            [PED_EXPRESSION.EAR_LOBE]            = 0.5,
            [PED_EXPRESSION.CHEEKS_WIDTH]        = 0.5,
            [PED_EXPRESSION.CHEEKS_HEIGHT]       = 0.5,
            [PED_EXPRESSION.CHEEKS_DEPTH]        = 0.5,

            -- Advanced
            [PED_EXPRESSION.SHOULDERS_WIDTH]     = 0.5,
            [PED_EXPRESSION.SHOULDERS_DEPTH]     = 0.5,
            [PED_EXPRESSION.SHOULDERS_HEIGHT]    = 0.5,
            [PED_EXPRESSION.CHEST_WIDTH]         = 0.5,
            [PED_EXPRESSION.CHEST_DEPTH]         = 0.5,
            [PED_EXPRESSION.BELLY_WIDTH]         = 0.5,
            [PED_EXPRESSION.BELLY_DEPTH]         = 0.5,
            [PED_EXPRESSION.LATS]                = 0.5,
            [PED_EXPRESSION.TRAPS]               = 0.5,
            [PED_EXPRESSION.UPPER_ARMS]          = 0.5,
            [PED_EXPRESSION.FOREARMS]            = 0.5,
            [PED_EXPRESSION.UPPER_LEGS]          = 0.5,
            [PED_EXPRESSION.LOWER_LEGS]          = 0.5,
            [PED_EXPRESSION.NECK_WIDTH]          = 0.5,
            [PED_EXPRESSION.NECK_DEPTH]          = 0.5,
            [PED_EXPRESSION.MOUTHCRN_L_WIDTH]    = 0.5,
            [PED_EXPRESSION.MOUTHCRN_R_WIDTH]    = 0.5,
            [PED_EXPRESSION.MOUTH_H_POS]         = 0.5,
            [PED_EXPRESSION.MOUTHCRN_L_DEPTH]    = 0.5,
            [PED_EXPRESSION.MOUTHCRN_R_DEPTH]    = 0.5,
            [PED_EXPRESSION.MOUTHCRN_L_HEIGHT]   = 0.5,
            [PED_EXPRESSION.MOUTHCRN_R_HEIGHT]   = 0.5,
            [PED_EXPRESSION.MOUTHCRN_L_LIP_DIST] = 0.5,
            [PED_EXPRESSION.MOUTHCRN_R_LIP_DIST] = 0.5,
            [PED_EXPRESSION.FACE_WIDTH]          = 0.5,
            [PED_EXPRESSION.CHEEKS_FULLNESS]     = 0.5,
            [PED_EXPRESSION.GLUTES]              = 0.5,
            [PED_EXPRESSION.EYELID_L_POS]        = 0.5,
            [PED_EXPRESSION.EYELID_R_POS]        = 0.5,
            [PED_EXPRESSION.CHEST_SAG]           = 0.5,
        },

        layers = {
            [OVERLAY_LAYER.SKIN_MOTTLING] = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.AGEING]        = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.COMPLEXION]    = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.COMPLEXION_2]  = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.FRECKLES]      = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.MOLES]         = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.SPOTS]         = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.SCAR]          = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.FOUNDATION]    = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.BLUSHER]       = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.EYELINER]      = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.EYESHADOW]     = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.LIPSTICK]      = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.EYEBROWS]      = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.FACIAL_HAIR]   = { id = 0, alpha = 1.0 },

            -- Advanced
            [OVERLAY_LAYER.GRIME]         = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.HEAD_HAIR]     = { id = 0, alpha = 1.0 },
            [OVERLAY_LAYER.SCAR_2]        = { id = 0, alpha = 1.0 },
        },

        layerColors = {
            [OVERLAY_LAYER.EYESHADOW] = 0,
            [OVERLAY_LAYER.LIPSTICK]  = 0,
        }
    }
end

local defaults = GetDefaultData()
Character = setmetatable({}, { __index = defaults })

function Character:Reset()
    defaults = GetDefaultData()

    for k, v in pairs(defaults) do
        if type(v) ~= "function" then
            self[k] = v
        end
    end
end

function Character:ImportRaw(data)
    for k, v in pairs(data) do
        if self[k] ~= nil then
            if type(v) == "table" then
                self[k] = Utils:CopyData(v)
            else
                self[k] = v
            end
        end
    end
end

function Character:Import(data)
    if type(data) ~= "table" then
        Utils:Warn("Failed to import character data, expected table but got", type(data))
        return
    end

    local MAPPER <const> = {
        ["ignoreHeritageLimits"] = true,
        ["ignoreOverlayLimits"] = true,
        ["name"] = self.ApplyName,
        ["age"] = self.ApplyAgeAlpha,
        ["height"] = self.ApplyHeight,
        ["weight"] = self.ApplyWeight,
        ["weariness"] = self.ApplyWeariness,
        ["voice"] = self.ApplyVoice,
        ["whistleStyle"] = self.ApplyWhistleStyle,
        ["whistlePitch"] = self.ApplyWhistlePitch,
        ["whistleClarity"] = self.ApplyWhistleClarity,
        ["heritage"] = self.ApplyHeritage,
        ["skintone"] = self.ApplySkintone,
        ["bodyType"] = self.ApplyBody,
        ["eyeColor"] = self.ApplyEyeColor,
        ["teeth"] = self.ApplyTeeth,
        ["headDrawable"] = self.ApplyHeadDrawable,
        ["headAlbedo"] = self.ApplyHeadAlbedo,
        ["headNormal"] = self.ApplyHeadNormal,
        ["headMaterial"] = self.ApplyHeadMaterial,
        ["hair"] = self.ApplyHairStyle,
        ["hairColor"] = self.ApplyHairColor,
        ["beard"] = self.ApplyBeardStyle,
        ["beardColor"] = self.ApplyBeardColor,
        ["presets"] = true,
        ["expressions"] = true,
        ["layers"] = true,
        ["layerColors"] = true,
    }

    for key, _ in pairs(data) do
        if not MAPPER[key] then
            Utils:Warn("Unknown character data key", tostring(key), "skipping...")
        end
    end

    for key, func in pairs(MAPPER) do
        local value = data[key]
        Utils:Debug("Applying character data for key", tostring(key), "with value", type(value), tostring(value))

        if key == "ignoreHeritageLimits" then
            self.ignoreHeritageLimits = (value == true)
            if self.ignoreHeritageLimits then
                Utils:Warn("Ignore heritage limits enabled, proceeding without restrictions")
            end
        elseif key == "ignoreOverlayLimits" then
            self.ignoreOverlayLimits = (value == true)
            if self.ignoreOverlayLimits then
                Utils:Warn("Ignore overlay limits enabled, proceeding without restrictions")
            end
        elseif key == "presets" then
            if type(value) == "table" then
                for presetKey, presetValue in pairs(value) do
                    local presetKeyNum = tonumber(presetKey)
                    local presetValNum = tonumber(presetValue)

                    if presetKeyNum and presetValNum then
                        presetValNum = math.max(0, presetValNum)
                        Utils:Debug("Applying preset for zone", PED_EXPRESSION_ZONE:ToString(presetKeyNum), "with value", tostring(presetValNum))
                        self:ApplyPreset(presetKeyNum, presetValNum)
                    else
                        Utils:Warn("Invalid preset for zone", tostring(presetKey), "with value", tostring(presetValue))
                    end
                end
            else
                Utils:Warn("Invalid presets format. Expected a table, got", type(value))
            end
        elseif key == "expressions" then
            if type(value) == "table" then
                for expressionKey, expressionVal in pairs(value) do
                    local expressionKeyNum = tonumber(expressionKey)
                    local expressionValNum = tonumber(expressionVal)

                    if expressionKeyNum and expressionValNum then
                        expressionValNum = math.min(1.0, math.max(-1.0, expressionValNum))
                        Utils:Debug("Applying expression", PED_EXPRESSION:ToString(expressionKeyNum), "with value", tostring(expressionValNum))
                        self:ApplyExpressionValue(expressionKeyNum, expressionValNum)
                    else
                        Utils:Warn("Invalid expression for expression", tostring(expressionKey), "with value", tostring(expressionVal))
                    end
                end
            else
                Utils:Warn("Invalid expressions format. Expected a table, got", type(value))
            end
        elseif key == "layers" then
            if type(value) == "table" then
                for layerKey, layerValue in pairs(value) do
                    local layerKeyNum = tonumber(layerKey)

                    if layerKeyNum then
                        local isTable = type(layerValue) == "table"
                        local id = (isTable and tonumber(layerValue.id)) or 0
                        local alpha = (isTable and tonumber(layerValue.alpha)) or 1.0

                        id = math.max(0, id)
                        alpha = math.min(1.0, math.max(0.0, alpha))

                        Utils:Debug("Applying layer", OVERLAY_LAYER:ToString(layerKeyNum), "with id", id, "alpha", alpha)
                        self:ApplyOverlayBlend(layerKeyNum, id)
                        self:ApplyOverlayAlpha(layerKeyNum, alpha)
                    else
                        Utils:Warn("Invalid layer key", tostring(layerKey), "with value", tostring(layerValue))
                    end
                end
            else
                Utils:Warn("Invalid layers format. Expected a table, got", type(value))
            end
        elseif key == "layerColors" then
            if type(value) == "table" then
                for layerKey, layerVal in pairs(value) do
                    local layerKeyNum = tonumber(layerKey)
                    local layerValNum = tonumber(layerVal) or 0

                    if layerKeyNum then
                        layerValNum = math.max(0, layerValNum)
                        Utils:Debug("Applying layer color for layer", OVERLAY_LAYER:ToString(layerKeyNum), "with value", tostring(layerValNum))
                        self:ApplyOverlayColor(layerKeyNum, layerValNum)
                    else
                        Utils:Warn("Invalid layer key for color", tostring(layerKey), "with value", tostring(layerVal))
                    end
                end
            else
                Utils:Warn("Invalid layerColors format. Expected a table, got", type(value), tostring(value))
            end
        elseif type(func) == "function" then
            func(self, value)
        else
            Utils:Warn("Missing logic for key", tostring(key), "received value", type(value), tostring(value))
        end
    end

    self:ApplyAll()
end

function Character:Export()
    local data = Utils:CopyData(defaults)
    local copy = Utils:CopyData(self, data)

    for k, _ in pairs(copy) do
        if k:sub(1, 1) == "_" then
            copy[k] = nil
        end
    end

    return copy
end

function Character:IsFlagSet(flag)
    return (self._flags & flag) ~= 0
end

function Character:SetFlag(flag)
    self._flags = self._flags | flag
end

function Character:ClearFlag(flag)
    self._flags = self._flags & ~flag
end

function Character:SetPed(ped)
    self._ped = ped or 0
end

function Character:GetPed()
    return self._ped or 0
end

function Character:SetModified()
    if self:IsFlagSet(CHARACTER_FLAG.MODIFIED) then return end
    self:SetFlag(CHARACTER_FLAG.MODIFIED)
    self:ClearFlag(CHARACTER_FLAG.RANDOMIZED)
end

function Character:IsModified()
    return self:IsFlagSet(CHARACTER_FLAG.MODIFIED)
end

function Character:ClearModified()
    self:ClearFlag(CHARACTER_FLAG.MODIFIED)
end

function Character:SetRandomized()
    if self:IsFlagSet(CHARACTER_FLAG.RANDOMIZED) then return end
    self:SetFlag(CHARACTER_FLAG.RANDOMIZED)
    self:ClearFlag(CHARACTER_FLAG.MODIFIED)
end

function Character:IsRandomized()
    return self:IsFlagSet(CHARACTER_FLAG.RANDOMIZED)
end

function Character:ClearRandomized()
    self:ClearFlag(CHARACTER_FLAG.RANDOMIZED)
end

function Character:Maintain()
    if not self:IsFlagSet(CHARACTER_FLAG.DIRTY) then
        return
    end

    local ped = self:GetPed()
    if ped == 0 or IsPedReadyToRender(ped) ~= 1 then
        return
    end

    if self:IsFlagSet(CHARACTER_FLAG.UPDATE_OVERLAYS) then
        if not CharacterOverlay:Maintain() then
            return
        end

        self:ClearFlag(CHARACTER_FLAG.UPDATE_OVERLAYS)
        self:SetFlag(CHARACTER_FLAG.UPDATE_PED)

        -- We always need to update after this, so reloop
        return
    end

    if self:IsFlagSet(CHARACTER_FLAG.UPDATE_HEIGHT) then
        self:ApplyHeight(nil, true)

        self:ClearFlag(CHARACTER_FLAG.UPDATE_HEIGHT)
    end

    if self:IsFlagSet(CHARACTER_FLAG.UPDATE_PED) then
        RefreshMetaPedShopItems(ped, 1)
        Citizen.InvokeNative(Natives.SetActiveMetaPedComponentsUpdated, ped, true)
        UpdatePedVariation(ped, false, true, true, true, false)

        self:ClearFlag(CHARACTER_FLAG.UPDATE_PED)
    end

    self:ClearFlag(CHARACTER_FLAG.DIRTY)
end

function Character:Exists()
    local ped = self:GetPed()
    if ped == 0 then return false end
    return DoesEntityExist(ped) == 1
end

function Character:IsPlayer()
    if not self:Exists() then return false end
    local ped = self:GetPed()
    return IsPedAPlayer(ped) == 1
end

function Character:IsOtherPlayer()
    if not self:IsPlayer() then return false end
    local ped = self:GetPed()
    return ped ~= PlayerPedId()
end

function Character:IsHuman()
    if not self:Exists() then return false end
    local ped = self:GetPed()
    return IsPedHuman(ped) == 1
end

function Character:IsMale()
    if not self:Exists() then return false end
    if not self:IsHuman() then return false end

    local ped = self:GetPed()

    local model = GetEntityModel(ped)
    if model == `MP_MALE` then
        return true
    elseif model == `MP_FEMALE` then
        return false
    end

    return IsPedMale(ped)
end

function Character:IsFemale()
    if not self:Exists() then return false end
    if not self:IsHuman() then return false end
    return not self:IsMale()
end

function Character:GetGenderShort()
    if self:IsMale() then
        return "M"
    elseif self:IsFemale() then
        return "F"
    else
        return "A"
    end
end

function Character:GetGenderFull()
    if self:IsMale() then
        return "MALE"
    elseif self:IsFemale() then
        return "FEMALE"
    else
        return "ANIMAL"
    end
end

function Character:GetCreatorConfig()
    if self:IsMale() then
        return EDITOR_CONFIG.MALE
    elseif self:IsFemale() then
        return EDITOR_CONFIG.FEMALE
    else
        return EDITOR_CONFIG.INVALID
    end
end

function Character:GetPedType()
    if not self:IsHuman() then
        return 3
    end

    return self:IsMale() and 0 or 1
end

function Character:GetSkintone()
    return self.skintone
end

function Character:GetHairColorString()
    local colors = CreatorConfig.HairColors
    local color = colors[self.hairColor % #colors + 1]
    return color or "GREY"
end

function Character:GetBeardColorString()
    local colors = CreatorConfig.HairColors
    local color = colors[self.beardColor % #colors + 1]
    return color or "GREY"
end

function Character:GetShopItemInfo(item)
    local pedType = self:GetPedType()

    local result, drawable, albedo, normal, material, palette, tint0, tint1, tint2 = Citizen.InvokeNative(
        Natives.GetShopItemBaseLayers,
        item,
        0,
        0,
        pedType,
        true,
        Citizen.PointerValueInt(), -- drawable
        Citizen.PointerValueInt(), -- albedo
        Citizen.PointerValueInt(), -- normal
        Citizen.PointerValueInt(), -- material
        Citizen.PointerValueInt(), -- palette
        Citizen.PointerValueInt(), -- tint0
        Citizen.PointerValueInt(), -- tint1
        Citizen.PointerValueInt(), -- tint2
        Citizen.ResultAsInteger()
    )

    if result ~= 1 then
        error(string.format("Failed to find shop item info for %s", item), 2)
    end

    return {
        drawable = drawable,
        albedo = albedo,
        normal = normal,
        material = material,
        palette = palette,
        tint0 = tint0,
        tint1 = tint1,
        tint2 = tint2,
    }
end

function Character:ApplyShopItem(item)
    local ped = self:GetPed()
    ApplyShopItemToPed(ped, item, false, true, true)

    self:RequestUpdate()
end

function Character:ApplyMetaPedOutfit(outfit)
    local ped = self:GetPed()
    EquipMetaPedOutfit(ped, outfit)

    self:RequestUpdate()
end

function Character:IsPedUsingTag(tag)
    local hash = COMPONENT_TAG:GetHash(tag)
    if not hash then
        error(string.format("No hash found for tag: %s", COMPONENT_TAG:ToString(tag)), 2)
    end

    local ped = self:GetPed()
    return Citizen.InvokeNative(Natives.IsMetaPedUsingComponentCategory, ped, hash) == 1
end

function Character:RemoveTagFromPed(tag)
    local hash = COMPONENT_TAG:GetHash(tag)
    if not hash then
        error(string.format("No hash found for tag: %s", COMPONENT_TAG:ToString(tag)), 2)
    end

    local ped = self:GetPed()
    RemoveTagFromMetaPed(ped, hash, 0)

    self:RequestUpdate()
end

function Character:RequestUpdate()
    self:SetFlag(CHARACTER_FLAG.UPDATE_PED)
    self:SetFlag(CHARACTER_FLAG.DIRTY)
end

function Character:ApplyAll()
    self:ApplyHeritage()
    self:ApplySkintone()

    self:ApplyEyeColor()
    self:ApplyTeeth()
    self:ApplyHairStyle()
    self:ApplyHairColor()
    self:ApplyBeardStyle()
    self:ApplyBeardColor()
    self:ApplyWeariness()

    self:ApplyWhistleStyle()
    self:ApplyWhistlePitch()
    self:ApplyWhistleClarity()

    -- Advanced
    self:ApplyHeight()
    self:ApplyWeight()
    self:ApplyVoice()

    self:ApplyOverlays(true)
end

function Character:ApplyName(value)
    if value ~= nil then
        self.name = value
        self:SetModified()
    end
end

function Character:GenerateName()
    local firstNames = self:IsMale() and CreatorConfig.MaleNames or CreatorConfig.FemaleNames
    if not firstNames or #firstNames == 0 then
        firstNames = self:IsMale() and { "John" } or { "Jane" }
    end

    local surnames = CreatorConfig.Surnames
    if not surnames or #surnames == 0 then
        surnames = { "Doe" }
    end

    local firstIndex = GetRandomIntInRange(1, #firstNames + 1)
    local lastIndex = GetRandomIntInRange(1, #surnames + 1)

    return firstNames[firstIndex] .. " " .. surnames[lastIndex]
end

function Character:RandomizeName()
    local name = self:GenerateName()
    self:ApplyName(name)
end

function Character:ApplyHeight(value, apply)
    if value ~= nil then
        self.height = value
        self:SetModified()
    end

    local heights = CreatorConfig.Heights
    local normalized = self.height % #heights
    local height = heights[normalized + 1]

    if self.height ~= normalized then
        self.height = normalized
    end

    if apply then
        local ped = self:GetPed()
        SetPedScale(ped, height.value)
    else
        self:SetFlag(CHARACTER_FLAG.UPDATE_HEIGHT)
        self:SetFlag(CHARACTER_FLAG.DIRTY)
    end
end

function Character:ApplyWeight(value)
    if value ~= nil then
        self.weight = value
        self:SetModified()
    end

    local weights = CreatorConfig.Weights
    local normalized = self.weight % #weights
    local weight = weights[normalized + 1]

    if self.weight ~= normalized then
        self.weight = normalized
    end

    self:ApplyMetaPedOutfit(weight.value)
end

function Character:ApplyVoice(value)
    if value ~= nil then
        self.voice = value
        self:SetModified()
    end

    local voices = CreatorConfig.Voices
    local normalized = self.voice % #voices
    local voice = voices[normalized + 1]

    if self.voice ~= normalized then
        self.voice = normalized
    end

    local gender = self:GetGenderFull()
    local item = string.format("VOFX_PLAYER_%s%02d", gender, voice.value)

    local ped = self:GetPed()
    SetVofxPedVoice(ped, item)

    self:RequestUpdate()
end

function Character:ApplyWeariness(value)
    if value ~= nil then
        self.weariness = value
        self:SetModified()
    end

    local min = CreatorConfig.MinWeariness or 0.0
    local max = CreatorConfig.MaxWeariness or 0.5
    local result = min + (self.weariness * (max - min))

    local ped = self:GetPed()
    SetMetaPedWeariness(ped, result)
end

function Character:GetExpressionGameBounds(expressionId)
    local min, max = -1.0, 1.0

    -- Fill the limits from the heritage
    local data = CreatorPresets:GetFineTuningData()
    local tuning = data[expressionId]

    -- Apply the fine tuning limits if available and desired or not overridable
    if tuning and (not tuning.overridable or not self.ignoreHeritageLimits) then
        min = tuning.min or min
        max = tuning.max or max
    end

    -- Swap bounds if the expression is flagged as reversed
    if PED_EXPRESSION:GetReversed(expressionId) then
        return max, min
    end

    return min, max
end

function Character:ExpressionUiToGameValue(expressionId, uiValue)
    local min, max = self:GetExpressionGameBounds(expressionId)
    local projected = min + (uiValue * (max - min))

    -- Clamp the result within the bounds (handles reversed min/max)
    local lower, upper = math.min(min, max), math.max(min, max)
    return math.max(lower, math.min(upper, projected))
end

function Character:ExpressionGameToUiValue(expressionId, gameValue)
    local min, max = self:GetExpressionGameBounds(expressionId)
    local range = max - min

    if math.abs(range) < 1e-5 then return 0.0 end

    local uiValue = (gameValue - min) / range
    return math.max(0.0, math.min(1.0, uiValue))
end

function Character:GetExpressionUiValue(expressionId)
    return self.expressions[expressionId] or 0.5
end

function Character:ApplyExpressionValue(expressionId, uiValue, update)
    if uiValue then
        if uiValue < 0.0 then uiValue = 0.0 end
        if uiValue > 1.0 then uiValue = 1.0 end
        uiValue = math.floor(uiValue * 10000 + 0.5) / 10000

        self.expressions[expressionId] = uiValue
        self:SetModified()
    end

    local currentUiValue = self.expressions[expressionId] or 0.5
    local gameValue = self:ExpressionUiToGameValue(expressionId, currentUiValue)

    self:SetExpression(expressionId, gameValue, update)
end

function Character:ApplyAllExpressions()
    local expressions = PED_EXPRESSION:Values()
    for _, expressionId in pairs(expressions) do
        self:ApplyExpressionValue(expressionId, nil, false)
    end

    self:RequestUpdate()
end

function Character:ApplyExpressionZonePreset(zone)
    local expressions = PED_EXPRESSION_ZONE:GetExpressions(zone) or {}

    local presetIndex = self.presets[zone] or 0
    local presetValues = CreatorPresets:GetExpressionZoneData(zone, presetIndex)

    for _, expressionId in ipairs(expressions) do
        local presetValue = presetValues[expressionId]

        if presetValue ~= nil then
            local uiValue = self:ExpressionGameToUiValue(expressionId, presetValue)
            self:ApplyExpressionValue(expressionId, uiValue, false)
        else
            self:ApplyExpressionValue(expressionId, nil, false)
        end
    end

    self:RequestUpdate()
end

function Character:SetExpression(expressionId, gameValue, update)
    local ped = self:GetPed()

    Citizen.InvokeNative(Natives.SetCharExpression, ped, expressionId, gameValue)

    if update then
        self:RequestUpdate()
    end
end

function Character:GetHeadShopItem()
    return CreatorPresets:GetHeadShopItemForSkintone(self.skintone)
end

function Character:RemoveHead(skipEvent)
    if not skipEvent then SignalBus:emit("head_removed") end
    self:RemoveTagFromPed(COMPONENT_TAG.HEADS)
end

function Character:ApplyHeadDrawable(value, apply)
    if value ~= nil then
        self.headDrawable = value
        self:SetModified()
    end

    if apply then self:ApplyHead(true) end
end

function Character:ApplyHeadAlbedo(value, apply)
    if value ~= nil then
        self.headAlbedo = value
        self:SetModified()
    end

    if apply then self:ApplyHead(true) end
end

function Character:ApplyHeadNormal(value, apply)
    if value ~= nil then
        self.headNormal = value
        self:SetModified()
    end

    if apply then self:ApplyHead(true) end
end

function Character:ApplyHeadMaterial(value, apply)
    if value ~= nil then
        self.headMaterial = value
        self:SetModified()
    end

    if apply then self:ApplyHead(true) end
end

function Character:ApplyHead(apply)
    local head = self:GetHeadShopItem()
    if not head then return end

    local info = self:GetShopItemInfo(head.id)
    local shouldOverride = false

    local drawable = info.drawable or 0
    if self.headDrawable > 0 then
        local drawables = self:IsMale() and CreatorConfig.CustomMaleHeadDrawables or CreatorConfig.CustomFemaleHeadDrawables
        if not drawables then drawables = {} end

        local normalized = (self.headDrawable - 1) % #drawables
        local customDrawable = drawables[normalized + 1]

        if self.headDrawable ~= (normalized + 1) then
            self.headDrawable = (normalized + 1)
        end

        if customDrawable.value then
            drawable = joaat(customDrawable.value)
            shouldOverride = true
        end
    end

    local albedo = info.albedo or 0
    if self.headAlbedo > 0 then
        local albedos = self:IsMale() and CreatorConfig.CustomMaleHeadAlbedos or CreatorConfig.CustomFemaleHeadAlbedos
        if not albedos then albedos = {} end

        local skintoneAlbedos = albedos[head.skintone + 1] or {}
        local normalized = (self.headAlbedo - 1) % #skintoneAlbedos
        local customAlbedo = skintoneAlbedos[normalized + 1]

        if self.headAlbedo ~= (normalized + 1) then
            self.headAlbedo = (normalized + 1)
        end

        if customAlbedo.value then
            albedo = joaat(customAlbedo.value)
            shouldOverride = true
        end
    end

    local normal = info.normal or 0
    if self.headNormal > 0 then
        local normals = self:IsMale() and CreatorConfig.CustomMaleHeadNormals or CreatorConfig.CustomFemaleHeadNormals
        if not normals then normals = {} end

        local normalized = (self.headNormal - 1) % #normals
        local customNormal = normals[normalized + 1]

        if self.headNormal ~= (normalized + 1) then
            self.headNormal = (normalized + 1)
        end

        if customNormal.value then
            normal = joaat(customNormal.value)
            shouldOverride = true
        end
    end

    local material = info.material or 0
    if self.headMaterial > 0 then
        local materials = self:IsMale() and CreatorConfig.CustomMaleHeadMaterials or CreatorConfig.CustomFemaleHeadMaterials
        if not materials then materials = {} end

        local normalized = (self.headMaterial - 1) % #materials
        local customMaterial = materials[normalized + 1]

        if self.headMaterial ~= (normalized + 1) then
            self.headMaterial = (normalized + 1)
        end

        if customMaterial.value then
            material = joaat(customMaterial.value)
            shouldOverride = true
        end
    end

    CharacterOverlay:SetBaseLayer(albedo, normal, material, apply)

    if not shouldOverride then
        self:ApplyShopItem(head.id)
        return
    end

    self:RemoveHead(true)

    local ped = self:GetPed()
    SetMetaPedTag(ped, drawable, albedo, normal, material, "METAPED_TINT_GENERIC", 0, 0, 0)

    self:RequestUpdate()
end

function Character:WearingCustomHead()
    return self.headDrawable > 0
end

function Character:ApplyAgeBlend(apply)
    local ages = CreatorConfig.Overlays[OVERLAY_LAYER.AGEING]
    local normalized = self.heritage % #ages
    self:ApplyOverlayBlend(OVERLAY_LAYER.AGEING, normalized + 1, apply)
end

function Character:ApplyAgeAlpha(value, apply)
    if value ~= nil then
        self.age = value
        self:SetModified()
    end

    local minAge = CreatorConfig.MinAge or 18
    local maxAge = CreatorConfig.MaxAge or 60

    local alpha = (self.age - minAge) / (maxAge - minAge)
    alpha = math.floor(alpha * 10000 + 0.5) / 10000
    if alpha < 0.0001 then alpha = 0.0001 end
    if alpha > 1.0 then alpha = 1.0 end

    self:ApplyOverlayAlpha(OVERLAY_LAYER.AGEING, alpha, apply)
end

function Character:ApplySkintone(value, apply)
    if value ~= nil then
        self.skintone = value
        self:SetModified()
    end

    self:ApplyHead(apply)
    self:ApplyBodyItems()

    SignalBus:emit("skintone_changed", value)
end

function Character:GetBodyBuild()
    local bodyBuilds = self:IsMale() and CreatorConfig.MaleBodyBuilds or CreatorConfig.FemaleBodyBuilds
    local normalized = self.bodyType % #bodyBuilds
    local bodyBuild = bodyBuilds[normalized + 1]

    if self.bodyType ~= normalized then
        self.bodyType = normalized
    end

    return bodyBuild.build or CHARACTER_BODY_BUILD.NEUTRAL
end

function Character:ApplyBody(value)
    self:ApplyBodyItems(value)
    self:ApplyBodyExpressions(value)
end

function Character:ApplyBodyItems(value)
    if value ~= nil then
        self.bodyType = value
        self:SetModified()
    end

    local bodyBuild = self:GetBodyBuild()
    local presetBodyBuild = CreatorPresets:GetBodyBuild(bodyBuild)
    local shopItems = CreatorPresets:GetBodyShopItems(self.skintone, presetBodyBuild)

    self:ApplyShopItem(shopItems.upper)
    self:ApplyShopItem(shopItems.lower)

    self:RequestUpdate()
end

function Character:ApplyBodyExpressions(value)
    if value ~= nil then
        self.bodyType = value
        self:SetModified()
    end

    local bodyBuilds = self:IsMale() and CreatorConfig.MaleBodyBuilds or CreatorConfig.FemaleBodyBuilds
    local normalized = self.bodyType % #bodyBuilds
    local bodyBuild = bodyBuilds[normalized + 1]

    if self.bodyType ~= normalized then
        self.bodyType = normalized
    end

    for presetKey, presetValue in pairs(bodyBuild.presets) do
        self:ApplyPreset(presetKey, presetValue)
    end
end

function Character:ApplyEyeColor(value)
    if value ~= nil then
        self.eyeColor = value
        self:SetModified()
    end

    local colors = CreatorConfig.Eyes
    local normalized = self.eyeColor % #colors
    local color = colors[normalized + 1]

    if self.eyeColor ~= normalized then
        self.eyeColor = normalized
    end

    local gender = self:GetGenderShort()
    local eyes = string.format("CLOTHING_ITEM_%s_EYES_001_TINT_%03d", gender, color)

    self:ApplyShopItem(eyes)
end

function Character:ApplyTeeth(value)
    if value ~= nil then
        self.teeth = value
        self:SetModified()
    end

    local teeth = CreatorConfig.Teeth
    local normalized = self.teeth % #teeth
    local teethItem = teeth[normalized + 1]

    if self.teeth ~= normalized then
        self.teeth = normalized
    end

    local gender = self:GetGenderShort()
    local key = string.format("CLOTHING_ITEM_%s_TEETH_%03d", gender, teethItem)

    self:ApplyShopItem(key)
end

function Character:ApplyHairStyle(value)
    if value ~= nil then
        self.hair = value
        self:SetModified()
    end

    self:ApplyHair()
end

function Character:ApplyHairColor(value, apply)
    if value ~= nil then
        self.hairColor = value
        self:SetModified()
    end

    self:ApplyHair()
    self:ApplyOverlayBlend(OVERLAY_LAYER.EYEBROWS, nil, false)
    self:ApplyOverlayBlend(OVERLAY_LAYER.HEAD_HAIR, nil, false)

    if apply then
        CharacterOverlay:RequestUpdate()
    end
end

function Character:WearingHair()
    return self:IsPedUsingTag(COMPONENT_TAG.HAIR)
end

function Character:RemoveHair(skipEvent)
    if not skipEvent then SignalBus:emit("hair_removed") end
    self:RemoveTagFromPed(COMPONENT_TAG.MISC)
    self:RemoveTagFromPed(COMPONENT_TAG.HAIR)
    self:RemoveTagFromPed(COMPONENT_TAG.HAIR_ACCESSORIES)
end

function Character:ApplyHair()
    local colors = CreatorConfig.HairColors
    local normalizedColor = self.hairColor % #colors
    local color = colors[normalizedColor + 1]

    if self.hairColor ~= normalizedColor then
        self.hairColor = normalizedColor
    end

    local gender = self:GetGenderShort()

    local hairs = self:IsMale() and CreatorConfig.MaleHairs or CreatorConfig.FemaleHairs
    local custom = self:IsMale() and CreatorConfig.CustomMaleHairs or CreatorConfig.CustomFemaleHairs

    local normalizedHair = self.hair % (#hairs + #custom)
    local hair = { id = "NONE", custom = false }

    if self.hair ~= normalizedHair then
        self.hair = normalizedHair
    end

    if normalizedHair < #hairs then
        local id = hairs[normalizedHair + 1]
        if id ~= "NONE" then
            local item = string.format("CLOTHING_ITEM_%s_HAIR_%03d_%s", gender, id, color)
            hair = { id = item, custom = false }
        end
    else
        hair = custom[normalizedHair - #hairs + 1]
        hair.custom = true
    end

    if hair.id == "NONE" then
        self:RemoveHair()
        return
    end

    if hair.custom then
        self:ApplyCustomHair(hair, color)
    else
        self:ApplyShopItem(hair.id)
    end

    SignalBus:emit("hair_applied", hair)
end

function Character:ApplyCustomHair(hair, color)
    local tints = CreatorConfig.CustomHairTints[color]
    if not tints then
        error(string.format("No tints found for custom hair color: %s", color), 2)
    end

    local tint0 = tints[1] or 0
    local tint1 = tints[2] or 0
    local tint2 = tints[3] or 0

    local drawable = hair.drawable
    if not drawable then
        error(string.format("No drawable found for custom hair: %s", json.encode(hair)), 2)
    end

    local fallbacks = CreatorConfig.CustomHairFallbacks
    local albedo = hair.albedo or fallbacks.albedo or 0
    local normal = hair.normal or fallbacks.normal or 0
    local material = hair.material or fallbacks.material or 0
    local palette = hair.palette or fallbacks.palette or 0

    self:RemoveHair(true)

    local ped = self:GetPed()
    SetMetaPedTag(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)

    self:RequestUpdate()
end

function Character:ApplyBeardStyle(value)
    if self:IsFemale() then return end

    if value ~= nil then
        self.beard = value
        self:SetModified()
    end

    self:ApplyBeard()
end

function Character:ApplyBeardColor(value, apply)
    if self:IsFemale() then return end

    if value ~= nil then
        self.beardColor = value
        self:SetModified()
    end

    self:ApplyBeard()
    self:ApplyOverlayBlend(OVERLAY_LAYER.FACIAL_HAIR, nil, false)

    if apply then
        CharacterOverlay:RequestUpdate()
    end
end

function Character:WearingBeard()
    if self:IsPedUsingTag(COMPONENT_TAG.BEARDS_COMPLETE) then return true end
    if self:IsPedUsingTag(COMPONENT_TAG.BEARDS_CHOPS) then return true end
    if self:IsPedUsingTag(COMPONENT_TAG.BEARDS_CHIN) then return true end
    if self:IsPedUsingTag(COMPONENT_TAG.BEARDS_MUSTACHE) then return true end
    return false
end

function Character:RemoveBeard(skipEvent)
    if self:IsFemale() then return end
    self:RemoveTagFromPed(COMPONENT_TAG.BEARDS_COMPLETE)
    self:RemoveTagFromPed(COMPONENT_TAG.BEARDS_CHOPS)
    self:RemoveTagFromPed(COMPONENT_TAG.BEARDS_CHIN)
    self:RemoveTagFromPed(COMPONENT_TAG.BEARDS_MUSTACHE)
    if not skipEvent then SignalBus:emit("beard_removed") end
end

function Character:ApplyBeard()
    if self:IsFemale() then return end

    local colors = CreatorConfig.HairColors
    local normalizedColor = self.beardColor % #colors
    local color = colors[normalizedColor + 1]

    if self.beardColor ~= normalizedColor then
        self.beardColor = normalizedColor
    end

    local beards = CreatorConfig.MaleBeards
    local custom = CreatorConfig.CustomMaleBeards

    local normalizedBeard = self.beard % (#beards + #custom)
    local beard = { id = "NONE", custom = false }

    if self.beard ~= normalizedBeard then
        self.beard = normalizedBeard
    end

    if normalizedBeard < #beards then
        local id = beards[normalizedBeard + 1]
        if id ~= "NONE" then
            local item = string.format("CLOTHING_ITEM_M_BEARD_%03d_%s", id, color)
            beard = { id = item, custom = false }
        end
    else
        beard = custom[normalizedBeard - #beards + 1]
        beard.custom = true
    end

    if beard.id == "NONE" then
        self:RemoveBeard()
        return
    end

    if beard.custom then
        self:ApplyCustomBeard(beard, color)
    else
        self:ApplyShopItem(beard.id)
    end

    SignalBus:emit("beard_applied", beard)
end

function Character:ApplyCustomBeard(beard, color)
    local tints = CreatorConfig.CustomBeardTints[color]
    if not tints then
        error(string.format("No tints found for custom beard color: %s", color), 2)
    end

    local tint0 = tints[1] or 0
    local tint1 = tints[2] or 0
    local tint2 = tints[3] or 0

    local drawable = beard.drawable
    if not drawable then
        error(string.format("No drawable found for custom beard: %s", json.encode(beard)), 2)
    end

    local fallbacks = CreatorConfig.CustomBeardFallbacks
    local albedo = beard.albedo or fallbacks.albedo or 0
    local normal = beard.normal or fallbacks.normal or 0
    local material = beard.material or fallbacks.material or 0
    local palette = beard.palette or fallbacks.palette or 0

    self:RemoveBeard(true)

    local ped = self:GetPed()
    SetMetaPedTag(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)

    self:RequestUpdate()
end

function Character:GetOverlay(layer)
    return self.layers[layer] or { id = 0, alpha = 1.0 }
end

function Character:GetOverlayColor(layer)
    if not OVERLAY_LAYER:GetSupportsTint(layer) then
        error(string.format("Layer %d does not support color retrieval", layer), 2)
    end

    return self.layerColors[layer] or 0
end

function Character:ApplyOverlayBlend(layer, value, apply)
    if layer == OVERLAY_LAYER.ROOT then return end

    local overlay = self.layers[layer] or { id = 0, alpha = 1.0 }
    if value ~= nil then
        overlay.id = value

        self.layers[layer] = overlay
        self:SetModified()
    end

    local blend = CharacterOverlay:GetLayerBlend(layer, overlay.id + 1)

    CharacterOverlay:SetLayerBlend(layer, blend, false)
    self:ApplyOverlayAlpha(layer, nil, false)

    if OVERLAY_LAYER:GetSupportsTint(layer) then
        self:ApplyOverlayColor(layer, nil, false)
    end

    if apply then
        CharacterOverlay:RequestUpdate()
    end

    if blend == "BLEND_NONE" then
        SignalBus:emit("overlay_removed", layer)
    else
        SignalBus:emit("overlay_applied", layer)
    end
end

function Character:ApplyOverlayAlpha(layer, value, apply)
    if layer == OVERLAY_LAYER.ROOT then return end

    local overlay = self.layers[layer] or { id = 0, alpha = 1.0 }
    if value ~= nil then
        if value < 0.0001 then value = 0.0001 end
        if value > 1.0 then value = 1.0 end
        overlay.alpha = value

        self.layers[layer] = overlay
        self:SetModified()
    end

    CharacterOverlay:SetLayerAlpha(layer, overlay.alpha, apply)
end

function Character:ApplyOverlayColor(layer, value, apply)
    if layer == OVERLAY_LAYER.ROOT then return end

    if not OVERLAY_LAYER:GetSupportsTint(layer) then
        error(string.format("Layer %d does not support color application", layer), 2)
    end

    if value ~= nil then
        self.layerColors[layer] = value
        self:SetModified()
    end

    local overlay = self.layers[layer] or { id = 0, alpha = 1.0 }
    local blend = CharacterOverlay:GetLayerBlend(layer, overlay.id + 1)
    if blend == "BLEND_NONE" then return end

    local colors = CharacterOverlay:GetLayerColors(layer, blend)
    if not colors or #colors == 0 then
        error(string.format("No colors found for layer %d and blend %s", layer, blend), 2)
    end

    local normalized = self.layerColors[layer] % #colors
    local color = colors[normalized + 1]

    if self.layerColors[layer] ~= normalized then
        self.layerColors[layer] = normalized
    end

    if not color then
        error(string.format("No color found for layer %d and blend %s with index %d", layer, blend, normalized), 2)
    end

    CharacterOverlay:SetLayerBlend(layer, color, apply)
end

function Character:ApplyOverlays(apply)
    for _, layer in ipairs(OVERLAY_LAYER:Values()) do
        self:ApplyOverlayBlend(layer, nil, false)
    end

    if apply then
        CharacterOverlay:RequestUpdate()
    end
end

function Character:ApplyWhistleStyle(value)
    if value ~= nil then
        self.whistleStyle = value
        self:SetModified()
    end

    local ped = self:GetPed()
    SetWhistleConfigForPed(ped, "Ped.WhistleShape", self.whistleStyle)
end

function Character:ApplyWhistlePitch(value)
    if value ~= nil then
        self.whistlePitch = value
        self:SetModified()
    end

    local ped = self:GetPed()
    SetWhistleConfigForPed(ped, "Ped.WhistlePitch", self.whistlePitch * 0.01)
end

function Character:ApplyWhistleClarity(value)
    if value ~= nil then
        self.whistleClarity = value
        self:SetModified()
    end

    local ped = self:GetPed()
    SetWhistleConfigForPed(ped, "Ped.WhistleClarity", self.whistleClarity * 0.01)
end

function Character:Whistle()
    local ped = self:GetPed()
    TaskWhistleAnim(ped, `WhistleHorseLong`, `unspecified`)
end

function Character:Vocalize()
    local ped = self:GetPed()
    if IsAnySpeechPlaying(ped) == 1 then
        return
    end

    local gender = self:GetGenderFull()
    local voice = (self.voice or 0) + 1

    local struct = DataView.ArrayBuffer(7 * 8)
    struct:SetInt64(0 * 8, VarString(10, "LITERAL_STRING", "YEEHAW"))
    struct:SetInt64(1 * 8, VarString(10, "LITERAL_STRING", string.format("VOCALIZATIONS_WAVELOADED_PLAYER_%s%02d", gender, voice)))
    struct:SetInt32(2 * 8, 0)
    struct:SetInt32(3 * 8, (`SPEECH_PARAMS_FORCE_FRONTEND`) --[[@as integer]])
    struct:SetInt32(4 * 8, 0)
    struct:SetInt32(5 * 8, 1)
    struct:SetInt32(6 * 8, 1)

    Citizen.InvokeNative(Natives.PlayPedAmbientSpeechNative, ped, struct:Buffer())
end

function Character:ApplyHeritage(value)
    if value ~= nil then
        self.heritage = value
        self:SetModified()
    end

    CreatorPresets:SetHeritage(self.heritage)

    self:ApplyHead(false)
    self:ApplyAllExpressions()
end

function Character:ApplyPreset(zone, value)
    if value ~= nil then
        self.presets[zone] = value
        self:SetModified()
    end

    self:ApplyExpressionZonePreset(zone)
end

function Character:RandomizeAll()
    SetRandomSeed(GetGameTimer())

    self:RandomizeHeritage()
    self:RandomizeSkintone()
    self:RandomizeAge()
    self:RandomizeBodyBuild()
    self:RandomizeEyes()
    self:RandomizeTeeth()
    self:RandomizeHair()
    self:RandomizeBeard()
    self:RandomizeWeariness()
    self:RandomizePresets()
    self:RandomizeExpressions()
    self:RandomizeOverlays()
    self:RandomizeOverlayPresets()

    if Creator:IsAdvancedMode() then
        self:RandomizeHeight()
        self:RandomizeWeight()
        self:RandomizeCustomHead(true)
    end

    self:RandomizeWhistle(false)
    self:RandomizeVoice(false)

    CharacterOverlay:RequestUpdate()

    self:SetRandomized()
    SignalBus:emit("randomized")
end

function Character:RandomizeHeritage()
    local heritages = CreatorPresets:GetHeritages()
    self:ApplyHeritage(GetRandomIntInRange(0, #heritages))
    self:ApplyAgeBlend(true)
    SignalBus:emit("heritage_randomized", self.heritage)
end

function Character:RandomizeSkintone()
    local skintones = CreatorPresets:GetSkintones()
    local skintone = GetRandomIntInRange(0, #skintones)
    self:ApplySkintone(skintone, false)
    SignalBus:emit("skintone_randomized", self.skintone)
end

function Character:GenerateAge()
    return GetRandomIntInRange(CreatorConfig.MinAge or 18, (CreatorConfig.MaxAge or 60) + 1)
end

function Character:RandomizeAge()
    self.age = self:GenerateAge()
    self:ApplyAgeAlpha(self.age, true)
    SignalBus:emit("age_randomized", self.age)
end

function Character:RandomizeBodyBuild()
    local bodyBuilds = self:IsMale() and CreatorConfig.MaleBodyBuilds or CreatorConfig.FemaleBodyBuilds
    local index = GetRandomIntInRange(0, #bodyBuilds)
    self:ApplyBody(index)
    SignalBus:emit("body_randomized", self.bodyType)
end

function Character:RandomizeEyes()
    local eyeColors = CreatorConfig.Eyes
    self:ApplyEyeColor(GetRandomIntInRange(0, #eyeColors))
    SignalBus:emit("eyes_randomized", self.eyeColor)
end

function Character:RandomizeTeeth()
    local teethOptions = CreatorConfig.Teeth
    self:ApplyTeeth(GetRandomIntInRange(0, #teethOptions))
    SignalBus:emit("teeth_randomized", self.teeth)
end

function Character:RandomizeHair()
    self:RandomizeHairStyle()
    self:RandomizeHairColor()
end

function Character:RandomizeHairStyle()
    local hairStyles = self:IsMale() and CreatorConfig.MaleHairs or CreatorConfig.FemaleHairs
    local customStyles = self:IsMale() and CreatorConfig.CustomMaleHairs or CreatorConfig.CustomFemaleHairs

    self:ApplyHairStyle(GetRandomIntInRange(0, #hairStyles + #customStyles))
    SignalBus:emit("hair_style_randomized", self.hair)
end

function Character:RandomizeHairColor()
    local hairColors = CreatorConfig.HairColors
    self:ApplyHairColor(GetRandomIntInRange(0, #hairColors))
    SignalBus:emit("hair_color_randomized", self.hairColor)
end

function Character:RandomizeBeard()
    if self:IsFemale() then return end
    self:RandomizeBeardStyle()
    self:RandomizeBeardColor()
end

function Character:RandomizeBeardStyle()
    if self:IsFemale() then return end
    local beardStyles = CreatorConfig.MaleBeards
    local customStyles = CreatorConfig.CustomMaleBeards

    self:ApplyBeardStyle(GetRandomIntInRange(0, #beardStyles + #customStyles))
    SignalBus:emit("beard_style_randomized", self.beard)
end

function Character:RandomizeBeardColor()
    if self:IsFemale() then return end
    local beardColors = CreatorConfig.HairColors
    self:ApplyBeardColor(GetRandomIntInRange(0, #beardColors))
    SignalBus:emit("beard_color_randomized", self.beardColor)
end

function Character:RandomizeWeariness()
    local weariness = GetRandomFloatInRange(0.0, 1.0)
    weariness = math.floor(weariness * 10000 + 0.5) / 10000

    self:ApplyWeariness(weariness)
    SignalBus:emit("weariness_randomized", weariness)
end

function Character:RandomizePresets()
    local presets = PED_EXPRESSION_ZONE:Pluck("Randomized", "Id")
    for key, _ in pairs(presets) do
        self:RandomizePreset(key)
    end
    SignalBus:emit("presets_randomized", self.presets)
end

function Character:RandomizePreset(preset)
    local options = CreatorPresets:GetExpressionZonePresets(preset)
    self:ApplyPreset(preset, GetRandomIntInRange(0, #options))
    SignalBus:emit("preset_randomized", preset, self.presets[preset])
end

function Character:RandomizeExpressions()
    local expressions = PED_EXPRESSION:Pluck("Randomized", "Id")
    for key, _ in pairs(expressions) do
        self:RandomizeExpression(key)
    end
    SignalBus:emit("expressions_randomized", self.expressions)
end

function Character:RandomizeExpression(expression)
    local min, max = self:GetExpressionGameBounds(expression)

    local gameValue = GetRandomFloatInRange(min, max)
    gameValue = math.floor(gameValue * 10000 + 0.5) / 10000

    local uiValue = self:ExpressionGameToUiValue(expression, gameValue)

    self:ApplyExpressionValue(expression, uiValue, false)
    SignalBus:emit("expression_randomized", expression, uiValue)
end

function Character:RandomizeOverlays(apply)
    local percentToSkipOverlay = CreatorConfig.RandomizePercentToSkipOverlay or 30

    for _, layer in ipairs(OVERLAY_LAYER:Values()) do
        if not OVERLAY_LAYER:GetRandomized(layer) then
            goto continue
        end

        local alpha = GetRandomFloatInRange(0.0, 1.0)
        alpha = math.floor(alpha * 10000 + 0.5) / 10000

        if layer == OVERLAY_LAYER.EYEBROWS or layer == OVERLAY_LAYER.FACIAL_HAIR then
            alpha = 1.0
        end

        self:ApplyOverlayAlpha(layer, alpha, false)

        ::continue::
    end

    -- We start at 1 since we want to always reserve the AGEING overlay
    local count = 1

    for _, layer in ipairs(OVERLAY_LAYER:Values()) do
        if not OVERLAY_LAYER:GetRandomized(layer) then
            goto continue
        end

        local blends = CharacterOverlay:GetLayerBlends(layer)
        local index = GetRandomIntInRange(0, #blends)

        if index ~= 0 and GetRandomIntInRange(0, 100) < percentToSkipOverlay then
            -- Make it less likely all overlays are applied
            index = 0
        elseif index ~= 0 and count >= CharacterOverlay.MAX_LAYERS_COUNT then
            -- Enforce the maximum number of overlays
            index = 0
        end

        if index ~= 0 then count = count + 1 end
        self:ApplyOverlayBlend(layer, index, false)

        ::continue::
    end

    for layer, _ in pairs(OVERLAY_LAYER:Pluck("SupportsTint", "Id")) do
        if not OVERLAY_LAYER:GetRandomized(layer) then
            goto continue
        end

        local overlay = self.layers[layer] or { id = 0, alpha = 1.0 }
        local blend = CharacterOverlay:GetLayerBlend(layer, overlay.id + 1)

        local colors = CharacterOverlay:GetLayerColors(layer, blend)
        if #colors == 0 then goto continue end

        local index = GetRandomIntInRange(0, #colors)
        self:ApplyOverlayColor(layer, index, false)

        ::continue::
    end

    self:ApplyOverlays(apply)
    SignalBus:emit("overlays_randomized")
end

function Character:RandomizeOverlayPresets(apply)
    local layers = OVERLAY_LAYER:Pluck("SupportsPresets", "Id")
    local gender = self:GetGenderShort()

    local filtered = {}
    for _, preset in ipairs(CreatorConfig.MakeupPresets or {}) do
        if not preset.gender or preset.gender == gender then
            filtered[#filtered + 1] = preset
        end
    end

    local presetIndex = GetRandomIntInRange(0, #filtered)
    local preset = filtered[presetIndex + 1] or {}

    local percentToSkipMakeup = CreatorConfig.RandomizePercentToSkipMakeup or 30
    if GetRandomIntInRange(0, 100) < percentToSkipMakeup then
        preset = {}
    end

    for layer, _ in pairs(layers) do
        local presetData = preset[layer]
        local blendIndex = 0
        local colorIndex = 0
        local alpha = 1.0

        if presetData then
            alpha = presetData.alpha or 1.0

            if presetData.blend then
                local blends = CharacterOverlay:GetLayerBlends(layer)
                for i, blend in ipairs(blends) do
                    if blend == presetData.blend then
                        blendIndex = i - 1
                        break
                    end
                end
            end

            if OVERLAY_LAYER:GetSupportsTint(layer) and presetData.tint then
                local colors = CharacterOverlay:GetLayerColors(layer, presetData.blend)
                for i, color in ipairs(colors) do
                    if color == presetData.tint then
                        colorIndex = i - 1
                        break
                    end
                end
            end
        end

        self:ApplyOverlayAlpha(layer, alpha, false)
        self:ApplyOverlayBlend(layer, blendIndex, false)

        if OVERLAY_LAYER:GetSupportsTint(layer) then
            self:ApplyOverlayColor(layer, colorIndex, false)
        end
    end

    self:ApplyOverlays(apply)
    SignalBus:emit("overlay_presets_randomized")
end

function Character:RandomizeWhistle(preview)
    self:ApplyWhistleStyle(GetRandomIntInRange(0, 5))
    self:ApplyWhistlePitch(GetRandomIntInRange(0, 100))
    self:ApplyWhistleClarity(GetRandomIntInRange(0, 100))

    SignalBus:emit("whistle_randomized", self.whistleStyle, self.whistlePitch, self.whistleClarity)

    if preview then self:Whistle() end
end

function Character:RandomizeHeight()
    local heights = CreatorConfig.Heights
    self:ApplyHeight(GetRandomIntInRange(0, #heights))
    SignalBus:emit("height_randomized", self.height)
end

function Character:RandomizeWeight()
    local weights = CreatorConfig.Weights
    self:ApplyWeight(GetRandomIntInRange(0, #weights))
    SignalBus:emit("weight_randomized", self.weight)
end

function Character:RandomizeCustomHead(apply)
    local head = self:GetHeadShopItem()
    if not head then return end

    local drawables = self:IsMale() and CreatorConfig.CustomMaleHeadDrawables or CreatorConfig.CustomFemaleHeadDrawables
    self:ApplyHeadDrawable(GetRandomIntInRange(0, #drawables), false)

    local albedos = self:IsMale() and CreatorConfig.CustomMaleHeadAlbedos or CreatorConfig.CustomFemaleHeadAlbedos
    local skintoneAlbedos = albedos[head.skintone + 1] or {}
    local albedoIndex = GetRandomIntInRange(0, #skintoneAlbedos)

    local percentToSkipAlbedo = CreatorConfig.RandomizePercentToSkipHeadAlbedo or 70
    if GetRandomIntInRange(0, 100) < percentToSkipAlbedo then albedoIndex = 0 end

    self:ApplyHeadAlbedo(albedoIndex, false)

    local normals = self:IsMale() and CreatorConfig.CustomMaleHeadNormals or CreatorConfig.CustomFemaleHeadNormals
    local normalIndex = GetRandomIntInRange(0, #normals)

    local percentToSkipNormal = CreatorConfig.RandomizePercentToSkipHeadNormal or 30
    if GetRandomIntInRange(0, 100) < percentToSkipNormal then normalIndex = 0 end

    self:ApplyHeadNormal(normalIndex, false)

    local materials = self:IsMale() and CreatorConfig.CustomMaleHeadMaterials or CreatorConfig.CustomFemaleHeadMaterials
    local materialIndex = GetRandomIntInRange(0, #materials)

    local percentToSkipMaterial = CreatorConfig.RandomizePercentToSkipHeadMaterial or 70
    if GetRandomIntInRange(0, 100) < percentToSkipMaterial then materialIndex = 0 end

    self:ApplyHeadMaterial(materialIndex, false)

    if apply then self:ApplyHead(true) end

    SignalBus:emit("custom_head_randomized", self.headDrawable, self.headAlbedo, self.headNormal, self.headMaterial)
end

function Character:RandomizeVoice(preview)
    local voices = CreatorConfig.Voices
    self:ApplyVoice(GetRandomIntInRange(0, #voices))
    SignalBus:emit("voice_randomized", self.voice)

    if preview then self:Vocalize() end
end

function Character:ApplyClothingLevel(level)
    local ped = self:GetPed()

    for _, tag in ipairs(COMPONENT_TAG:Values()) do
        local hiddenTags = COMPONENT_TAG:GetHiddenTags(tag)
        if hiddenTags then
            for _, setting in ipairs(hiddenTags) do
                if setting == level then
                    local hash = COMPONENT_TAG:GetHash(tag)
                    if hash then
                        RemoveTagFromMetaPed(ped, hash, 0)
                    end
                    break
                end
            end
        end
    end

    self:ApplyBodyItems()
    self:RequestUpdate()
end

function Character:ApplyDefaultClothing()
    if Intro:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
        if IsPedModel(Intro.playerPedId, `MP_MALE`) == 1 then
            ClonePedToTarget(Intro.playerPedId, Intro.presetPeds[EDITOR_CONFIG.MALE])
        else
            ClonePedToTarget(Intro.playerPedId, Intro.presetPeds[EDITOR_CONFIG.FEMALE])
        end
    else
        local ped = self:GetPed()

        -- For the intro case the exact outfit items applied during MaintainApplyClothes
        -- were saved in savedOutfitItems, so we strip all clothing and re-apply them.
        for _, tag in ipairs(COMPONENT_TAG:Values()) do
            if COMPONENT_TAG:GetHiddenTags(tag) then
                local hash = COMPONENT_TAG:GetHash(tag)
                if hash then RemoveTagFromMetaPed(ped, hash, 0) end
            end
        end

        local items = Intro.savedOutfitItems[Intro.selectedPreset] or {}
        for _, item in ipairs(items) do
            ApplyShopItemToPed(ped, item, false, true, false)
        end
    end

    self:ApplyAll()
    self:RequestUpdate()
end

SignalBus:on("grid_x_changed", function(itemId, value)
    local expressions = UI_ITEM_ID:GetExpressions(itemId)
    local overlayLayer = UI_ITEM_ID:GetOverlayLayer(itemId)

    if itemId == UI_ITEM_ID.LIFESTYLE__EYE_REDNESS then
        Character:ApplyWeariness(value)
    elseif expressions and expressions.ExpressionX then
        Character:ApplyExpressionValue(expressions.ExpressionX, value, true)
    elseif overlayLayer then
        Character:ApplyOverlayAlpha(overlayLayer, value, true)
    end
end)

SignalBus:on("grid_y_changed", function(itemId, value)
    local expressions = UI_ITEM_ID:GetExpressions(itemId)
    local overlayLayer = UI_ITEM_ID:GetOverlayLayer(itemId)

    if itemId == UI_ITEM_ID.LIFESTYLE__EYE_REDNESS then
        Character:ApplyWeariness(value)
    elseif expressions and expressions.ExpressionY then
        Character:ApplyExpressionValue(expressions.ExpressionY, value, true)
    elseif overlayLayer then
        Character:ApplyOverlayAlpha(overlayLayer, value, true)
    end
end)

SignalBus:on("adjustable_changed", function(itemId, value)
    local layer = UI_ITEM_ID:GetOverlayLayer(itemId)
    if layer then
        Character:ApplyOverlayBlend(layer, value, true)
        return
    end

    local color = UI_ITEM_ID:GetOverlayColor(itemId)
    if color then
        Character:ApplyOverlayColor(color, value, true)
        return
    end

    local preset = UI_ITEM_ID:GetExpressionZone(itemId)
    if preset then
        Character:ApplyPreset(preset, value)
        return
    end

    local action = UI_ITEM_ID:GetAction(itemId)
    if not action then
        return
    end

    if action == CHARACTER_ACTION.APPLY_HERITAGE then
        Character:ApplyHeritage(value)
        Character:ApplyAgeBlend(true)
    elseif action == CHARACTER_ACTION.APPLY_SKINTONE then
        Character:ApplySkintone(value, true)
    elseif action == CHARACTER_ACTION.APPLY_AGE_ALPHA then
        Character:ApplyAgeAlpha(value, true)
    elseif action == CHARACTER_ACTION.APPLY_BODY_BUILD then
        Character:ApplyBody(value)
    elseif action == CHARACTER_ACTION.APPLY_EYE_COLOR then
        Character:ApplyEyeColor(value)
    elseif action == CHARACTER_ACTION.APPLY_TEETH then
        Character:ApplyTeeth(value)
    elseif action == CHARACTER_ACTION.APPLY_HAIR_STYLE then
        Character:ApplyHairStyle(value)
    elseif action == CHARACTER_ACTION.APPLY_HAIR_COLOR then
        Character:ApplyHairColor(value, true)
    elseif action == CHARACTER_ACTION.APPLY_BEARD_STYLE then
        Character:ApplyBeardStyle(value)
    elseif action == CHARACTER_ACTION.APPLY_BEARD_COLOR then
        Character:ApplyBeardColor(value, true)
    elseif action == CHARACTER_ACTION.APPLY_WHISTLE_STYLE then
        Character:ApplyWhistleStyle(value)
    elseif action == CHARACTER_ACTION.APPLY_WHISTLE_PITCH then
        Character:ApplyWhistlePitch(value)
    elseif action == CHARACTER_ACTION.APPLY_WHISTLE_CLARITY then
        Character:ApplyWhistleClarity(value)
    elseif action == CHARACTER_ACTION.APPLY_ATTRIBUTE_HEALTH then
        -- TODO: Attributes support
    elseif action == CHARACTER_ACTION.APPLY_ATTRIBUTE_STAMINA then
        -- TODO: Attributes support
    elseif action == CHARACTER_ACTION.APPLY_ATTRIBUTE_DEADEYE then
        -- TODO: Attributes support
    elseif action == CHARACTER_ACTION.APPLY_HEIGHT then
        Character:ApplyHeight(value)
    elseif action == CHARACTER_ACTION.APPLY_WEIGHT then
        Character:ApplyWeight(value)
    elseif action == CHARACTER_ACTION.APPLY_HEAD_DRAWABLE then
        Character:ApplyHeadDrawable(value, true)
    elseif action == CHARACTER_ACTION.APPLY_HEAD_ALBEDO then
        Character:ApplyHeadAlbedo(value, true)
    elseif action == CHARACTER_ACTION.APPLY_HEAD_NORMAL then
        Character:ApplyHeadNormal(value, true)
    elseif action == CHARACTER_ACTION.APPLY_HEAD_MATERIAL then
        Character:ApplyHeadMaterial(value, true)
    elseif action == CHARACTER_ACTION.APPLY_VOICE then
        Character:ApplyVoice(value)
    end
end)

SignalBus:on("action_selected", function(actionId, itemId)
    local action = UI_ACTION_ID:GetAction(actionId)
    if not action then
        return
    end

    if action == CHARACTER_ACTION.PLAY_WHISTLE_SOUND then
        Character:Whistle()
    elseif action == CHARACTER_ACTION.RANDOMIZE_ITEM then
        if itemId == UI_ITEM_ID.APPEARANCE__RANDOMIZE then
            Character:RandomizeAll()
        elseif itemId == UI_ITEM_ID.APPEARANCE__AGE then
            Character:RandomizeAge()
        elseif itemId == UI_ITEM_ID.MAIN__WHISTLE then
            Character:RandomizeWhistle(true)
        elseif itemId == UI_ITEM_ID.WHISTLE__STYLE then
            Character:RandomizeWhistle(true)
        elseif itemId == UI_ITEM_ID.WHISTLE__PITCH then
            Character:RandomizeWhistle(true)
        elseif itemId == UI_ITEM_ID.WHISTLE__CLARITY then
            Character:RandomizeWhistle(true)
        end
    elseif action == CHARACTER_ACTION.PLAY_VOCALIZATION then
        Character:Vocalize()
    elseif action == CHARACTER_ACTION.RANDOMIZE_ADVANCED_ITEM then
        if itemId == UI_ITEM_ID.APPEARANCE__RANDOMIZE then
            Character:RandomizeAll()
        elseif itemId == UI_ITEM_ID.MAIN__WHISTLE then
            Character:RandomizeVoice(true)
        elseif itemId == UI_ITEM_ID.WHISTLE__STYLE then
            Character:RandomizeVoice(true)
        end
    end
end)

SignalBus:on("character_pasted", function(data)
    Character:Import(data)
end)

CreateThread(function()
    while true do
        Character:Maintain()
        Wait(0)
    end
end)
