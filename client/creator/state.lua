CreatorState = {
    mode = CREATOR_MODE.DEFAULT,
    currentPage = 0,
    currentFocusedItem = 0,
    isZooming = false,
    pageCamera = nil,
    isRotatingLeft = false,
    isRotatingRight = false,
    currentGridXValue = 0.0,
    currentGridYValue = 0.0,
    shouldPollGridX = false,
    shouldPollGridXY = false,
    shouldHideBeard = false,
}

function CreatorState:Maintain()
    -- Zooming isn't handled through events anymore
    if CreatorState.isZooming == false and IsControlPressed(2, "INPUT_INSPECT_ZOOM") then
        CreatorState.isZooming = true
        SignalBus:emit("zoom_updated", true)
    elseif CreatorState.isZooming == true and not IsControlPressed(2, "INPUT_INSPECT_ZOOM") then
        CreatorState.isZooming = false
        SignalBus:emit("zoom_updated", false)
    end

    -- Poll the X grid of the currently focused item if we should
    if CreatorState.shouldPollGridX or CreatorState.shouldPollGridXY then
        -- Check if the focused item is a grid item
        local focusedItem = UI_ITEM_ID:GetIdFromHash(self.currentFocusedItem)
        if not focusedItem or focusedItem == UI_ITEM_ID.INVALID then
            goto skip_x
        end

        local itemType = UI_ITEM_ID:GetType(focusedItem)
        if itemType ~= UI_ITEM_TYPE.GRID_X and itemType ~= UI_ITEM_TYPE.GRID_XY then
            goto skip_x
        end

        -- Update the X value
        local gridXValue = CreatorDatabinding:ReadFloat(DATABINDING_ID.ROOT__GRID__X_VALUE)

        -- Only trigger events if the value changes
        if CreatorState.currentGridXValue ~= gridXValue then
            CreatorState.currentGridXValue = gridXValue
            SignalBus:emit("grid_x_changed", focusedItem, gridXValue)
        end

        ::skip_x::
    end

    -- Poll the Y grid of the currently focused item if we should
    if CreatorState.shouldPollGridXY then
        -- Check if the focused item is a grid item
        local focusedItem = UI_ITEM_ID:GetIdFromHash(self.currentFocusedItem)
        if not focusedItem or focusedItem == UI_ITEM_ID.INVALID then
            goto skip_xy
        end

        local itemType = UI_ITEM_ID:GetType(focusedItem)
        if itemType ~= UI_ITEM_TYPE.GRID_XY then
            goto skip_xy
        end

        -- Update the Y value
        local gridYValue = CreatorDatabinding:ReadFloat(DATABINDING_ID.ROOT__GRID__Y_VALUE)

        -- Only trigger events if the value changes
        if CreatorState.currentGridYValue ~= gridYValue then
            CreatorState.currentGridYValue = gridYValue
            SignalBus:emit("grid_y_changed", focusedItem, gridYValue)
        end

        ::skip_xy::
    end
end

function CreatorState:SetMode(mode)
    self.mode = mode
    CreatorRenderer:UpdateText()
end

function CreatorState:GetMode()
    return self.mode
end

function CreatorState:IsDefaultMode()
    return self.mode == CREATOR_MODE.DEFAULT
end

function CreatorState:IsAdvancedMode()
    return self.mode == CREATOR_MODE.ADVANCED
end

function CreatorState:GetHeritageLabels()
    local heritages = CreatorPresets:GetHeritages()
    local labels = {}

    for _, heritage in ipairs(heritages) do
        labels[#labels + 1] = heritage.id
    end

    return labels
end

function CreatorState:GetSkintoneSwatches()
    local skintones = CreatorPresets:GetSkintones()
    local components = {}

    for _, skintone in ipairs(skintones) do
        components[#components + 1] = skintone.id
    end

    return components
end

function CreatorState:GetBodyBuildLabels()
    local builds = CreatorPresets:GetBodyBuilds()
    local labels = {}

    for _, build in pairs(builds) do
        labels[#labels + 1] = build.id
    end

    return labels
end

function CreatorState:GetPresetLabels(zone)
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

function CreatorState:GetHairLabels()
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

function CreatorState:GetHairSwatches()
    local gender = Character:GetGenderShort()

    local components = {}
    for _, item in ipairs(CreatorConfig.HairColors) do
        components[#components + 1] = string.format("CLOTHING_ITEM_%s_HAIR_%03d_%s", gender, 1, item)
    end

    return components
end

function CreatorState:GetBeardLabels()
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

function CreatorState:GetBeardSwatches()
    if Character:IsFemale() then return {} end

    local components = {}
    for _, color in ipairs(CreatorConfig.HairColors) do
        components[#components + 1] = string.format("CLOTHING_ITEM_M_BEARD_%03d_%s", 1, color)
    end

    return components
end

function CreatorState:GetTeethLabels()
    local gender = Character:GetGenderShort()

    local labels = {}
    for _, item in ipairs(CreatorConfig.Teeth) do
        labels[#labels + 1] = string.format("CLOTHING_ITEM_%s_TEETH_%03d", gender, item)
    end

    return labels
end

function CreatorState:GetEyeSwatches()
    local gender = Character:GetGenderShort()

    local components = {}
    for _, item in ipairs(CreatorConfig.Eyes) do
        components[#components + 1] = string.format("CLOTHING_ITEM_%s_EYES_001_TINT_%03d", gender, item)
    end

    return components
end

function CreatorState:GetWhistleLabels()
    local labels = {}
    for _, item in ipairs(CreatorConfig.Whistles) do
        labels[#labels + 1] = string.format("CHAR_CREATOR_WHISTLE_STYLE_%d", item)
    end

    return labels
end

function CreatorState:GetHeightLabels()
    local labels = {}
    for _, item in ipairs(CreatorConfig.Heights) do
        labels[#labels + 1] = item.id
    end

    return labels
end

function CreatorState:GetWeightLabels()
    local labels = {}
    for _, item in ipairs(CreatorConfig.Weights) do
        labels[#labels + 1] = item.id
    end

    return labels
end

function CreatorState:GetVoiceLabels()
    local labels = {}
    for _, item in ipairs(CreatorConfig.Voices) do
        labels[#labels + 1] = item.id
    end

    return labels
end

function CreatorState:GetOverlayLabels(layer)
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

function CreatorState:GetOverlayLabel(layer, index)
    local labels = self:GetOverlayLabels(layer)

    local label = labels[index]
    if not label then
        error(string.format("No label found for index %s in layer %s", index, layer))
    end

    return label
end

function CreatorState:GetOverlaySwatches(layer)
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
