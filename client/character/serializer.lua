CharacterSerializer = {}

local NONE <const> = "NONE"

local KEYS <const> = {
    version = true,
    pedType = true,
    pedModel = true,
    name = true,
    age = true,
    weariness = true,
    clothingItems = true,
    whistle = true,
    ignoreHeritageLimits = true,
    ignoreOverlayLimits = true,
    heritage = true,
    skintone = true,
    bodyType = true,
    height = true,
    weight = true,
    voice = true,
    eyeColor = true,
    teeth = true,
    head = true,
    hair = true,
    hairColor = true,
    beard = true,
    beardColor = true,
    attributes = true,
    presets = true,
    expressions = true,
    layers = true,
    layerColors = true,
}

local function round(value)
    return math.floor(value * 10000 + 0.5) / 10000
end

-- The creator uses percentages, the game uses values between 0.0 and 1.0
local function whistleUiToGameValue(value)
    return round((tonumber(value) or 0) * 0.01)
end

local function whistleGameToUiValue(value)
    value = tonumber(value)
    if not value then return nil end
    return math.max(0, math.min(100, math.floor(value * 100 + 0.5)))
end

local function getOptionId(list, option, key)
    local entry = list[(option or 0) + 1]
    if entry == nil then return nil end
    if key == nil then return entry end
    return entry[key]
end

local function getOption(field, list, id, key)
    if id == nil then return nil end

    local index = Utils:IndexOf(list, id, key)
    if not index then
        Utils:Warn("Unknown", field, tostring(id), "in character data, skipping...")
        return nil
    end

    return index - 1
end

-- Compare hashes unsigned since the game and joaat do not agree on the sign
local function toHash(value)
    if type(value) == "string" then
        return joaat(value) & 0xFFFFFFFF
    end

    local number = math.tointeger(tonumber(value))
    if not number then return nil end
    return number & 0xFFFFFFFF
end

local function getIdFromHash(registry, hash)
    local unsigned = toHash(hash)
    if not unsigned then return nil end

    local signed = unsigned
    if unsigned >= 0x80000000 then
        signed = unsigned - 0x100000000
    end

    return registry:GetIdFromHash(signed) or registry:GetIdFromHash(unsigned)
end

-- Unknown hashes are exported as they are
local function getHashName(registry, value)
    if type(value) ~= "number" then return value end

    local id = getIdFromHash(registry, value)
    if not id then return value end
    return registry:GetName(id)
end

local function getHashOption(field, registry, list, id, key)
    if id == nil then return nil end

    -- Names are compared by their hash
    local hash = toHash(id)
    if type(id) == "string" then
        local known = registry:GetIdFromName(id)
        if known then
            hash = toHash(registry:GetHash(known))
        end
    end

    for index, entry in ipairs(list) do
        local compare = entry[key]
        if compare == id or (hash and toHash(compare) == hash) then
            return index - 1
        end
    end

    Utils:Warn("Unknown", field, tostring(id), "in character data, skipping...")
    return nil
end

local function getComponentId(list, option)
    local entry = list[(option or 0) + 1]
    if entry == nil then return NONE end
    return Character:GetComponentId(entry)
end

local function getComponentOption(field, list, id)
    if id == nil then return nil end

    for index, entry in ipairs(list) do
        if Character:GetComponentId(entry) == id then
            return index - 1
        end
    end

    -- NONE is always valid, even when the list does not have it
    if id == NONE then return nil end

    Utils:Warn("Unknown", field, tostring(id), "in character data, skipping...")
    return nil
end

local function getTable(data, key)
    local value = data[key]
    if value == nil then return nil end

    if type(value) ~= "table" then
        Utils:Warn("Invalid", key, "format. Expected a table, got", type(value))
        return nil
    end

    return value
end

function CharacterSerializer:Export()
    -- Presets and expression limits depend on the heritage
    CreatorPresets:SetHeritage(Character.heritage)

    local heritage = getOptionId(CreatorPresets:GetHeritages(), Character.heritage, "id")

    local skintone = Character:GetSkintoneId()
    if skintone then
        skintone = CHARACTER_SKINTONE:GetName(skintone)
    end

    local data = {
        version = CHARACTER_VERSION,
        pedType = Character:GetPedType(),
        pedModel = Character:GetModel(),

        name = Character.name,
        age = Character.age,
        weariness = round(Character:WearinessUiToGameValue(Character.weariness)),
        clothingItems = Utils:CopyData(Character.clothingItems),

        whistle = {
            style = getOptionId(CreatorConfig.Whistles, Character.whistleStyle),
            pitch = whistleUiToGameValue(Character.whistlePitch),
            clarity = whistleUiToGameValue(Character.whistleClarity),
        },

        ignoreHeritageLimits = Character.ignoreHeritageLimits == true,
        ignoreOverlayLimits = Character.ignoreOverlayLimits == true,

        heritage = getHashName(CHARACTER_HERITAGE, heritage),
        skintone = skintone,
        bodyType = getOptionId(Character:GetBodyBuilds(), Character.bodyType, "id"),
        height = getOptionId(CreatorConfig.Heights, Character.height, "id"),
        weight = getOptionId(CreatorConfig.Weights, Character.weight, "id"),
        voice = getOptionId(CreatorConfig.Voices, Character.voice, "id"),
        eyeColor = getComponentId(Character:GetEyeOptions(), Character.eyeColor),
        teeth = getComponentId(Character:GetTeethOptions(), Character.teeth),

        head = {
            drawable = getComponentId(Character:GetHeadDrawables(), Character.headDrawable),
            albedo = getComponentId(Character:GetHeadAlbedos(), Character.headAlbedo),
            normal = getComponentId(Character:GetHeadNormals(), Character.headNormal),
            material = getComponentId(Character:GetHeadMaterials(), Character.headMaterial),
        },

        hair = getComponentId(Character:GetHairStyles(), Character.hair),
        hairColor = getOptionId(CreatorConfig.HairColors, Character.hairColor),
        beard = getComponentId(Character:GetBeardStyles(), Character.beard),
        beardColor = getOptionId(CreatorConfig.HairColors, Character.beardColor),

        attributes = {},
        presets = {},
        expressions = {},
        layers = {},
        layerColors = {},
    }

    for _, attribute in ipairs(CHARACTER_ATTRIBUTE:Values()) do
        data.attributes[CHARACTER_ATTRIBUTE:GetName(attribute)] = Character:GetAttribute(attribute)
    end

    for _, zone in ipairs(PED_EXPRESSION_ZONE:Values()) do
        local preset = getOptionId(CreatorPresets:GetExpressionZonePresets(zone), Character.presets[zone], "id")
        data.presets[PED_EXPRESSION_ZONE:GetName(zone)] = getHashName(EXPRESSION_PRESET, preset)
    end

    -- Expressions are exported as game values so they do not depend on the heritage
    for _, expression in ipairs(PED_EXPRESSION:Values()) do
        local uiValue = Character:GetExpressionUiValue(expression)
        local gameValue = Character:ExpressionUiToGameValue(expression, uiValue)

        -- Numeric keys would be encoded as a sparse array
        data.expressions[tostring(expression)] = round(gameValue)
    end

    for _, layer in ipairs(OVERLAY_LAYER:Values()) do
        local name = OVERLAY_LAYER:GetName(layer)
        if not name or layer == OVERLAY_LAYER.ROOT then goto continue end

        local overlay = Character:GetOverlay(layer)
        local entry = CharacterOverlay:GetLayerOverlays(layer)[overlay.id]

        -- Layers without an overlay are left out
        if not entry then goto continue end

        data.layers[name] = { id = entry.id, alpha = overlay.alpha }

        if not entry.colors or #entry.colors == 0 then goto continue end
        if not OVERLAY_LAYER:GetSupportsTint(layer) then goto continue end

        local color = Character:GetOverlayColor(layer) % #entry.colors
        data.layerColors[name] = entry.colors[color + 1]

        ::continue::
    end

    return data
end

function CharacterSerializer:Import(data)
    data = CharacterMigrations:Run(data)

    local pedType = tonumber(data.pedType)
    if pedType and pedType ~= Character:GetPedType() then
        Utils:Warn("Character data is for ped type", tostring(pedType), "but the character is ped type", tostring(Character:GetPedType()))
    end

    for key, _ in pairs(data) do
        if not KEYS[key] then
            Utils:Warn("Unknown character data key", tostring(key), "skipping...")
        end
    end

    Character.ignoreHeritageLimits = data.ignoreHeritageLimits == true
    if Character.ignoreHeritageLimits then
        Utils:Warn("Ignore heritage limits enabled, proceeding without restrictions")
    end

    Character.ignoreOverlayLimits = data.ignoreOverlayLimits == true
    if Character.ignoreOverlayLimits then
        Utils:Warn("Ignore overlay limits enabled, proceeding without restrictions")
    end

    -- Presets and expression limits depend on the heritage
    Character:ApplyHeritage(getHashOption("heritage", CHARACTER_HERITAGE, CreatorPresets:GetHeritages(), data.heritage, "id"))

    Character:ApplyName(data.name)
    Character:ApplyAgeAlpha(tonumber(data.age))
    Character:ApplyHeight(getOption("height", CreatorConfig.Heights, data.height, "id"))
    Character:ApplyWeight(getOption("weight", CreatorConfig.Weights, data.weight, "id"))
    Character:ApplyVoice(getOption("voice", CreatorConfig.Voices, data.voice, "id"))
    Character:ApplyClothingItems(data.clothingItems)

    if tonumber(data.weariness) then
        Character:ApplyWeariness(round(Character:WearinessGameToUiValue(tonumber(data.weariness))))
    else
        Character:ApplyWeariness(nil)
    end

    local whistle = getTable(data, "whistle") or {}
    Character:ApplyWhistleStyle(getOption("whistle style", CreatorConfig.Whistles, whistle.style))
    Character:ApplyWhistlePitch(whistleGameToUiValue(whistle.pitch))
    Character:ApplyWhistleClarity(whistleGameToUiValue(whistle.clarity))

    local attributes = getTable(data, "attributes")
    if attributes then
        local values = {}

        for name, value in pairs(attributes) do
            local attribute = CHARACTER_ATTRIBUTE:GetIdFromName(name)
            if attribute then
                values[attribute] = tonumber(value)
            else
                Utils:Warn("Unknown attribute", tostring(name), "in character data, skipping...")
            end
        end

        Character:ApplyAttributes(values)
    end

    local skintone = nil
    if data.skintone ~= nil then
        skintone = CHARACTER_SKINTONE:GetIdFromName(tostring(data.skintone))
        if not skintone then
            Utils:Warn("Unknown skin tone", tostring(data.skintone), "in character data, skipping...")
        end
    end

    Character:ApplySkintone(getOption("skin tone", Character:GetSkintones(), skintone))
    Character:ApplyBody(getOption("body type", Character:GetBodyBuilds(), data.bodyType, "id"))
    Character:ApplyEyeColor(getComponentOption("eye color", Character:GetEyeOptions(), data.eyeColor))
    Character:ApplyTeeth(getComponentOption("teeth", Character:GetTeethOptions(), data.teeth))

    -- Complexions depend on the skin tone
    local head = getTable(data, "head") or {}
    Character:ApplyHeadDrawable(getComponentOption("head", Character:GetHeadDrawables(), head.drawable))
    Character:ApplyHeadAlbedo(getComponentOption("head complexion", Character:GetHeadAlbedos(), head.albedo))
    Character:ApplyHeadNormal(getComponentOption("head details", Character:GetHeadNormals(), head.normal))
    Character:ApplyHeadMaterial(getComponentOption("head finish", Character:GetHeadMaterials(), head.material))

    Character:ApplyHairStyle(getComponentOption("hair", Character:GetHairStyles(), data.hair))
    Character:ApplyHairColor(getOption("hair color", CreatorConfig.HairColors, data.hairColor))
    Character:ApplyBeardStyle(getComponentOption("beard", Character:GetBeardStyles(), data.beard))
    Character:ApplyBeardColor(getOption("beard color", CreatorConfig.HairColors, data.beardColor))

    local presets = getTable(data, "presets")
    if presets then
        for name, id in pairs(presets) do
            local zone = PED_EXPRESSION_ZONE:GetIdFromName(name)
            if not zone then
                Utils:Warn("Unknown preset zone", tostring(name), "in character data, skipping...")
                goto continue
            end

            local option = getHashOption("preset", EXPRESSION_PRESET, CreatorPresets:GetExpressionZonePresets(zone), id, "id")
            if option then Character:ApplyPreset(zone, option) end

            ::continue::
        end
    end

    -- Expressions are game values, which depend on the heritage
    local expressions = getTable(data, "expressions")
    if expressions then
        for key, value in pairs(expressions) do
            local gameValue = tonumber(value)
            if not gameValue then
                Utils:Warn("Invalid value for expression", tostring(key), "in character data, skipping...")
                goto continue
            end

            local expression = tonumber(key)
            if not expression or not PED_EXPRESSION:GetName(expression) then
                Utils:Warn("Unknown expression", tostring(key), "in character data, skipping...")
                goto continue
            end

            Character:ApplyExpressionValue(expression, Character:ExpressionGameToUiValue(expression, gameValue))

            ::continue::
        end
    end

    local layers = getTable(data, "layers")
    if layers then
        for name, layerData in pairs(layers) do
            if type(layerData) ~= "table" then
                Utils:Warn("Invalid layer", tostring(name), "in character data, skipping...")
                goto continue
            end

            local layer = OVERLAY_LAYER:GetIdFromName(name)
            if not layer or layer == OVERLAY_LAYER.ROOT then
                Utils:Warn("Unknown layer", tostring(name), "in character data, skipping...")
                goto continue
            end

            local index = nil
            if layerData.id == NONE then
                index = 0
            else
                index = Utils:IndexOf(CharacterOverlay:GetLayerOverlays(layer), layerData.id, "id")
            end

            if not index then
                Utils:Warn("Unknown overlay", tostring(layerData.id), "for layer", tostring(name), "in character data, skipping...")
                goto continue
            end

            Character:ApplyOverlayBlend(layer, index)
            Character:ApplyOverlayAlpha(layer, math.min(1.0, math.max(0.0, tonumber(layerData.alpha) or 1.0)))

            ::continue::
        end

        -- Layers that are left out have no overlay
        for _, layer in ipairs(OVERLAY_LAYER:Values()) do
            if layer == OVERLAY_LAYER.ROOT then goto continue end

            local name = OVERLAY_LAYER:GetName(layer)
            if not name or layers[name] ~= nil then goto continue end

            Character:ApplyOverlayBlend(layer, 0)

            -- The ageing layer keeps the opacity of the age
            if layer == OVERLAY_LAYER.AGEING then
                Character:ApplyAgeAlpha(nil)
            else
                Character:ApplyOverlayAlpha(layer, 1.0)
            end

            ::continue::
        end
    end

    local layerColors = getTable(data, "layerColors")
    if layerColors then
        for name, color in pairs(layerColors) do
            local layer = OVERLAY_LAYER:GetIdFromName(name)
            if not layer or not OVERLAY_LAYER:GetSupportsTint(layer) then
                Utils:Warn("Unknown layer color", tostring(name), "in character data, skipping...")
                goto continue
            end

            -- Colors belong to the overlay of the layer
            local entry = CharacterOverlay:GetLayerOverlays(layer)[Character:GetOverlay(layer).id]
            if not entry or not entry.colors then goto continue end

            local option = getOption("layer color", entry.colors, color)
            if option then Character:ApplyOverlayColor(layer, option) end

            ::continue::
        end
    end
end
