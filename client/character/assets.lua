CharacterAssets = {
    requests = {},
    requested = false,
}

function CharacterAssets:Add(pedType, item)
    if not item or item == 0 then return end

    self.requests[#self.requests + 1] = {
        hash = item,
        handle = RequestMetaPedComponent(pedType, item, 0, 1, 1),
    }
end

function CharacterAssets:Request(all)
    if self.requested then return end

    local ped = Character:GetPed()
    local pedType = GetMetaPedType(ped)

    if not all then
        local head = Character:GetHeadShopItem()
        if head then self:Add(pedType, head.id) end

        local body = CreatorPresets:GetBodyShopItems(Character.skintone, CreatorPresets:GetBodyBuild(Character:GetBodyBuild()))
        self:Add(pedType, body.upper)
        self:Add(pedType, body.lower)

        self.requested = true
        return
    end

    for _, heritage in ipairs(CreatorPresets:GetHeritages()) do
        CreatorPresets:SetHeritage(heritage.index)

        for _, item in ipairs(CreatorPresets:GetHeadShopItems()) do
            self:Add(pedType, item.id)
        end
    end

    -- Restore the heritage of the character since the presets depend on it
    CreatorPresets:SetHeritage(Character.heritage)

    for _, skintone in ipairs(CreatorPresets:GetSkintones()) do
        for _, build in ipairs(CreatorPresets:GetBodyBuilds()) do
            local body = CreatorPresets:GetBodyShopItems(skintone.index, CreatorPresets:GetBodyBuild(build.index))
            self:Add(pedType, body.upper)
            self:Add(pedType, body.lower)
        end
    end

    self.requested = true
end

function CharacterAssets:IsRequested()
    return self.requested
end

function CharacterAssets:IsLoaded()
    if not self.requested then return false end

    for _, request in ipairs(self.requests) do
        if HasMetaPedAssetLoaded(request.handle) ~= 1 then
            return false
        end
    end

    return true
end

function CharacterAssets:Release()
    for _, request in ipairs(self.requests) do
        ReleaseMetaPedAssetRequest(request.handle)
    end

    self.requests = {}
    self.requested = false
end

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    CharacterAssets:Release()
end)
