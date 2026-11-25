CharacterMigrations = {}

local NONE <const> = "NONE"

local function getOptionId(list, option, key)
    option = tonumber(option)
    if not option then return nil end

    local entry = list[option + 1]
    if entry == nil then return nil end
    if key == nil then return entry end
    return entry[key]
end

local function getComponentId(list, option)
    local entry = getOptionId(list, option)
    if entry == nil then return nil end
    return Character:GetComponentId(entry)
end

local function getShopItem(value, format)
    if type(value) ~= "number" then return value end
    return string.format(format, Character:GetGenderShort(), value)
end

local function getPercentage(value)
    value = tonumber(value)
    if not value then return nil end
    return value * 0.01
end

-- Version 1 stores the same indices as the character does
local function migrateFromVersion1(data)
    local heritage = tonumber(data.heritage) or 0
    local skintone = tonumber(data.skintone) or 0
    local ignoreHeritageLimits = data.ignoreHeritageLimits == true

    -- Presets and expression limits depend on the heritage
    CreatorPresets:SetHeritage(heritage)

    local result = {
        pedType = data.pedType,
        pedModel = data.pedModel,

        name = data.name,
        age = data.age,
        clothingItems = data.clothingItems,

        whistleStyle = data.whistleStyle,
        whistlePitch = data.whistlePitch,
        whistleClarity = data.whistleClarity,

        ignoreHeritageLimits = data.ignoreHeritageLimits,
        ignoreOverlayLimits = data.ignoreOverlayLimits,

        heritage = getOptionId(CreatorPresets:GetHeritages(), heritage, "id"),
        skintone = data.skintone,
        bodyType = getOptionId(Character:GetBodyBuilds(), data.bodyType, "id"),
        height = getOptionId(CreatorConfig.Heights, data.height, "id"),
        weight = getOptionId(CreatorConfig.Weights, data.weight, "id"),
        voice = getOptionId(CreatorConfig.Voices, data.voice, "id"),

        -- Version 2 stores the digits of shop items, the next migration keeps these names
        eyeColor = getComponentId(Character:GetEyeOptions(), data.eyeColor),
        teeth = getComponentId(Character:GetTeethOptions(), data.teeth),
        hair = getComponentId(Character:GetHairStyles(), data.hair),
        beard = getComponentId(Character:GetBeardStyles(), data.beard),

        hairColor = getOptionId(CreatorConfig.HairColors, data.hairColor),
        beardColor = getOptionId(CreatorConfig.HairColors, data.beardColor),

        headDrawable = getComponentId(Character:GetHeadDrawables(), data.headDrawable),
        headAlbedo = getComponentId(Character:GetHeadAlbedos(skintone), data.headAlbedo),
        headNormal = getComponentId(Character:GetHeadNormals(), data.headNormal),
        headMaterial = getComponentId(Character:GetHeadMaterials(), data.headMaterial),
    }

    if tonumber(data.weariness) then
        result.weariness = Character:WearinessUiToGameValue(tonumber(data.weariness))
    end

    if type(data.attributes) == "table" then
        result.attributes = {}

        for key, value in pairs(data.attributes) do
            local attribute = tonumber(key)
            if not attribute then goto continue end

            local name = CHARACTER_ATTRIBUTE:GetName(attribute)
            if not name then goto continue end

            result.attributes[name] = value

            ::continue::
        end
    end

    if type(data.presets) == "table" then
        result.presets = {}

        for key, option in pairs(data.presets) do
            local zone = tonumber(key)
            if not zone then goto continue end

            local name = PED_EXPRESSION_ZONE:GetName(zone)
            if not name then goto continue end

            local presets = CreatorPresets:GetExpressionZonePresets(zone)
            result.presets[name] = getOptionId(presets, option, "id")

            ::continue::
        end
    end

    -- Version 1 stores the values of the sliders instead of the values of the game
    if type(data.expressions) == "table" then
        result.expressions = {}

        for key, value in pairs(data.expressions) do
            local uiValue = tonumber(value)
            if not uiValue then goto continue end

            local expression = tonumber(key)
            if not expression then goto continue end

            local name = PED_EXPRESSION:GetName(expression)
            if not name then goto continue end

            result.expressions[name] = Character:ExpressionUiToGameValue(expression, uiValue, ignoreHeritageLimits)

            ::continue::
        end
    end

    local overlays = {}

    if type(data.layers) == "table" then
        result.layers = {}

        for key, layerData in pairs(data.layers) do
            if type(layerData) ~= "table" then goto continue end

            local layer = tonumber(key)
            if not layer then goto continue end

            local name = OVERLAY_LAYER:GetName(layer)
            if not name or layer == OVERLAY_LAYER.ROOT then goto continue end

            local entry = CharacterOverlay:GetLayerOverlays(layer)[tonumber(layerData.id) or 0]
            overlays[layer] = entry

            local id = NONE
            if entry then id = entry.id end

            result.layers[name] = { id = id, alpha = layerData.alpha }

            ::continue::
        end
    end

    if type(data.layerColors) == "table" then
        result.layerColors = {}

        for key, option in pairs(data.layerColors) do
            local color = tonumber(option)
            if not color then goto continue end

            local layer = tonumber(key)
            if not layer then goto continue end

            local name = OVERLAY_LAYER:GetName(layer)
            if not name then goto continue end

            -- Colors belong to the overlay of the layer
            local entry = overlays[layer]
            if not entry or not entry.colors or #entry.colors == 0 then goto continue end

            result.layerColors[name] = entry.colors[color % #entry.colors + 1]

            ::continue::
        end
    end

    return result
end

-- Version 2 stores some options by their index, and the whistle and head options separately
local function migrateFromVersion2(data)
    local result = Utils:CopyData(data)

    result.whistleStyle = nil
    result.whistlePitch = nil
    result.whistleClarity = nil

    -- The pitch and clarity are no longer percentages
    result.whistle = {
        style = getOptionId(CreatorConfig.Whistles, data.whistleStyle),
        pitch = getPercentage(data.whistlePitch),
        clarity = getPercentage(data.whistleClarity),
    }

    result.headDrawable = nil
    result.headAlbedo = nil
    result.headNormal = nil
    result.headMaterial = nil

    result.head = {
        drawable = data.headDrawable,
        albedo = data.headAlbedo,
        normal = data.headNormal,
        material = data.headMaterial,
    }

    result.skintone = nil

    local skintone = getOptionId(Character:GetSkintones(), data.skintone)
    if skintone then
        result.skintone = CHARACTER_SKINTONE:GetName(skintone)
    end

    result.eyeColor = getShopItem(data.eyeColor, "CLOTHING_ITEM_%s_EYES_001_TINT_%03d")
    result.teeth = getShopItem(data.teeth, "CLOTHING_ITEM_%s_TEETH_%03d")
    result.hair = getShopItem(data.hair, "CLOTHING_ITEM_%s_HAIR_%03d")
    result.beard = getShopItem(data.beard, "CLOTHING_ITEM_%s_BEARD_%03d")

    -- Expressions are keyed by their ID instead of their name
    if type(data.expressions) == "table" then
        result.expressions = {}

        for name, value in pairs(data.expressions) do
            local expression = PED_EXPRESSION:GetIdFromName(name)
            if expression then
                result.expressions[tostring(expression)] = value
            else
                result.expressions[name] = value
            end
        end
    end

    -- Layers without an overlay are left out instead of being NONE
    if type(data.layers) == "table" then
        result.layers = {}

        for name, layerData in pairs(data.layers) do
            if type(layerData) ~= "table" or layerData.id ~= NONE then
                result.layers[name] = layerData
            end
        end
    end

    return result
end

local MIGRATIONS <const> = {
    [1] = migrateFromVersion1,
    [2] = migrateFromVersion2,
}

function CharacterMigrations:Run(data)
    data = Utils:CopyData(data)

    local version = tonumber(data.version) or 1

    if version > CHARACTER_VERSION then
        Utils:Warn("Character data version", tostring(version), "is newer than", tostring(CHARACTER_VERSION), "- unknown data will be skipped")
        return data
    end

    while version < CHARACTER_VERSION do
        local migration = MIGRATIONS[version]
        if not migration then
            error(string.format("No migration from character data version %d", version), 2)
        end

        Utils:Debug("Migrating character data from version", tostring(version), "to", tostring(version + 1))

        data = migration(data)
        version = version + 1
        data.version = version
    end

    return data
end
