local defaults = {
    -- Private
    flags = 0,
    ped = 0,

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

    hair = 0,
    hairColor = 0,
    beard = 0,
    beardColor = 0,

    ignoreLimits = false,

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

Character = setmetatable({}, { __index = defaults })

function Character:Import(data)
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

function Character:Export()
    local data = Utils:CopyData(defaults)

    local copy = Utils:CopyData(self, data)
    copy.flags = nil
    copy.ped = nil

    return copy
end

function Character:Reset()
    for k, v in pairs(self) do
        if type(v) ~= "function" then
            self[k] = nil
        end
    end
end

function Character:IsFlagSet(flag)
    return (self.flags & flag) ~= 0
end

function Character:SetFlag(flag)
    self.flags = self.flags | flag
end

function Character:ClearFlag(flag)
    self.flags = self.flags & ~flag
end

function Character:Maintain()
    if not self:IsFlagSet(CHARACTER_FLAG.DIRTY) then
        return
    end

    if self.ped == 0 or IsPedReadyToRender(self.ped) ~= 1 then
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
        -- PED::_SET_ACTIVE_META_PED_COMPONENTS_UPDATED
        Citizen.InvokeNative(0xAAB86462966168CE, self.ped, true)
        UpdatePedVariation(self.ped, false, true, true, true, false)

        self:ClearFlag(CHARACTER_FLAG.UPDATE_PED)
    end

    self:ClearFlag(CHARACTER_FLAG.DIRTY)
end

function Character:Exists()
    if self.ped == 0 then return false end
    return DoesEntityExist(self.ped) == 1
end

function Character:IsPlayer()
    if not self:Exists() then return false end
    return IsPedAPlayer(self.ped) == 1
end

function Character:IsOtherPlayer()
    if not self:IsPlayer() then return false end
    return self.ped ~= PlayerPedId()
end

function Character:IsHuman()
    if not self:Exists() then return false end
    return IsPedHuman(self.ped) == 1
end

function Character:IsMale()
    if not self:Exists() then return false end
    if not self:IsHuman() then return false end

    local model = GetEntityModel(self.ped)
    if model == `MP_MALE` then
        return true
    elseif model == `MP_FEMALE` then
        return false
    end

    return IsPedMale(self.ped)
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

function Character:ApplyShopItem(item)
    ApplyShopItemToPed(self.ped, item, false, true, true)

    self:RequestUpdate()
end

function Character:ApplyMetaPedOutfit(outfit)
    EquipMetaPedOutfit(self.ped, outfit)

    self:RequestUpdate()
end

function Character:IsPedUsingTag(tag)
    local hash = COMPONENT_TAG:GetHash(tag)
    if not hash then
        error(string.format("No hash found for tag: %s", COMPONENT_TAG:ToString(tag)), 2)
    end

    return Citizen.InvokeNative(0xFB4891BD7578CDC1, self.ped, hash) == 1
end

function Character:RemoveTagFromPed(tag)
    local hash = COMPONENT_TAG:GetHash(tag)
    if not hash then
        error(string.format("No hash found for tag: %s", COMPONENT_TAG:ToString(tag)), 2)
    end

    RemoveTagFromMetaPed(self.ped, hash, 0)

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

function Character:ApplyHeight(value, apply)
    if value ~= nil then
        self.height = value
    end

    local heights = CreatorConfig.Heights
    local normalized = self.height % #heights
    local height = heights[normalized + 1]

    if apply then
        SetPedScale(self.ped, height.value)
    else
        self:SetFlag(CHARACTER_FLAG.UPDATE_HEIGHT)
        self:SetFlag(CHARACTER_FLAG.DIRTY)
    end
end

function Character:ApplyWeight(value)
    if value ~= nil then
        self.weight = value
    end

    local weights = CreatorConfig.Weights
    local normalized = self.weight % #weights
    local weight = weights[normalized + 1]

    self:ApplyMetaPedOutfit(weight.value)
end

function Character:ApplyVoice(value)
    if value ~= nil then
        self.voice = value
    end

    local voices = CreatorConfig.Voices
    local normalized = self.voice % #voices
    local voice = voices[normalized + 1]

    local gender = self:GetGenderFull()
    local item = string.format("VOFX_PLAYER_%s%02d", gender, voice.value)

    SetVofxPedVoice(self.ped, item)

    self:RequestUpdate()
end

function Character:ApplyWeariness(value)
    if value ~= nil then
        self.weariness = value
    end

    local min = CreatorConfig.MinWeariness or 0.0
    local max = CreatorConfig.MaxWeariness or 0.5
    local result = min + (self.weariness * (max - min))

    SetMetaPedWeariness(self.ped, result)
end

function Character:GetExpressionGameBounds(expressionId)
    local min, max = -1.0, 1.0

    -- Fill the limites from the heritage if applicable and desired
    if not self.ignoreLimits then
        local data = CreatorPresets:GetFineTuningData()
        local tuning = data[expressionId]
        if tuning then
            min, max = tuning.min, tuning.max
        end
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
        self.expressions[expressionId] = uiValue
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

    if not PED_EXPRESSION_ZONE:GetQuery(zone) then
        for _, expressionId in ipairs(expressions) do
            self:ApplyExpressionValue(expressionId, nil, false)
        end
    else
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
    end

    self:RequestUpdate()
end

function Character:SetExpression(expressionId, gameValue, update)
    -- _SET_CHAR_EXPRESSION
    Citizen.InvokeNative(0x5653AB26C82938CF, self.ped, expressionId, gameValue)

    if update then
        self:RequestUpdate()
    end
end

function Character:GetHeadShopItem()
    return CreatorPresets:GetHeadShopItemForSkintone(self.skintone)
end

function Character:ApplyHead(apply)
    local head = self:GetHeadShopItem()
    if not head then return end

    self:ApplyShopItem(head.id)
    CharacterOverlay:UpdateBaseLayer(head.id, apply)
end

function Character:ApplyAgeBlend(apply)
    local ages = CreatorConfig.Overlays[OVERLAY_LAYER.AGEING]
    local normalized = self.heritage % #ages
    self:ApplyOverlayBlend(OVERLAY_LAYER.AGEING, normalized + 1, apply)
end

function Character:ApplyAgeAlpha(value, apply)
    if value ~= nil then
        self.age = value
    end

    local minAge = CreatorConfig.MinAge or 18
    local maxAge = CreatorConfig.MaxAge or 60

    local opacityMin, opacityMax = 0.001, 100
    local opacityResult = math.max(
        opacityMin,
        math.min(
            opacityMax,
            (self.age - minAge) / (maxAge - minAge)
        )
    )

    self:ApplyOverlayAlpha(OVERLAY_LAYER.AGEING, opacityResult, apply)
end

function Character:ApplySkintone(value, apply)
    if value ~= nil then
        self.skintone = value
    end

    self:ApplyHead(apply)
    self:ApplyBodyItems()
end

function Character:ApplyBodyItems(value)
    if value ~= nil then
        self.bodyType = value
    end

    local bodyBuilds = self:IsMale() and CreatorConfig.MaleBodyBuilds or CreatorConfig.FemaleBodyBuilds
    local normalized = self.bodyType % #bodyBuilds
    local bodyBuild = bodyBuilds[normalized + 1]

    local presetBodyBuild = CreatorPresets:GetBodyBuild(bodyBuild.build)
    local shopItems = CreatorPresets:GetBodyShopItems(self.skintone, presetBodyBuild)

    self:ApplyShopItem(shopItems.upper)
    self:ApplyShopItem(shopItems.lower)

    self:RequestUpdate()
end

function Character:ApplyBodyExpressions(value)
    if value ~= nil then
        self.bodyType = value
    end

    local bodyBuilds = self:IsMale() and CreatorConfig.MaleBodyBuilds or CreatorConfig.FemaleBodyBuilds
    local normalized = self.bodyType % #bodyBuilds
    local bodyBuild = bodyBuilds[normalized + 1]

    for expressionKey, expressionValue in pairs(bodyBuild.expressions) do
        local uiValue = self:ExpressionGameToUiValue(expressionKey, expressionValue)
        self:ApplyExpressionValue(expressionKey, uiValue, false)
    end
end

function Character:ApplyEyeColor(value)
    if value ~= nil then
        self.eyeColor = value
    end

    local colors = CreatorConfig.Eyes
    local normalized = self.eyeColor % #colors
    local color = colors[normalized + 1]

    local gender = self:GetGenderShort()
    local eyes = string.format("CLOTHING_ITEM_%s_EYES_001_TINT_%03d", gender, color)

    self:ApplyShopItem(eyes)
end

function Character:ApplyTeeth(value)
    if value ~= nil then
        self.teeth = value
    end

    local teeth = CreatorConfig.Teeth
    local normalized = self.teeth % #teeth
    local teethItem = teeth[normalized + 1]

    local gender = self:GetGenderShort()
    local key = string.format("CLOTHING_ITEM_%s_TEETH_%03d", gender, teethItem)

    self:ApplyShopItem(key)
end

function Character:ApplyHairStyle(value)
    if value ~= nil then
        self.hair = value
    end

    self:ApplyHair()
end

function Character:ApplyHairColor(value, apply)
    if value ~= nil then
        self.hairColor = value
    end

    self:ApplyHair()
    self:ApplyOverlayBlend(OVERLAY_LAYER.EYEBROWS)
    self:ApplyOverlayBlend(OVERLAY_LAYER.HEAD_HAIR)

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

    local gender = self:GetGenderShort()

    local hairs = self:IsMale() and CreatorConfig.MaleHairs or CreatorConfig.FemaleHairs
    local custom = self:IsMale() and CreatorConfig.CustomMaleHairs or CreatorConfig.CustomFemaleHairs

    local normalizedHair = self.hair % (#hairs + #custom)
    local hair = { id = "NONE", custom = false }

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
    SetMetaPedTag(self.ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)

    self:RequestUpdate()
end

function Character:ApplyBeardStyle(value)
    if self:IsFemale() then return end

    if value ~= nil then
        self.beard = value
    end

    self:ApplyBeard()
end

function Character:ApplyBeardColor(value, apply)
    if self:IsFemale() then return end

    if value ~= nil then
        self.beardColor = value
    end

    self:ApplyBeard()
    self:ApplyOverlayBlend(OVERLAY_LAYER.FACIAL_HAIR)

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

    local beards = CreatorConfig.MaleBeards
    local custom = CreatorConfig.CustomMaleBeards

    local normalizedBeard = self.beard % (#beards + #custom)
    local beard = { id = "NONE", custom = false }

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
    SetMetaPedTag(self.ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)

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

    if value ~= nil then
        self.layers[layer].id = value
    end

    local overlay = self.layers[layer] or { id = 0, alpha = 1.0 }
    local blend = CharacterOverlay:GetLayerBlend(layer, overlay.id + 1)
    CharacterOverlay:SetLayerBlend(layer, blend, apply)

    if OVERLAY_LAYER:GetSupportsTint(layer) then
        self:ApplyOverlayColor(layer, nil, apply)
    end

    if blend == "BLEND_NONE" then
        self.layers[layer].alpha = 1.0
        SignalBus:emit("overlay_removed", layer)
    else
        SignalBus:emit("overlay_applied", layer)
    end
end

function Character:ApplyOverlayAlpha(layer, value, apply)
    if layer == OVERLAY_LAYER.ROOT then return end

    if value ~= nil then
        self.layers[layer].alpha = value
    end

    local overlay = self.layers[layer] or { id = 0, alpha = 1.0 }
    local blend = CharacterOverlay:GetLayerBlend(layer, overlay.id + 1)

    if blend == "BLEND_NONE" then overlay.alpha = 1.0 end
    if overlay.alpha < 0.0 then overlay.alpha = 0.0 end
    if overlay.alpha > 1.0 then overlay.alpha = 1.0 end

    CharacterOverlay:SetLayerAlpha(layer, overlay.alpha, apply)
end

function Character:ApplyOverlayColor(layer, value, apply)
    if layer == OVERLAY_LAYER.ROOT then return end

    if not OVERLAY_LAYER:GetSupportsTint(layer) then
        error(string.format("Layer %d does not support color application", layer), 2)
    end

    if value ~= nil then
        self.layerColors[layer] = value
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

    if not color then
        error(string.format("No color found for layer %d and blend %s with index %d", layer, blend, normalized), 2)
    end

    CharacterOverlay:SetLayerBlend(layer, color, apply)
end

function Character:ApplyOverlays(apply)
    for _, layer in ipairs(OVERLAY_LAYER:Values()) do
        self:ApplyOverlayBlend(layer)

        if OVERLAY_LAYER:GetSupportsTint(layer) then
            self:ApplyOverlayColor(layer)
        end

        self:ApplyOverlayAlpha(layer)
    end

    if apply then
        CharacterOverlay:RequestUpdate()
    end
end

function Character:ApplyWhistleStyle(value)
    if value ~= nil then
        self.whistleStyle = value
    end

    SetWhistleConfigForPed(self.ped, "Ped.WhistleShape", self.whistleStyle)
end

function Character:ApplyWhistlePitch(value)
    if value ~= nil then
        self.whistlePitch = value
    end

    SetWhistleConfigForPed(self.ped, "Ped.WhistlePitch", self.whistlePitch * 0.01)
end

function Character:ApplyWhistleClarity(value)
    if value ~= nil then
        self.whistleClarity = value
    end

    SetWhistleConfigForPed(self.ped, "Ped.WhistleClarity", self.whistleClarity * 0.01)
end

function Character:Whistle()
    TaskWhistleAnim(self.ped, `WhistleHorseLong`, `unspecified`)
end

function Character:Vocalize()
    if IsAnySpeechPlaying(self.ped) == 1 then
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

    -- AUDIO::PLAY_PED_AMBIENT_SPEECH_NATIVE
    Citizen.InvokeNative(0x8E04FEDD28D42462, self.ped, struct:Buffer())
end

function Character:ApplyHeritage(value)
    if value ~= nil then
        self.heritage = value
    end

    CreatorPresets:SetHeritage(self.heritage)

    self:ApplyHead(false)
    self:ApplyAllExpressions()
end

function Character:ApplyPreset(zone, value)
    if value ~= nil then
        self.presets[zone] = value
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
    end

    CharacterOverlay:RequestUpdate()

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

function Character:RandomizeAge()
    self.age = GetRandomIntInRange(CreatorConfig.MinAge or 18, (CreatorConfig.MaxAge or 60) + 1)
    self:ApplyAgeAlpha(self.age, true)
    SignalBus:emit("age_randomized", self.age)
end

function Character:RandomizeBodyBuild()
    local bodyBuilds = self:IsMale() and CreatorConfig.MaleBodyBuilds or CreatorConfig.FemaleBodyBuilds
    local index = GetRandomIntInRange(0, #bodyBuilds)

    self:ApplyBodyItems(index)
    self:ApplyBodyExpressions(index)

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
    self.weariness = GetRandomFloatInRange(0.0, 1.0)
    self:ApplyWeariness(self.weariness)
    SignalBus:emit("weariness_randomized", self.weariness)
end

function Character:RandomizePresets()
    local presets = PED_EXPRESSION_ZONE:Pluck("Query", "Id")
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
    local uiValue = self:ExpressionGameToUiValue(expression, gameValue)

    self:ApplyExpressionValue(expression, uiValue, false)
    SignalBus:emit("expression_randomized", expression, uiValue)
end

function Character:RandomizeOverlays(apply)
    local percentToSkipOverlay = CreatorConfig.RandomizePercentToSkipOverlay or 30

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

    for _, layer in ipairs(OVERLAY_LAYER:Values()) do
        if not OVERLAY_LAYER:GetRandomized(layer) then
            goto continue
        end

        local upperAlpha = 1.0
        if OVERLAY_LAYER:GetSupportsTint(layer) then
            upperAlpha = 0.5
        end

        local alpha = GetRandomFloatInRange(0.0, upperAlpha)
        if layer == OVERLAY_LAYER.EYEBROWS or layer == OVERLAY_LAYER.FACIAL_HAIR then
            alpha = 1.0
        end

        self:ApplyOverlayAlpha(layer, alpha, false)

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

        self:ApplyOverlayBlend(layer, blendIndex)

        if OVERLAY_LAYER:GetSupportsTint(layer) then
            self:ApplyOverlayColor(layer, colorIndex)
        end

        self:ApplyOverlayAlpha(layer, alpha)
    end

    self:ApplyOverlays(apply)
    SignalBus:emit("overlay_presets_randomized")
end

function Character:RandomizeWhistle(whistle)
    self.whistleStyle = GetRandomIntInRange(0, 5)
    self:ApplyWhistleStyle()

    self.whistlePitch = GetRandomIntInRange(0, 100)
    self:ApplyWhistlePitch()

    self.whistleClarity = GetRandomIntInRange(0, 100)
    self:ApplyWhistleClarity()

    SignalBus:emit("whistle_randomized", self.whistleStyle, self.whistlePitch, self.whistleClarity)

    if whistle then self:Whistle() end
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

function Character:RandomizeVoice(preview)
    local voices = CreatorConfig.Voices
    self:ApplyVoice(GetRandomIntInRange(0, #voices))
    SignalBus:emit("voice_randomized", self.voice)

    if preview then self:Vocalize() end
end

-- Remove clothing components from a ped based on the requested clothing setting.
-- TOPLESS strips upper-body components; NUDE strips all body components.
function Character:StripClothingFromPed(level)
    for _, tag in ipairs(COMPONENT_TAG:Values()) do
        local hiddenTags = COMPONENT_TAG:GetHiddenTags(tag)
        if hiddenTags then
            for _, setting in ipairs(hiddenTags) do
                if setting == level then
                    local hash = COMPONENT_TAG:GetHash(tag)
                    if hash then
                        RemoveTagFromMetaPed(self.ped, hash, 0)
                    end
                    break
                end
            end
        end
    end

    self:ApplyBodyItems()
    self:RequestUpdate()
end

-- Restore the ped's clothing to the state it was in before any clothing level change.
function Character:RestoreClothingToPed()
    if Intro:IsFlagSet(INTRO_FLAG.IS_REROLLING) then
        if IsPedModel(Intro.playerPedId, `MP_MALE`) == 1 then
            ClonePedToTarget(Intro.playerPedId, Intro.presetPeds[EDITOR_CONFIG.MALE])
        else
            ClonePedToTarget(Intro.playerPedId, Intro.presetPeds[EDITOR_CONFIG.FEMALE])
        end
    else
        -- For the intro case the exact outfit items applied during MaintainApplyClothes
        -- were saved in savedOutfitItems, so we strip all clothing and re-apply them.
        for _, tag in ipairs(COMPONENT_TAG:Values()) do
            if COMPONENT_TAG:GetHiddenTags(tag) then
                local hash = COMPONENT_TAG:GetHash(tag)
                if hash then RemoveTagFromMetaPed(self.ped, hash, 0) end
            end
        end

        local items = Intro.savedOutfitItems[Intro.selectedPreset] or {}
        for _, item in ipairs(items) do
            ApplyShopItemToPed(self.ped, item, false, true, false)
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
        Character:ApplyBodyItems(value)
        Character:ApplyBodyExpressions(value)
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

CreateThread(function()
    while true do
        Character:Maintain()
        Wait(0)
    end
end)
