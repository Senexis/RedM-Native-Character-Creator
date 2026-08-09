CreatorRenderer = {
    swatches = {
        generated = false,
        entries = {},
    },
    subheaderOverride = nil,
    text = {},
    shouldPollGridX = false,
    shouldPollGridXY = false,
}

function CreatorRenderer:UpdateText()
    self:CreateNewText()

    if Creator:IsDefaultMode() then
        self:SetTextDefault()
    else
        self:SetTextAdvanced()
    end

    Wait(0)
end

function CreatorRenderer:CreateNewText()
    AddTextEntry("NATIVE_CREATOR_CONFIRM_TOOLTIP", "Go back to the previous menu. Use ~INPUT_GAME_MENU_LS~ to quickly switch between Basic and Advanced options.")

    AddTextEntry("NATIVE_CREATOR_RANDOMIZE_DEFAULT_TOOLTIP", "Hold ~INPUT_FRONTEND_ACCEPT~ to randomize Basic options.")
    AddTextEntry("NATIVE_CREATOR_RANDOMIZE_ADVANCED_TOOLTIP", "Hold ~INPUT_FRONTEND_ACCEPT~ to randomize Basic and select Advanced options.")

    AddTextEntry("NATIVE_CREATOR_ADVANCED_MENU_HEADING", "Advanced Menu")
    AddTextEntry("NATIVE_CREATOR_ADVANCED_OPTIONS_HEADING", "Advanced Options")

    AddTextEntry("NATIVE_CREATOR_ERROR_NAME_DISABLED", "~e~Go back to change your name.")
    AddTextEntry("NATIVE_CREATOR_ERROR_OVERLAY_LIMIT", "~e~Overlay limit reached.")

    AddTextEntry("NATIVE_CREATOR_HAIR_COLOR_TOOLTIP", "Change your character's hair and eyebrows color.")
    AddTextEntry("NATIVE_CREATOR_HEIGHT_TOOLTIP", "Adjust the height of your character.")
    AddTextEntry("NATIVE_CREATOR_WEIGHT_TOOLTIP", "Adjust the weight of your character.")
    AddTextEntry("NATIVE_CREATOR_SHOULDERS_TOOLTIP", "Change your character's shoulders and back.")
    AddTextEntry("NATIVE_CREATOR_LIMBS_TOOLTIP", "Change your character's limbs.")
    AddTextEntry("NATIVE_CREATOR_MOUTH_2_TOOLTIP", "Change your character's mouth.")
    AddTextEntry("NATIVE_CREATOR_TORSO_TOOLTIP", "Change your character's torso.")
    AddTextEntry("NATIVE_CREATOR_FACE_TOOLTIP", "Change your character's face.")
    AddTextEntry("NATIVE_CREATOR_NECK_TOOLTIP", "Change your character's neck.")
    AddTextEntry("NATIVE_CREATOR_HEAD_HAIR_TOOLTIP", "Only visible when your character is bald.")
    AddTextEntry("NATIVE_CREATOR_AGEING_TOOLTIP", "Tweaks the aging layer used on your character.")

    AddTextEntry("NATIVE_CREATOR_SHOULDERS_00", "Neutral")
    AddTextEntry("NATIVE_CREATOR_LIMBS_00", "Neutral")
    AddTextEntry("NATIVE_CREATOR_MOUTH_2_00", "Neutral")
    AddTextEntry("NATIVE_CREATOR_TORSO_00", "Neutral")
    AddTextEntry("NATIVE_CREATOR_FACE_00", "Neutral")
    AddTextEntry("NATIVE_CREATOR_NECK_00", "Neutral")

    for _, height in ipairs(CreatorConfig.Heights) do
        if height.label then AddTextEntry(height.id, height.label) end
    end

    for _, weight in ipairs(CreatorConfig.Weights) do
        if weight.label then AddTextEntry(weight.id, weight.label) end
    end

    for _, voice in ipairs(CreatorConfig.Voices) do
        if voice.label then AddTextEntry(voice.id, voice.label) end
    end

    for _, hair in ipairs(CreatorConfig.CustomMaleHairs) do
        if hair.label then AddTextEntry(hair.id, hair.label) end
    end

    for _, hair in ipairs(CreatorConfig.CustomFemaleHairs) do
        if hair.label then AddTextEntry(hair.id, hair.label) end
    end

    for _, beard in ipairs(CreatorConfig.CustomMaleBeards) do
        if beard.label then AddTextEntry(beard.id, beard.label) end
    end

    for _, layer in pairs(CreatorConfig.Overlays) do
        for _, overlay in ipairs(layer) do
            if overlay.label then AddTextEntry(overlay.id, overlay.label) end
        end
    end

    AddTextEntry("NATIVE_CREATOR_VOICE_HEADING", "VOICE")
    AddTextEntry("NATIVE_CREATOR_VOICE_TOOLTIP", "Adjust how your character's voice sounds.")
    AddTextEntry("NATIVE_CREATOR_VOICE_STYLE_TOOLTIP", "Choose a voice style.")

    AddTextEntry("NATIVE_CREATOR_SHOULDERS_HEADING", "SHOULDERS & BACK")
    AddTextEntry("NATIVE_CREATOR_LIMBS_HEADING", "LIMBS")
    AddTextEntry("NATIVE_CREATOR_MOUTH_2_HEADING", "MOUTH")
    AddTextEntry("NATIVE_CREATOR_TORSO_HEADING", "TORSO")
    AddTextEntry("NATIVE_CREATOR_FACE_HEADING", "FACE")
    AddTextEntry("NATIVE_CREATOR_NECK_HEADING", "NECK")
    AddTextEntry("NATIVE_CREATOR_LIFESTYLE_2_HEADING", "LIFESTYLE")

    AddTextEntry("NATIVE_CREATOR_GRID_TEXT_EYELID_CLOSED", "Closed")
    AddTextEntry("NATIVE_CREATOR_GRID_TEXT_EYELID_OPEN", "Open")
    AddTextEntry("NATIVE_CREATOR_GRID_TEXT_VOLUME_FLAT", "Flat")
    AddTextEntry("NATIVE_CREATOR_GRID_TEXT_VOLUME_FULL", "Full")
    AddTextEntry("NATIVE_CREATOR_GRID_TEXT_SAG_HIGH", "Perky")
    AddTextEntry("NATIVE_CREATOR_GRID_TEXT_SAG_LOW", "Sagging")
end

function CreatorRenderer:SetTextDefault()
    AddTextEntry("CHAR_CREATOR_CONFIRM", "Back")

    AddTextEntry("CHAR_CREATOR_WHISTLE_TITLE", "Whistle")
    AddTextEntry("CHAR_CREATOR_WHISTLE_STYLE", "Style")
    AddTextEntry("CHAR_CREATOR_WHISTLE_PROMPT", "Whistle")

    AddTextEntry("CHAR_CREATOR_BODY_PAGE_BUILD_OPTION", "Body Build")
    AddTextEntry("CHAR_CREATOR_EYEBROWS", "Eyebrows")

    AddTextEntry("CHAR_CREATOR_EYES_AND_BROWS_LABEL", "Eyes & Brows")
    AddTextEntry("CHAR_CREATOR_NOSE_LABEL", "Nose")
    AddTextEntry("CHAR_CREATOR_MOUTH_AND_LIPS_LABEL", "Mouth & Lips")
    AddTextEntry("CHAR_CREATOR_JAW_AND_CHIN_LABEL", "Jaw & Chin")
    AddTextEntry("CHAR_CREATOR_EARS_LABEL", "Ears")
    AddTextEntry("CHAR_CREATOR_CHEEKS_LABEL", "Cheeks")

    AddTextEntry("CHAR_CREATOR_BROW_SHAPE", "Brow Shape")
    AddTextEntry("CHAR_CREATOR_BROW_DEPTH", "Brow Depth")
    AddTextEntry("CHAR_CREATOR_EYE_SIZE", "Eye Size")

    AddTextEntry("CHAR_CREATOR_NOSE_OPTION", "Nose Size")
    AddTextEntry("CHAR_CREATOR_NOSE_SHAPE", "Nose Shape")

    AddTextEntry("CHAR_CREATOR_MOUTH", "Mouth")
    AddTextEntry("CHAR_CREATOR_MOUTH_POSITION", "Mouth Position")
    AddTextEntry("CHAR_CREATOR_UPPER_LIP_SHAPE", "Upper Lip Shape")
    AddTextEntry("CHAR_CREATOR_LOWER_LIP_SHAPE", "Lower Lip Shape")
    AddTextEntry("CHAR_CREATOR_LIPS_DEPTH", "Lips Depth")

    AddTextEntry("CHAR_CREATOR_JAW_SHAPE", "Jaw Shape")
    AddTextEntry("CHAR_CREATOR_JAW_DEPTH", "Jaw Depth")
    AddTextEntry("CHAR_CREATOR_CHIN_SHAPE", "Chin Shape")
    AddTextEntry("CHAR_CREATOR_CHIN_DEPTH", "Chin Depth")

    AddTextEntry("CHAR_CREATOR_EAR_SHAPE", "Ear Shape")
    AddTextEntry("CHAR_CREATOR_EAR_SIZE", "Ear Size")

    AddTextEntry("CHAR_CREATOR_CHEEK_SHAPE", "Cheek Shape")

    AddTextEntry("CHAR_CREATOR_SKIN_MOTTLING", "Skin Mottling")
    AddTextEntry("CHAR_CREATOR_COMPLEXION", "Complexion")
    AddTextEntry("CHAR_CREATOR_COMPLEXION_2", "Complexion 2")
    AddTextEntry("CHAR_CREATOR_FRECKLES", "Freckles")
    AddTextEntry("CHAR_CREATOR_MOLES", "Moles")
end

function CreatorRenderer:SetTextAdvanced()
    AddTextEntry("CHAR_CREATOR_CONFIRM", "Back")

    AddTextEntry("CHAR_CREATOR_WHISTLE_TITLE", "Voice")
    AddTextEntry("CHAR_CREATOR_WHISTLE_STYLE", "Style")
    AddTextEntry("CHAR_CREATOR_WHISTLE_PROMPT", "Preview")

    AddTextEntry("CHAR_CREATOR_BODY_PAGE_BUILD_OPTION", "Height")
    AddTextEntry("CHAR_CREATOR_EYEBROWS", "Weight")

    AddTextEntry("CHAR_CREATOR_EYES_AND_BROWS_LABEL", "Shoulders & Back")
    AddTextEntry("CHAR_CREATOR_NOSE_LABEL", "Limbs")
    AddTextEntry("CHAR_CREATOR_MOUTH_AND_LIPS_LABEL", "Mouth")
    AddTextEntry("CHAR_CREATOR_JAW_AND_CHIN_LABEL", "Torso")
    AddTextEntry("CHAR_CREATOR_EARS_LABEL", "Face")
    AddTextEntry("CHAR_CREATOR_CHEEKS_LABEL", "Neck")

    AddTextEntry("CHAR_CREATOR_BROW_SHAPE", "Shoulder Frame")
    AddTextEntry("CHAR_CREATOR_BROW_DEPTH", "Shoulder Height")
    AddTextEntry("CHAR_CREATOR_EYE_SIZE", "Upper Back")

    AddTextEntry("CHAR_CREATOR_NOSE_OPTION", "Arms Size")
    AddTextEntry("CHAR_CREATOR_NOSE_SHAPE", "Legs Size")

    AddTextEntry("CHAR_CREATOR_MOUTH", "Corner Width")
    AddTextEntry("CHAR_CREATOR_MOUTH_POSITION", "Mouth Position")
    AddTextEntry("CHAR_CREATOR_UPPER_LIP_SHAPE", "Corner Depth")
    AddTextEntry("CHAR_CREATOR_LOWER_LIP_SHAPE", "Corner Height")
    AddTextEntry("CHAR_CREATOR_LIPS_DEPTH", "Corner Separation")

    AddTextEntry("CHAR_CREATOR_JAW_SHAPE", "Chest Size")
    AddTextEntry("CHAR_CREATOR_JAW_DEPTH", "Chest Sag")
    AddTextEntry("CHAR_CREATOR_CHIN_SHAPE", "Midsection")
    AddTextEntry("CHAR_CREATOR_CHIN_DEPTH", "Glutes")

    AddTextEntry("CHAR_CREATOR_EAR_SHAPE", "Shape")
    AddTextEntry("CHAR_CREATOR_EAR_SIZE", "Eyelids")

    AddTextEntry("CHAR_CREATOR_CHEEK_SHAPE", "Shape")

    AddTextEntry("CHAR_CREATOR_SKIN_MOTTLING", "Grime")
    AddTextEntry("CHAR_CREATOR_COMPLEXION", "Aging")
    AddTextEntry("CHAR_CREATOR_COMPLEXION_2", "Hair Stubble")
    AddTextEntry("CHAR_CREATOR_FRECKLES", "Scar 2")
    AddTextEntry("CHAR_CREATOR_MOLES", "Facial Hair")
end

function CreatorRenderer:UpdateHeaderLabel(header)
    CreatorDatabinding:WriteHash(DATABINDING_ID.ROOT__HEADER__TITLE, header)
end

function CreatorRenderer:UpdateSubheaderLabel(subheader)
    if self.subheaderOverride then
        CreatorDatabinding:WriteHash(DATABINDING_ID.ROOT__HEADER__SUBTITLE, self.subheaderOverride)
    else
        CreatorDatabinding:WriteHash(DATABINDING_ID.ROOT__HEADER__SUBTITLE, subheader)
    end
end

function CreatorRenderer:UpdateSubheaderOverride(pageId)
    if pageId == UI_PAGE_ID.EYES then
        local preset = CreatorDatabinding:ReadInt(DATABINDING_ID.APPEARANCE__EYES_PRESET__VALUE)
        local label = Creator:IsDefaultMode() and "EXPRESSION_PRESET_EYES_%02d" or "NATIVE_CREATOR_SHOULDERS_%02d"
        self.subheaderOverride = string.format(label, preset)
    elseif pageId == UI_PAGE_ID.NOSE then
        local preset = CreatorDatabinding:ReadInt(DATABINDING_ID.APPEARANCE__NOSE_PRESET__VALUE)
        local label = Creator:IsDefaultMode() and "EXPRESSION_PRESET_NOSE_%02d" or "NATIVE_CREATOR_LIMBS_%02d"
        self.subheaderOverride = string.format(label, preset)
    elseif pageId == UI_PAGE_ID.MOUTH then
        local preset = CreatorDatabinding:ReadInt(DATABINDING_ID.APPEARANCE__MOUTH_PRESET__VALUE)
        local label = Creator:IsDefaultMode() and "EXPRESSION_PRESET_MOUTH_%02d" or "NATIVE_CREATOR_MOUTH_2_%02d"
        self.subheaderOverride = string.format(label, preset)
    elseif pageId == UI_PAGE_ID.JAW then
        local preset = CreatorDatabinding:ReadInt(DATABINDING_ID.APPEARANCE__JAW_PRESET__VALUE)
        local label = Creator:IsDefaultMode() and "EXPRESSION_PRESET_JAW_%02d" or "NATIVE_CREATOR_TORSO_%02d"
        self.subheaderOverride = string.format(label, preset)
    elseif pageId == UI_PAGE_ID.EARS then
        local preset = CreatorDatabinding:ReadInt(DATABINDING_ID.APPEARANCE__EARS_PRESET__VALUE)
        local label = Creator:IsDefaultMode() and "EXPRESSION_PRESET_EARS_%02d" or "NATIVE_CREATOR_FACE_%02d"
        self.subheaderOverride = string.format(label, preset)
    elseif pageId == UI_PAGE_ID.CHEEKS then
        local preset = CreatorDatabinding:ReadInt(DATABINDING_ID.APPEARANCE__CHEEKS_PRESET__VALUE)
        local label = Creator:IsDefaultMode() and "EXPRESSION_PRESET_CHEEKS_%02d" or "NATIVE_CREATOR_NECK_%02d"
        self.subheaderOverride = string.format(label, preset)
    else
        self.subheaderOverride = nil
    end
end

function CreatorRenderer:UpdateFooterLabel(footer)
    local label = GetStringFromHashKey(footer)
    if label == "" then label = footer end

    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__FOOTER__LABEL, label)
end

function CreatorRenderer:UpdateOverlayFooterLabel(footer)
    local label = GetStringFromHashKey(footer)
    if label == "" then label = footer end

    local suffix = CharacterOverlay:GetFooterSuffix()
    label = string.format("%s %s", label, suffix)

    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__FOOTER__LABEL, label)
end

function CreatorRenderer:UpdateDetailImage(image)
    if not image then
        CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__DETAILS_IMAGE__ENABLED, false)
    else
        CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__DETAILS_IMAGE__ENABLED, true)
        CreatorDatabinding:WriteHash(DATABINDING_ID.ROOT__DETAILS_IMAGE__TEXTURE, image)
    end
end

function CreatorRenderer:UpdateItemFooter(itemId)
    local databinding = UI_ITEM_ID:GetDatabinding(itemId)
    if not databinding then return end

    local uiData = UI_ITEM_ID:GetUi(itemId)
    if not uiData then return end

    CreatorRenderer:UpdateDetailImage(uiData.Image)

    if UI_ITEM_ID:GetOverlayLayer(itemId) then
        if databinding.Enabled and CreatorDatabinding:ReadBool(databinding.Enabled) ~= true then
            CreatorRenderer:UpdateFooterLabel("NATIVE_CREATOR_ERROR_OVERLAY_LIMIT")
        else
            CreatorRenderer:UpdateOverlayFooterLabel(uiData.Footer)
        end
    else
        CreatorRenderer:UpdateFooterLabel(uiData.Footer)
    end
end

function CreatorRenderer:ShowColorSwatch(itemId)
    local label = UI_ITEM_ID:GetSwatchLabel(itemId)
    if not label then return end

    local databind = UI_ITEM_ID:GetDatabinding(itemId)
    if not databind then return end

    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__COLOR_SWATCH__VISIBLE, true)
    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__COLOR_SWATCH__TITLE, label or "")

    local textures = self:GetSwatchTextures(itemId)
    CreatorDatabinding:WriteColorSwatches(textures)

    local value = CreatorDatabinding:ReadInt(databind.Value)
    CreatorRenderer:UpdateColorSwatch(itemId, value)
end

function CreatorRenderer:UpdateColorSwatch(itemId, value)
    local databinding = UI_ITEM_ID:GetDatabinding(itemId)
    if not databinding then return end

    local textures = self:GetSwatchTextures(itemId)
    if #textures < 1 then return end

    local normalized = value % #textures
    local texture = textures[normalized + 1]
    if not texture then return end

    CreatorDatabinding:WriteInt(DATABINDING_ID.ROOT__COLOR_SWATCH__FOCUSED_INDEX, normalized)
    CreatorDatabinding:WriteInt(databinding.Value, normalized)
    CreatorDatabinding:WriteString(databinding.Txd, texture.dict or "")
    CreatorDatabinding:WriteString(databinding.Txn, texture.texture or "")
end

function CreatorRenderer:HideColorSwatch()
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__COLOR_SWATCH__VISIBLE, false)
    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__COLOR_SWATCH__TITLE, "")
    CreatorDatabinding:WriteInt(DATABINDING_ID.ROOT__COLOR_SWATCH__FOCUSED_INDEX, 0)
end

function CreatorRenderer:ShowGrid(itemId)
    local itemType = UI_ITEM_ID:GetType(itemId)
    if not itemType then return end

    local labels = UI_ITEM_ID:GetGridLabels(itemId)
    if not labels then return end

    local databinding = UI_ITEM_ID:GetDatabinding(itemId)
    if not databinding then return end

    local overlayLayer = UI_ITEM_ID:GetOverlayLayer(itemId)
    if overlayLayer and databinding.Value then
        local overlay = CreatorDatabinding:ReadInt(databinding.Value)
        local blend = CharacterOverlay:GetLayerBlend(overlayLayer, overlay + 1)
        if blend == "BLEND_NONE" then return end
    end

    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__GRID__X_VISIBLE, itemType == UI_ITEM_TYPE.GRID_X)
    CreatorRenderer.shouldPollGridX = itemType == UI_ITEM_TYPE.GRID_X

    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__GRID__XY_VISIBLE, itemType == UI_ITEM_TYPE.GRID_XY)
    CreatorRenderer.shouldPollGridXY = itemType == UI_ITEM_TYPE.GRID_XY

    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__GRID__LEFT_LABEL, labels.Left or "")
    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__GRID__RIGHT_LABEL, labels.Right or "")
    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__GRID__TOP_LABEL, labels.Top or "")
    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__GRID__BOTTOM_LABEL, labels.Bottom or "")
end

function CreatorRenderer:UpdateGrid(itemId)
    local valueX, valueY = 0.0, 0.0
    local expressions = UI_ITEM_ID:GetExpressions(itemId)
    local overlayLayer = UI_ITEM_ID:GetOverlayLayer(itemId)

    if itemId == UI_ITEM_ID.LIFESTYLE__EYE_REDNESS then
        valueX = Character.weariness or 0.0
    elseif expressions then
        if expressions.ExpressionX then
            valueX = Character:GetExpressionUiValue(expressions.ExpressionX) or 0.0
        end
        if expressions.ExpressionY then
            valueY = Character:GetExpressionUiValue(expressions.ExpressionY) or 0.0
        end
    elseif overlayLayer then
        local overlay = Character:GetOverlay(overlayLayer)
        valueX = overlay.alpha or 0.0
    end

    CreatorDatabinding:WriteFloat(DATABINDING_ID.ROOT__GRID__X_VALUE, valueX or 0.0)
    CreatorDatabinding:WriteFloat(DATABINDING_ID.ROOT__GRID__Y_VALUE, valueY or 0.0)
end

function CreatorRenderer:HideGrid()
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__GRID__X_VISIBLE, false)
    CreatorRenderer.shouldPollGridX = false

    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__GRID__XY_VISIBLE, false)
    CreatorRenderer.shouldPollGridXY = false

    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__GRID__LEFT_LABEL, "")
    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__GRID__RIGHT_LABEL, "")
    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__GRID__TOP_LABEL, "")
    CreatorDatabinding:WriteString(DATABINDING_ID.ROOT__GRID__BOTTOM_LABEL, "")
end

function CreatorRenderer:RequestSwatchTextures()
    self.swatches.generated = false
    self.swatches.entries = {}

    DestroySwatchTextureDict()

    local config = {
        SKIN_TONE       = self:GetSkintoneSwatches(),
        EYE_COLOR       = self:GetEyeSwatches(),
        HAIR_COLOR      = self:GetHairSwatches(),
        BEARD_COLOR     = self:GetBeardSwatches(),
        EYESHADOW_COLOR = self:GetOverlaySwatches(OVERLAY_LAYER.EYESHADOW),
        LIPSTICK_COLOR  = self:GetOverlaySwatches(OVERLAY_LAYER.LIPSTICK),
    }

    local entryId = 0
    local entries = {}

    for categoryKey, categoryItems in pairs(config) do
        entries[categoryKey] = {}
        for itemKey, itemData in pairs(categoryItems) do
            if type(itemData) == "table" then
                entryId = entryId + 1
                entries[categoryKey][#entries[categoryKey] + 1] = {
                    blend = itemKey,
                    entry = entryId,
                    directly = true,
                    swatch = itemData.swatch,
                    palette = itemData.palette,
                    tint0 = itemData.tint0,
                    tint1 = itemData.tint1,
                    tint2 = itemData.tint2,
                    dict = "SwatchTxd",
                    texture = string.format("slot%02d", entryId),
                }
            elseif type(itemData) == "string" or type(itemData) == "number" then
                entryId = entryId + 1
                entries[categoryKey][#entries[categoryKey] + 1] = {
                    blend = itemData,
                    entry = entryId,
                    directly = false,
                    component = joaat(itemData),
                    dict = "SwatchTxd",
                    texture = string.format("slot%02d", entryId),
                }
            else
                error(string.format("Invalid swatch configuration for %s - %s", categoryKey, itemKey))
            end
        end
    end

    if CreateSwatchTextureDict(entryId + 1) ~= 1 then
        return false
    end

    for _, categoryItems in pairs(entries) do
        for _, itemData in pairs(categoryItems) do
            if itemData.directly == true then
                local swatch = VarString(10, "LITERAL_STRING", itemData.swatch);
                local palette = VarString(10, "LITERAL_STRING", itemData.palette);

                local struct = DataView.ArrayBuffer(128)
                struct:SetInt64(1 * 8, swatch)
                struct:SetInt64(2 * 8, palette)
                struct:SetUint8(3 * 8, itemData.tint0)
                struct:SetUint8(4 * 8, itemData.tint1)
                struct:SetUint8(5 * 8, itemData.tint2)

                -- GENERATE_SWATCH_TEXTURE_DIRECTLY
                local ok, error = pcall(Citizen.InvokeNative, 0x646ED1A1D28487DF, itemData.entry, struct:Buffer())
                if not ok then
                    Utils:Debug(string.format("Failed to generate direct swatch texture for entry %d: %s", itemData.entry, error))
                end
            else
                local pedType = Character:GetPedType()

                -- GENERATE_SWATCH_TEXTURE
                local ok, error = pcall(GenerateSwatchTexture, itemData.entry, itemData.component, pedType, true)
                if not ok then
                    Utils:Debug(string.format("Failed to generate component swatch texture for entry %d: %s", itemData.entry, error))
                end
            end

            Wait(0)
        end
    end

    self.swatches.generated = true
    self.swatches.entries = entries

    return true
end

function CreatorRenderer:GetSwatchTextures(itemId)
    local entries = {}

    if itemId == UI_ITEM_ID.APPEARANCE__SKIN_TONE then
        entries = self.swatches.entries.SKIN_TONE or {}
    elseif itemId == UI_ITEM_ID.APPEARANCE__EYE_COLOR then
        entries = self.swatches.entries.EYE_COLOR or {}
    elseif itemId == UI_ITEM_ID.HAIR__HAIR_COLOR then
        entries = self.swatches.entries.HAIR_COLOR or {}
    elseif itemId == UI_ITEM_ID.HAIR__BEARD_COLOR then
        entries = self.swatches.entries.BEARD_COLOR or {}
    elseif itemId == UI_ITEM_ID.MAKEUP__EYESHADOW_COLOR then
        entries = self.swatches.entries.EYESHADOW_COLOR or {}
    elseif itemId == UI_ITEM_ID.MAKEUP__LIPSTICK_COLOR then
        entries = self.swatches.entries.LIPSTICK_COLOR or {}
    end

    local parentItemId = UI_ITEM_ID:GetIdFromSwatchItem(itemId)
    if parentItemId then
        local parentDatabinding = UI_ITEM_ID:GetDatabinding(parentItemId)
        if not parentDatabinding then return {} end

        local parentOverlayLayer = UI_ITEM_ID:GetOverlayLayer(parentItemId)
        if not parentOverlayLayer then return {} end

        local value = CreatorDatabinding:ReadInt(parentDatabinding.Value)
        local blend = CharacterOverlay:GetLayerBlend(parentOverlayLayer, value + 1)
        if blend == "BLEND_NONE" then return {} end

        local colors = CharacterOverlay:GetLayerColors(parentOverlayLayer, blend)
        if #colors == 0 then return {} end

        local filtered = {}
        for _, entry in ipairs(entries) do
            for index, color in ipairs(colors) do
                if entry.blend == color then
                    filtered[index] = entry
                end
            end
        end

        entries = filtered
    end

    if #entries < 1 then
        return {}
    end

    local swatches = {}
    for _, entry in ipairs(entries) do
        swatches[#swatches + 1] = { dict = entry.dict, texture = entry.texture }
    end

    return swatches
end

function CreatorRenderer:GetHeritageLabels()
    local heritages = CreatorPresets:GetHeritages()
    local labels = {}

    for _, heritage in ipairs(heritages) do
        labels[#labels + 1] = heritage.id
    end

    return labels
end

function CreatorRenderer:GetSkintoneSwatches()
    local skintones = CreatorPresets:GetSkintones()
    local components = {}

    for _, skintone in ipairs(skintones) do
        components[#components + 1] = skintone.id
    end

    return components
end

function CreatorRenderer:GetBodyBuildLabels()
    local builds = Character:IsMale() and CreatorConfig.MaleBodyBuilds or CreatorConfig.FemaleBodyBuilds
    local labels = {}

    for _, build in pairs(builds) do
        labels[#labels + 1] = build.id
    end

    return labels
end

function CreatorRenderer:GetPresetLabels(zone)
    local labels = {}

    if PED_EXPRESSION_ZONE:GetQuery(zone) then
        local presets = CreatorPresets:GetExpressionZonePresets(zone)
        for _, preset in ipairs(presets) do
            labels[#labels + 1] = preset.id
        end
    else
        local format = "NATIVE_CREATOR_%s_%02d"
        local name = PED_EXPRESSION_ZONE:GetName(zone)
        labels[#labels + 1] = string.format(format, name, 0)
    end

    return labels
end

function CreatorRenderer:GetHairLabels()
    local gender = Character:GetGenderShort()
    local hairs = {}
    local custom = {}

    if Character:IsMale() then
        hairs = CreatorConfig.MaleHairs
        custom = CreatorConfig.CustomMaleHairs
    else
        hairs = CreatorConfig.FemaleHairs
        custom = CreatorConfig.CustomFemaleHairs
    end

    local labels = {}
    for _, item in ipairs(hairs) do
        if item == "NONE" then
            labels[#labels + 1] = "CLOTHING_ITEM_HAIR_NONE"
        else
            labels[#labels + 1] = string.format("BARBER_STYLE_%s_HAIR_%03d_PAGE", gender, item)
        end
    end

    for _, item in ipairs(custom) do
        labels[#labels + 1] = item.id
    end

    return labels
end

function CreatorRenderer:GetHairSwatches()
    local gender = Character:GetGenderShort()

    local components = {}
    for _, item in ipairs(CreatorConfig.HairColors) do
        components[#components + 1] = string.format("CLOTHING_ITEM_%s_HAIR_%03d_%s", gender, 1, item)
    end

    return components
end

function CreatorRenderer:GetBeardLabels()
    if Character:IsFemale() then return {} end

    local labels = {}
    for _, item in ipairs(CreatorConfig.MaleBeards) do
        if item == "NONE" then
            labels[#labels + 1] = "CLOTHING_ITEM_BEARD_NONE"
        else
            labels[#labels + 1] = string.format("BARBER_STYLE_M_BEARD_%03d_PAGE", item)
        end
    end

    for _, item in ipairs(CreatorConfig.CustomMaleBeards) do
        labels[#labels + 1] = item.id
    end

    return labels
end

function CreatorRenderer:GetBeardSwatches()
    if Character:IsFemale() then return {} end

    local components = {}
    for _, color in ipairs(CreatorConfig.HairColors) do
        components[#components + 1] = string.format("CLOTHING_ITEM_M_BEARD_%03d_%s", 1, color)
    end

    return components
end

function CreatorRenderer:GetTeethLabels()
    local gender = Character:GetGenderShort()

    local labels = {}
    for _, item in ipairs(CreatorConfig.Teeth) do
        labels[#labels + 1] = string.format("CLOTHING_ITEM_%s_TEETH_%03d", gender, item)
    end

    return labels
end

function CreatorRenderer:GetEyeSwatches()
    local gender = Character:GetGenderShort()

    local components = {}
    for _, item in ipairs(CreatorConfig.Eyes) do
        components[#components + 1] = string.format("CLOTHING_ITEM_%s_EYES_001_TINT_%03d", gender, item)
    end

    return components
end

function CreatorRenderer:GetWhistleLabels()
    local labels = {}
    for _, item in ipairs(CreatorConfig.Whistles) do
        labels[#labels + 1] = string.format("CHAR_CREATOR_WHISTLE_STYLE_%d", item)
    end

    return labels
end

function CreatorRenderer:GetHeightLabels()
    local labels = {}
    for _, item in ipairs(CreatorConfig.Heights) do
        labels[#labels + 1] = item.id
    end

    return labels
end

function CreatorRenderer:GetWeightLabels()
    local labels = {}
    for _, item in ipairs(CreatorConfig.Weights) do
        labels[#labels + 1] = item.id
    end

    return labels
end

function CreatorRenderer:GetVoiceLabels()
    local labels = {}
    for _, item in ipairs(CreatorConfig.Voices) do
        labels[#labels + 1] = item.id
    end

    return labels
end

function CreatorRenderer:GetOverlayLabels(layer)
    local overlay = CreatorConfig.Overlays[layer]
    if not overlay then
        error(string.format("Invalid layer: %s", layer))
    end

    local labels = { [1] = "CHAR_CREATOR_LAYER_NONE" }
    for index, data in pairs(overlay) do
        if not data.id then
            error(string.format("Item %s in layer %s is missing an ID", index, layer))
        end

        local label = data.id
        if layer == OVERLAY_LAYER.EYEBROWS or layer == OVERLAY_LAYER.HEAD_HAIR then
            label = string.format(label, Character:GetHairColorString())
        elseif layer == OVERLAY_LAYER.FACIAL_HAIR then
            label = string.format(label, Character:GetBeardColorString())
        end

        if not data.gender or data.gender == Character:GetGenderShort() then
            labels[#labels + 1] = label
        end
    end

    return labels
end

function CreatorRenderer:GetOverlayLabel(layer, index)
    local labels = self:GetOverlayLabels(layer)

    local label = labels[index]
    if not label then
        error(string.format("No label found for index %s in layer %s", index, layer))
    end

    return label
end

function CreatorRenderer:GetOverlaySwatches(layer)
    if Character:IsMale() then return {} end

    local layerColors = CharacterOverlay:GetLayerColors(layer)

    local swatches = {}
    for layerBlend, layerColor in pairs(layerColors) do
        if layerBlend == "BLEND_NONE" then goto continue end

        for _, colorBlend in ipairs(layerColor) do
            if colorBlend == "BLEND_NONE" then goto continue end

            local data = CharacterBlends:Get(layer, colorBlend)
            if not data.palette or data.palette == 0 then
                error(string.format("No palette found for blend %s in layer %s, skipping swatch generation", colorBlend, layer))
            end

            swatches[colorBlend] = {
                swatch = "UISW_FLAT_CK000",
                palette = data.palette,
                tint0 = data.tint0,
                tint1 = data.tint1,
                tint2 = data.tint2,
            }

            ::continue::
        end

        ::continue::
    end

    return swatches
end

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    CreatorRenderer:UpdateText()
end)
