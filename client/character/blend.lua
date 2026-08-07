---@class CharacterBlend
---@field id string
---@field layer number
---@field priority number
---@field skintoneAlphas number[]
---@field isTint boolean
---@field isHair boolean
---@field index number
---@field albedo number
---@field normal number
---@field material number
---@field sheetGridIndex number
---@field modTexture number
---@field modChannel number
---@field palette number
---@field tint0 number
---@field tint1 number
---@field tint2 number
---@field texAlpha number
---@field modAlpha number
---@field roughness number
---@field blendType number
---@field alpha number
CharacterBlend = {}
CharacterBlend.__index = CharacterBlend

local defaults = {
    id = "BLEND_NONE",
    layer = -1,

    priority = -1,
    skintoneAlphas = { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 },
    isTint = false,
    isHair = false,
    index = -1,

    albedo = 0,
    normal = 0,
    material = 0,
    sheetGridIndex = 0,
    modTexture = 0,
    modChannel = 0,
    palette = 0,
    tint0 = 0,
    tint1 = 0,
    tint2 = 0,
    texAlpha = 1.0,
    modAlpha = 1.0,
    roughness = 0.0,
    blendType = 0,
    alpha = 1.0,
}

function CharacterBlend:New(data)
    local instance = {}

    for k, v in pairs(defaults) do
        instance[k] = v
    end

    setmetatable(instance, self)

    if data then
        instance:Update(data)
    end

    return instance
end

function CharacterBlend:Update(newData)
    if type(newData) ~= "table" then
        return
    end

    for k, v in pairs(newData) do
        if self[k] ~= nil then
            self[k] = v
        end
    end

    -- Ensure that the tint values are updated properly if a new tint is provided
    if newData.tint ~= nil then
        self.tint0 = newData.tint
        self.tint1 = newData.tint
        self.tint2 = newData.tint
    end

    -- Ensure that OVERLAY_LAYER fields are updated properly if the layer is changed
    if newData.layer ~= nil then
        self.priority = OVERLAY_LAYER:GetPriority(self.layer) or defaults.priority
        self.skintoneAlphas = OVERLAY_LAYER:GetSkintoneAlphas(self.layer) or defaults.skintoneAlphas
        self.isTint = OVERLAY_LAYER:GetSupportsTint(self.layer) or defaults.isTint
        self.isHair = OVERLAY_LAYER:GetSupportsHair(self.layer) or defaults.isHair
    end
end

function CharacterBlend:GetAlpha(skintone)
    local skintoneAlpha = self.skintoneAlphas[skintone] or 1.0

    -- Ensure the skintone alpha is always valid
    if skintoneAlpha < 0.0 then skintoneAlpha = 0.0 end
    if skintoneAlpha > 1.0 then skintoneAlpha = 1.0 end

    return self.texAlpha * self.alpha * skintoneAlpha
end
