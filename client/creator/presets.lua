local SKINTONE_ORDER <const> = { 0, 3, 2, 1, 4, 5 }

CreatorPresets = {
    configNode = 0,
    heritageNode = 0,
    cache = {},
}

local function _setConfigNode()
    if CreatorPresets.configNode == 0 then
        error("Config node not set", 3)
    end

    CreatorXml:RequestReset(CreatorPresets.configNode)
end

local function _setHeritageNode()
    if CreatorPresets.heritageNode == 0 then
        error("Heritage node not set", 3)
    end

    CreatorXml:RequestSetNode(CreatorPresets.heritageNode)
end

function CreatorPresets:ClearCache()
    self.cache = {}
end

function CreatorPresets:Init(config)
    local hash = EDITOR_CONFIG:GetHash(config)
    if not hash then return false end

    self:ClearCache()

    CreatorXml:RequestReset(0)

    if not CreatorXml:GetNode(EDITOR_XML_QUERY.CONFIG_NODE, hash) then
        Utils:Error("Failed to get config node for hash", hash)
        return false
    end

    self.configNode = CreatorXml:RequestGetNode()
    return true
end

function CreatorPresets:SetHeritage(heritage)
    self:ClearCache()

    _setConfigNode()

    if not CreatorXml:GetNode(EDITOR_XML_QUERY.HEAD_PRESET_COUNT, heritage) then
        return false
    end

    self.heritageNode = CreatorXml:RequestGetNode()
    return true
end

function CreatorPresets:GetBodyBuilds()
    if self.cache.bodyBuilds then
        return self.cache.bodyBuilds
    end

    _setConfigNode()

    local count = CreatorXml:GetCount(EDITOR_XML_QUERY.BODY_BUILD_COUNT)
    local result = {}

    for i = 0, count - 1 do
        _setConfigNode()

        if CreatorXml:GetNode(EDITOR_XML_QUERY.BODY_BUILD_COUNT, i) then
            local heritageId = CreatorXml:GetHash(EDITOR_XML_QUERY.ID)
            result[#result + 1] = { index = i, id = heritageId }
        end
    end

    self.cache.bodyBuilds = result
    return result
end

function CreatorPresets:GetBodyBuild(id)
    if self.cache.bodyBuild and self.cache.bodyBuild[id] then
        return self.cache.bodyBuild[id]
    end

    _setConfigNode()

    local result = CreatorXml:GetHash(EDITOR_XML_QUERY.BODY_BUILD_ID, id)

    if not self.cache.bodyBuild then self.cache.bodyBuild = {} end
    self.cache.bodyBuild[id] = result

    return result
end

function CreatorPresets:GetSkintones()
    if self.cache.skintones then
        return self.cache.skintones
    end

    _setConfigNode()

    if not CreatorXml:GetNode(EDITOR_XML_QUERY.BODY_SKINTONE_COUNT, 1) then
        error("No skin tone data found", 2)
    end

    local node = CreatorXml:RequestGetNode()
    local count = CreatorXml:GetCount(EDITOR_XML_QUERY.BODY_SKINTONE_SHOPITEM_COUNT)
    local result = {}

    for i = 0, count - 1 do
        CreatorXml:RequestSetNode(node)

        local id = CreatorXml:GetHash(EDITOR_XML_QUERY.BODY_SKINTONE_SHOPITEM_ID, i)
        local skintone = CreatorXml:GetInt(EDITOR_XML_QUERY.BODY_SKINTONE_SHOPITEM_SKIN_TONE, i)
        local order = SKINTONE_ORDER[skintone + 1] or skintone

        result[#result + 1] = { index = i, order = order, id = id, skintone = skintone }
    end

    table.sort(result, function(a, b) return a.order < b.order end)

    self.cache.skintones = result
    return result
end

function CreatorPresets:GetBodyShopItems(skintone, build)
    skintone = SKINTONE_ORDER[skintone + 1] or skintone
    local key = string.format("%d_%d", skintone, build)

    if self.cache.bodyShopItems and self.cache.bodyShopItems[key] then
        return self.cache.bodyShopItems[key]
    end

    _setConfigNode()

    if not CreatorXml:GetNode(EDITOR_XML_QUERY.BODY_BODY_BUILD_NODE, skintone, build) then
        Utils:Warn("No body shop items found for skintone", tostring(skintone), "and build", tostring(build), "- likely missing XML")
        return {}
    end

    local outfit = CreatorXml:GetHash(EDITOR_XML_QUERY.BODY_BUILD__META_OUTFIT)
    local upper = CreatorXml:GetHash(EDITOR_XML_QUERY.BODY_BUILD__SHOPITEM_UPPER)
    local lower = CreatorXml:GetHash(EDITOR_XML_QUERY.BODY_BUILD__SHOPITEM_LOWER)

    local result = { outfit = outfit, upper = upper, lower = lower }

    if not self.cache.bodyShopItems then self.cache.bodyShopItems = {} end
    self.cache.bodyShopItems[key] = result

    return result
end

function CreatorPresets:GetHeritages()
    if self.cache.heritages then
        return self.cache.heritages
    end

    _setConfigNode()

    local count = CreatorXml:GetCount(EDITOR_XML_QUERY.HEAD_PRESET_COUNT)
    local result = {}

    for i = 0, count - 1 do
        _setConfigNode()

        if CreatorXml:GetNode(EDITOR_XML_QUERY.HEAD_PRESET_COUNT, i) then
            local heritageId = CreatorXml:GetHash(EDITOR_XML_QUERY.ID)
            result[#result + 1] = { index = i, id = heritageId }
        end
    end

    self.cache.heritages = result
    return result
end

---@return table<number, { index: number, order: number, id: number, skintone: number }>
function CreatorPresets:GetHeadShopItems()
    if self.cache.headShopItems then
        return self.cache.headShopItems
    end

    _setHeritageNode()

    local count = CreatorXml:GetCount(EDITOR_XML_QUERY.HEAD_PRESET_SHOPITEM_COUNT)
    local result = {}

    for i = 0, count - 1 do
        _setHeritageNode()

        local id = CreatorXml:GetHash(EDITOR_XML_QUERY.HEAD_PRESET_SHOPITEM_ID, i)
        local skintone = CreatorXml:GetInt(EDITOR_XML_QUERY.HEAD_PRESET_SHOPITEM_SKINTONE, i)
        local order = SKINTONE_ORDER[skintone + 1] or skintone

        result[#result + 1] = { index = i, order = order, id = id, skintone = skintone }
    end

    table.sort(result, function(a, b) return a.order < b.order end)

    self.cache.headShopItems = result
    return result
end

---@return { index: number, order: number, id: number, skintone: number } | nil
function CreatorPresets:GetHeadShopItemForSkintone(skintone)
    skintone = SKINTONE_ORDER[skintone + 1] or skintone

    if self.cache.headShopItem and self.cache.headShopItem[skintone] then
        return self.cache.headShopItem[skintone]
    end

    local heads = self:GetHeadShopItems()

    for _, head in ipairs(heads) do
        if head.skintone == skintone then
            return head
        end
    end

    if not self.cache.headShopItem then self.cache.headShopItem = {} end
    self.cache.headShopItem[skintone] = nil

    return nil
end

---@return table<number, { min: number, max: number, overridable: boolean }>
function CreatorPresets:GetFineTuningData()
    if self.cache.fineTuningData then
        return self.cache.fineTuningData
    end

    local result = {}

    for name, hash in pairs(PED_EXPRESSION:Pluck("Hash", "Id")) do
        _setHeritageNode()

        if CreatorXml:GetNode(EDITOR_XML_QUERY.EXPRESSION_FINE_TUNING_DATA_EXPRESSION_X, hash) then
            local min = CreatorXml:GetFloat(EDITOR_XML_QUERY.MIN_X)
            local max = CreatorXml:GetFloat(EDITOR_XML_QUERY.MAX_X)
            result[name] = { min = min, max = max, overridable = true }
        elseif CreatorXml:GetNode(EDITOR_XML_QUERY.EXPRESSION_FINE_TUNING_DATA_EXPRESSION_Y, hash) then
            local min = CreatorXml:GetFloat(EDITOR_XML_QUERY.MIN_Y)
            local max = CreatorXml:GetFloat(EDITOR_XML_QUERY.MAX_Y)
            result[name] = { min = min, max = max, overridable = true }
        else
            result[name] = { min = -1.0, max = 1.0, overridable = true }
        end

        if CreatorConfig.ExpressionLimits and CreatorConfig.ExpressionLimits[name] then
            local limits = CreatorConfig.ExpressionLimits[name]
            result[name].min = limits.min or result[name].min
            result[name].max = limits.max or result[name].max
            result[name].overridable = limits.overridable or result[name].overridable
        end

        if result[name].min < -1.0 then result[name].min = -1.0 end
        if result[name].max > 1.0 then result[name].max = 1.0 end
    end

    self.cache.fineTuningData = result
    return result
end

---@return table<number, { index: number, id: number }>
function CreatorPresets:GetExpressionZonePresets(zone)
    if self.cache.expressionZonePresets and self.cache.expressionZonePresets[zone] then
        return self.cache.expressionZonePresets[zone]
    end

    local result = {}
    local query = PED_EXPRESSION_ZONE:GetQuery(zone)

    if query then
        _setHeritageNode()

        local count = CreatorXml:GetCount(query)
        for i = 0, count - 1 do
            _setHeritageNode()

            if CreatorXml:GetNode(query, i) then
                local presetId = CreatorXml:GetHash(EDITOR_XML_QUERY.ID)

                if presetId ~= `CUSTOM_CREATOR_REROLL_OPTION` then
                    result[#result + 1] = { index = i, id = presetId }
                end
            end
        end
    end

    local custom = self:GetCustomExpressionZonePresets(zone)
    for i, item in ipairs(custom) do
        result[i] = item
    end

    if not self.cache.expressionZonePresets then self.cache.expressionZonePresets = {} end
    self.cache.expressionZonePresets[zone] = result

    return result
end

function CreatorPresets:GetCustomExpressionZonePresets(zone)
    local data = Character:IsMale() and CreatorConfig.CustomMaleExpressionPresetLabels or CreatorConfig.CustomFemaleExpressionPresetLabels
    local zoneData = data[zone] or {}

    local result = {}
    for i, item in ipairs(zoneData) do
        result[#result + 1] = { index = i, id = item }
    end

    if #result == 0 then
        result[1] = { index = 1, id = "NATIVE_CREATOR_PRESET_DEFAULT" }
    end

    return result
end

---@return table<number, number>
function CreatorPresets:GetExpressionZoneData(zone, preset)
    local key = string.format("%d_%d", zone, preset)

    if self.cache.expressionZoneData and self.cache.expressionZoneData[key] then
        return self.cache.expressionZoneData[key]
    end

    local result = {}
    local query = PED_EXPRESSION_ZONE:GetQuery(zone)

    if query then
        _setHeritageNode()

        -- The first preset is always the "Custom" option, which we do not want
        if CreatorXml:GetNode(query, preset + 1) then
            local zoneNode = CreatorXml:RequestGetNode()

            local expressions = CreatorXml:GetCount(EDITOR_XML_QUERY.EXPRESSION_COUNT)
            for i = 0, expressions - 1 do
                CreatorXml:RequestSetNode(zoneNode)

                local hash = CreatorXml:GetHash(EDITOR_XML_QUERY.EXPRESSION_ID, i)
                local value = CreatorXml:GetFloat(EDITOR_XML_QUERY.EXPRESSION_VALUE, i)

                local id = PED_EXPRESSION:GetIdFromHash(hash)
                if id then result[id] = value end
            end
        else
            error(string.format("Preset %d not found for expression zone %s", tostring(preset), PED_EXPRESSION_ZONE:ToString(zone)), 2)
        end
    end

    local custom = self:GetCustomExpressionZoneData(zone, preset)
    for id, value in pairs(custom) do
        result[id] = value
    end

    if not self.cache.expressionZoneData then self.cache.expressionZoneData = {} end
    self.cache.expressionZoneData[key] = result

    return result
end

function CreatorPresets:GetCustomExpressionZoneData(zone, preset)
    -- UI value is 0-based, so add one to the preset
    preset = preset + 1

    local data = Character:IsMale() and CreatorConfig.CustomMaleExpressionPresetValues or CreatorConfig.CustomFemaleExpressionPresetValues
    local expressions = PED_EXPRESSION_ZONE:GetExpressions(zone) or {}

    local result = {}
    for _, id in ipairs(expressions) do
        local value = data[id] and data[id][preset] or nil
        result[id] = value and math.max(-1.0, math.min(1.0, value)) or nil
    end

    return result
end
