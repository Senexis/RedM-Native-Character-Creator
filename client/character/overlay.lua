CharacterOverlay = {
    drawable = -1,
    applied = false,
    albedo = 0,
    normal = 0,
    material = 0,
    layers = {},
    flags = 0,

    -- Textures that stay on the peds the character was attached to
    textures = {},
}

-- This is a hard limit, increasing this only results in -1 layer IDs
CharacterOverlay.MAX_LAYERS_COUNT = 15

function CharacterOverlay:RequestUpdate(throttle)
    Character:SetFlag(CHARACTER_FLAG.UPDATE_OVERLAYS)
    Character:SetFlag(CHARACTER_FLAG.DIRTY)
    Character:ThrottleUpdate(throttle)
end

function CharacterOverlay:ClearOverlay()
    if self.drawable ~= -1 then
        ClearPedTexture(self.drawable)
        ReleaseTexture(self.drawable)
    end

    self.drawable = -1
    self.applied = false
end

function CharacterOverlay:ReleasePedTexture(ped)
    local texture = self.textures[ped]
    if not texture then return end

    ClearPedTexture(texture)
    ReleaseTexture(texture)

    self.textures[ped] = nil
end

function CharacterOverlay:Detach(ped)
    if self.drawable == -1 then return end

    -- A texture that was never applied is not on the ped
    if not self.applied or not ped or ped == 0 then
        self:ClearOverlay()
        return
    end

    self:ReleasePedTexture(ped)
    self.textures[ped] = self.drawable

    self.drawable = -1
    self.applied = false
end

function CharacterOverlay:Maintain()
    if not Character:IsFlagSet(CHARACTER_FLAG.OVERLAY_DIRTY) then
        self:ClearOverlay()

        self.drawable = RequestTexture(self.albedo, self.normal, self.material)

        local sorted = {}
        for _, layer in pairs(self.layers) do
            if layer.id ~= "BLEND_NONE" then
                sorted[#sorted + 1] = layer
            end
        end

        table.sort(sorted, function(a, b)
            return (a.priority or 0) < (b.priority or 0)
        end)

        local counter = 0
        for _, layer in ipairs(sorted) do
            if counter >= self.MAX_LAYERS_COUNT then
                Utils:Warn(string.format("Cannot add more than %d layers to texture blend", self.MAX_LAYERS_COUNT))
                break
            end

            local alpha = layer:GetAlpha(Character.ignoreOverlayLimits)
            layer.index = AddTextureLayer(self.drawable, layer.albedo, layer.normal, layer.material, layer.blendType, alpha, layer.sheetGridIndex)

            if layer.index <= -1 then
                Utils:Error(string.format("Failed to add layer %s to texture blend", OVERLAY_LAYER:ToString(layer.layer)))
                goto continue
            end

            self:UpdateTextureLayer(layer)
            counter = counter + 1

            ::continue::
        end

        Character:SetFlag(CHARACTER_FLAG.OVERLAY_DIRTY)
    end

    if IsTextureValid(self.drawable) ~= 1 then
        return false
    end

    local ped = Character:GetPed()
    ApplyTextureOnPed(ped, `heads`, self.drawable)
    UpdatePedTexture(self.drawable)

    -- Release the texture the ped had before
    self.applied = true
    self:ReleasePedTexture(ped)

    Character:ClearFlag(CHARACTER_FLAG.OVERLAY_DIRTY)

    return true
end

function CharacterOverlay:UpdateTextureLayer(data)
    if data.palette ~= 0 then
        SetTextureLayerPallete(self.drawable, data.index, data.palette)
        SetTextureLayerTint(self.drawable, data.index, data.tint0, data.tint1, data.tint2)
    end

    if data.modTexture ~= 0 then
        SetTextureLayerMod(self.drawable, data.index, data.modTexture, data.modAlpha, data.modChannel);
    end

    if data.roughness > 0.0 then
        SetTextureLayerRoughness(self.drawable, data.index, data.roughness)
    end
end

function CharacterOverlay:SetBaseLayer(albedo, normal, material, apply)
    self.albedo = albedo or self.albedo
    self.normal = normal or self.normal
    self.material = material or self.material

    if apply then self:RequestUpdate() end
end

function CharacterOverlay:GetLayerOverlays(layer)
    if layer == OVERLAY_LAYER.ROOT then return {} end

    local overlay = CreatorConfig.Overlays[layer]
    if not overlay then
        error(string.format("Invalid layer: %s", layer))
    end

    local gender = Character:GetGenderShort()

    local overlays = {}
    for index, data in ipairs(overlay) do
        if not data.blend then
            error(string.format("Item %s in layer %s is missing a blend value", index, OVERLAY_LAYER:ToString(layer)))
        end

        if not data.gender or data.gender == gender then
            overlays[#overlays + 1] = data
        end
    end

    return overlays
end

function CharacterOverlay:GetLayerBlends(layer)
    local blends = { "BLEND_NONE" }

    for _, data in ipairs(self:GetLayerOverlays(layer)) do
        local blend = data.blend
        if layer == OVERLAY_LAYER.EYEBROWS or layer == OVERLAY_LAYER.HEAD_HAIR then
            blend = string.format(blend, Character:GetHairColorString())
        elseif layer == OVERLAY_LAYER.FACIAL_HAIR then
            blend = string.format(blend, Character:GetBeardColorString())
        end

        blends[#blends + 1] = blend
    end

    return blends
end

function CharacterOverlay:GetLayerBlend(layer, index)
    local blends = self:GetLayerBlends(layer)
    return blends[index] or "BLEND_NONE"
end

function CharacterOverlay:GetLayerColors(layer, blend)
    if blend == "BLEND_NONE" then
        return {}
    end

    local overlay = CreatorConfig.Overlays[layer]
    if not overlay then
        error(string.format("Invalid layer: %s", OVERLAY_LAYER:ToString(layer)))
    end

    local colors = {}
    for index, data in ipairs(overlay) do
        if not data.blend then
            error(string.format("Item %s in layer %s is missing a blend value", index, OVERLAY_LAYER:ToString(layer)))
        end

        if not data.colors then
            error(string.format("No colors found for blend %s in layer %s", blend, OVERLAY_LAYER:ToString(layer)))
        end

        if not data.gender or data.gender == Character:GetGenderShort() then
            colors[data.blend] = data.colors
        end
    end

    if blend == nil then
        return colors
    end

    if not colors[blend] then
        error(string.format("No colors found for blend %s in layer %s", blend, OVERLAY_LAYER:ToString(layer)))
    end

    return colors[blend]
end

function CharacterOverlay:SetLayerBlend(layer, blend, apply)
    local existing = self.layers[layer] or CharacterBlends:Get(layer, "BLEND_NONE")

    local updated = CharacterBlends:Get(layer, blend)
    updated.alpha = existing.alpha

    self.layers[layer] = updated

    if apply then self:RequestUpdate() end
end

function CharacterOverlay:SetLayerAlpha(layer, alpha, apply)
    local existing = self.layers[layer] or CharacterBlends:Get(layer, "BLEND_NONE")
    existing.alpha = alpha or existing.alpha

    self.layers[layer] = existing

    if apply then self:RequestUpdate() end
end

function CharacterOverlay:GetUsedLayers()
    local used = {}
    for _, layer in pairs(self.layers) do
        if layer and layer.id ~= "BLEND_NONE" then
            used[#used + 1] = layer.layer
        end
    end

    return used
end

function CharacterOverlay:GetBlockedLayers()
    local used = self:GetUsedLayers()
    if #used < self.MAX_LAYERS_COUNT then
        return {}
    end

    local blocked = {}
    for _, layer in pairs(OVERLAY_LAYER:Values()) do
        blocked[layer] = true
    end

    for _, layer in pairs(used) do
        blocked[layer] = false
    end

    return blocked
end

function CharacterOverlay:GetFooterSuffix()
    local used = self:GetUsedLayers()
    local count = #used

    local prefix = "~s~"
    if count >= self.MAX_LAYERS_COUNT then
        prefix = "~COLOR_RED~"
    elseif count >= (self.MAX_LAYERS_COUNT - 1) then
        prefix = "~COLOR_YELLOW~"
    end

    return prefix .. string.format("%d of %d~s~ overlays used.", count, self.MAX_LAYERS_COUNT)
end

-- Releases the textures of peds that no longer exist
CreateThread(function()
    while true do
        Wait(5000)

        for ped, _ in pairs(CharacterOverlay.textures) do
            if DoesEntityExist(ped) ~= 1 then
                CharacterOverlay:ReleasePedTexture(ped)
            end
        end

        if CharacterOverlay.drawable ~= -1 and not Character:Exists() then
            CharacterOverlay:ClearOverlay()
        end
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    CharacterOverlay:ClearOverlay()

    for ped, _ in pairs(CharacterOverlay.textures) do
        CharacterOverlay:ReleasePedTexture(ped)
    end
end)
