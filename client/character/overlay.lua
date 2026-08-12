CharacterOverlay = {
    drawable = -1,
    albedo = 0,
    normal = 0,
    material = 0,
    layers = {},
    flags = 0,
}

-- This is a hard limit, increasing this only results in -1 layer IDs
CharacterOverlay.MAX_LAYERS_COUNT = 15

function CharacterOverlay:RequestUpdate()
    Character:SetFlag(CHARACTER_FLAG.UPDATE_OVERLAYS)
    Character:SetFlag(CHARACTER_FLAG.DIRTY)
end

function CharacterOverlay:ClearOverlay()
    if self.drawable ~= -1 then
        ClearPedTexture(self.drawable)
        ReleaseTexture(self.drawable)
    end

    self.drawable = -1
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
                Utils:Debug(string.format("Cannot add more than %d layers to texture blend", self.MAX_LAYERS_COUNT))
                break
            end

            local alpha = layer:GetAlpha(Character.ignoreOverlayLimits)
            layer.index = AddTextureLayer(self.drawable, layer.albedo, layer.normal, layer.material, layer.blendType, alpha, layer.sheetGridIndex)

            if layer.index <= -1 then
                Utils:Debug(string.format("Failed to add layer %s to texture blend", OVERLAY_LAYER:ToString(layer.layer)))
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

    ApplyTextureOnPed(Character.ped, `heads`, self.drawable)
    UpdatePedTexture(self.drawable)

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

function CharacterOverlay:UpdateBaseLayer(shopItem, apply)
    local pedType = Character:GetPedType()

    local result,
    _drawable,
    albedo,
    normal,
    material,
    _palette,
    _tint0,
    _tint1,
    _tint2 = Citizen.InvokeNative(
        0x63342C50EC115CE8,        -- PED::_GET_SHOP_ITEM_BASE_LAYERS(
        shopItem,                  --   shopItem,
        0,                         --   p1,
        0,                         --   ped,
        pedType,                   --   metapedType,
        true,                      --   p4,
        Citizen.PointerValueInt(), --   &drawable,
        Citizen.PointerValueInt(), --   &albedo,
        Citizen.PointerValueInt(), --   &normal,
        Citizen.PointerValueInt(), --   &material,
        Citizen.PointerValueInt(), --   &palette,
        Citizen.PointerValueInt(), --   &tint0,
        Citizen.PointerValueInt(), --   &tint1,
        Citizen.PointerValueInt(), --   &tint2
        Citizen.ResultAsInteger()  -- ): bool
    )

    if result ~= 1 then
        error(string.format("Failed to find shop item asset for %s", shopItem), 2)
    end

    self.albedo = albedo
    self.normal = normal
    self.material = material

    if apply then self:RequestUpdate() end
end

function CharacterOverlay:GetLayerBlends(layer)
    if layer == OVERLAY_LAYER.ROOT then return { "BLEND_NONE" } end

    local overlay = CreatorConfig.Overlays[layer]
    if not overlay then
        error(string.format("Invalid layer: %s", layer))
    end

    local blends = { "BLEND_NONE" }
    for index, data in pairs(overlay) do
        if not data.blend then
            error(string.format("Item %s in layer %s is missing a blend value", index, OVERLAY_LAYER:ToString(layer)))
        end

        local blend = data.blend
        if layer == OVERLAY_LAYER.EYEBROWS or layer == OVERLAY_LAYER.HEAD_HAIR then
            blend = string.format(blend, Character:GetHairColorString())
        elseif layer == OVERLAY_LAYER.FACIAL_HAIR then
            blend = string.format(blend, Character:GetBeardColorString())
        end

        if not data.gender or data.gender == Character:GetGenderShort() then
            blends[#blends + 1] = blend
        end
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
    for index, data in pairs(overlay) do
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

    if not alpha then alpha = existing.alpha end
    if alpha < 0.0001 then alpha = 0.0001 end
    if alpha > 1.0 then alpha = 1.0 end

    existing.alpha = alpha

    self.layers[layer] = existing

    if apply then self:RequestUpdate() end
end

function CharacterOverlay:GetUsedLayers()
    local used = {}
    for _, layer in pairs(self.layers) do
        if layer and layer.index > -1 then
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

    return "~n~" .. prefix .. string.format("%d of %d~s~ overlays used.", count, self.MAX_LAYERS_COUNT)
end

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    CharacterOverlay:ClearOverlay()
end)
