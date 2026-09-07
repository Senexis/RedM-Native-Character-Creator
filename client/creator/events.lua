CreatorEvents = {
    currentPage = 0,
    currentFocusedItem = 0,
    zoomMode = ZOOM_MODE.HOLD,
    isZooming = false,
    currentGridXValue = 0.0,
    currentGridYValue = 0.0,
    pageCamera = nil,
}

function CreatorEvents:Maintain()
    -- Zooming isn't handled through events anymore
    if self.zoomMode == ZOOM_MODE.TOGGLE then
        if IsControlJustPressed(2, "INPUT_INSPECT_ZOOM") then
            self.isZooming = not self.isZooming
            SignalBus:emit("zoom_updated", self.isZooming)
        end
    else
        if self.isZooming == false and IsControlPressed(2, "INPUT_INSPECT_ZOOM") then
            self.isZooming = true
            SignalBus:emit("zoom_updated", true)
        elseif self.isZooming == true and not IsControlPressed(2, "INPUT_INSPECT_ZOOM") then
            self.isZooming = false
            SignalBus:emit("zoom_updated", false)
        end
    end

    -- Poll the X grid of the currently focused item if we should
    if CreatorRenderer.shouldPollGridX or CreatorRenderer.shouldPollGridXY then
        -- Check if the focused item is a grid item
        local focusedItem = UI_ITEM_ID:GetIdFromHash(self.currentFocusedItem)
        if focusedItem and focusedItem ~= UI_ITEM_ID.INVALID then
            local itemType = UI_ITEM_ID:GetType(focusedItem)
            if itemType == UI_ITEM_TYPE.GRID_X or itemType == UI_ITEM_TYPE.GRID_XY then
                -- Update the X value
                local gridXValue = CreatorDatabinding:ReadFloat(DATABINDING_ID.ROOT__GRID__X_VALUE)

                -- Only trigger events if the value changes
                if self.currentGridXValue ~= gridXValue then
                    self.currentGridXValue = gridXValue
                    SignalBus:emit("grid_x_changed", focusedItem, gridXValue)
                end
            end
        end
    end

    -- Poll the Y grid of the currently focused item if we should
    if CreatorRenderer.shouldPollGridXY then
        -- Check if the focused item is a grid item
        local focusedItem = UI_ITEM_ID:GetIdFromHash(self.currentFocusedItem)
        if focusedItem and focusedItem ~= UI_ITEM_ID.INVALID then
            local itemType = UI_ITEM_ID:GetType(focusedItem)
            if itemType == UI_ITEM_TYPE.GRID_XY then
                -- Update the Y value
                local gridYValue = CreatorDatabinding:ReadFloat(DATABINDING_ID.ROOT__GRID__Y_VALUE)

                -- Only trigger events if the value changes
                if self.currentGridYValue ~= gridYValue then
                    self.currentGridYValue = gridYValue
                    SignalBus:emit("grid_y_changed", focusedItem, gridYValue)
                end
            end
        end
    end

    while EventsUiIsPending(`ui_character_creator_events`) do
        local data = DataView.ArrayBuffer(8 * 4)

        if Citizen.InvokeNative(Natives.EventsUiPeekMessage, `ui_character_creator_events`, data:Buffer()) ~= 0 then
            local event = data:GetInt32(0)
            local index = data:GetInt32(8)
            local parameter = data:GetInt32(16)

            if event == `ITEM_FOCUSED` then
                self.currentFocusedItem = parameter
                local ok, error = pcall(self.OnItemFocused, self, parameter)
                if not ok then
                    local enum = UI_ITEM_ID:GetIdFromHash(parameter)
                    Utils:Error(string.format("Failed to handle item focused event on item %s: %s", enum, error))
                end
            elseif event == `DATA_ADJUSTABLE_CHANGED` then
                parameter = self.currentFocusedItem
                local ok, error = pcall(self.OnDataAdjustableChanged, self, parameter, index)
                if not ok then
                    local enum = UI_ITEM_ID:GetIdFromHash(parameter)
                    Utils:Error(string.format("Failed to handle data adjustable changed event on item %s: %s", enum, error))
                end
            elseif event == `ITEM_SELECTED` then
                local ok, error = pcall(self.OnItemSelected, self, parameter)
                if not ok then
                    local enum = UI_ACTION_ID:GetIdFromHash(parameter)
                    Utils:Error(string.format("Failed to handle item selected event on item %s: %s", enum, error))
                end
            elseif event == `NEW_PAGE` then
                self.currentPage = parameter
                local ok, error = pcall(self.OnNewPage, self, parameter)
                if not ok then
                    local enum = UI_PAGE_ID:GetIdFromHash(parameter)
                    Utils:Error(string.format("Failed to handle new page event on page %s: %s", enum, error))
                end
            elseif event == `INDEX_CHANGE_REQUESTED` then
                local ok, error = pcall(self.OnIndexChangeRequested, self, parameter)
                if not ok then
                    local enum = UI_ITEM_ID:GetIdFromHash(parameter)
                    Utils:Error(string.format("Failed to handle index change requested event on item %s: %s", enum, error))
                end
            end
        end

        EventsUiPopMessage(`ui_character_creator_events`)
    end
end

function CreatorEvents:OnItemFocused(parameter)
    local itemId = UI_ITEM_ID:GetIdFromHash(parameter)
    if not itemId or itemId == UI_ITEM_ID.INVALID then return end

    if Creator:IsFlagSet(EDITOR_FLAG.RESTORE) then
        Utils:Debug("Skipped focus hooks due to restore flag:", UI_ITEM_ID:ToString(itemId))
        return
    end

    local itemType = UI_ITEM_ID:GetType(itemId)
    if not itemType then return end

    local uiData = UI_ITEM_ID:GetUi(itemId)
    if not uiData then return end

    CreatorRenderer:HideColorSwatch()
    CreatorRenderer:HideGrid(itemId)
    CreatorRenderer:UpdateItemFooter(itemId)

    if itemType == UI_ITEM_TYPE.COLOR then
        CreatorRenderer:ShowColorSwatch(itemId)
    elseif itemType == UI_ITEM_TYPE.GRID_X or itemType == UI_ITEM_TYPE.GRID_XY then
        CreatorRenderer:UpdateGrid(itemId)
        CreatorRenderer:ShowGrid(itemId)
    end

    local camera = UI_ITEM_ID:GetCamera(itemId) or self.pageCamera
    if camera then
        SignalBus:emit("camera_updated", camera)
    end

    SignalBus:emit("item_focused", itemId)
end

function CreatorEvents:OnDataAdjustableChanged(parameter, index)
    local itemId = UI_ITEM_ID:GetIdFromHash(parameter)
    if not itemId or itemId == UI_ITEM_ID.INVALID then return end

    local uiType = UI_ITEM_ID:GetType(itemId)
    if not uiType then
        error(string.format("Invalid UI type for item %s", UI_ITEM_ID:ToString(itemId)))
    end

    local databinding = UI_ITEM_ID:GetDatabinding(itemId)
    if not databinding then
        error(string.format("Invalid databinding for item %s", UI_ITEM_ID:ToString(itemId)))
    end

    CreatorRenderer:HideGrid(itemId)

    if uiType == UI_ITEM_TYPE.COLOR then
        local value = CreatorDatabinding:ReadInt(databinding.Value) + index
        CreatorRenderer:UpdateColorSwatch(itemId, value)
    elseif uiType == UI_ITEM_TYPE.GRID_X or uiType == UI_ITEM_TYPE.GRID_XY then
        CreatorRenderer:UpdateGrid(itemId)
        CreatorRenderer:ShowGrid(itemId)
    end

    local value = CreatorDatabinding:ReadInt(databinding.Value)
    SignalBus:emit("adjustable_changed", itemId, value)
end

function CreatorEvents:OnItemSelected(parameter)
    local actionId = UI_ACTION_ID:GetIdFromHash(parameter)
    if not actionId or actionId == UI_ACTION_ID.INVALID then return end

    local itemId = UI_ITEM_ID:GetIdFromHash(self.currentFocusedItem)
    if not itemId or itemId == UI_ITEM_ID.INVALID then return end

    -- Handled in the state loop, no need to emit anything
    if actionId == UI_ACTION_ID.ROTATE then return end

    if actionId == UI_ACTION_ID.CONFIRM_EDIT or actionId == UI_ACTION_ID.CANCEL_EDIT then
        Creator:CloseEditor()
    else
        SignalBus:emit("action_selected", actionId, itemId)
    end

    SignalBus:emit("item_selected", itemId)
end

function CreatorEvents:OnNewPage(parameter)
    local pageId = UI_PAGE_ID:GetIdFromHash(parameter)
    if not pageId or pageId == UI_PAGE_ID.INVALID then return end

    if Creator:IsFlagSet(EDITOR_FLAG.RESTORE) then
        Utils:Debug("Skipped new page hooks due to restore flag:", UI_PAGE_ID:ToString(pageId))
        return
    end

    local uiData = UI_PAGE_ID:GetUi(pageId)
    if not uiData then return end

    CreatorRenderer:UpdateHeaderLabel(uiData.Header)
    CreatorRenderer:UpdateSubheaderOverride(pageId)
    CreatorRenderer:UpdateSubheaderLabel(uiData.Subheader)

    local camera = UI_PAGE_ID:GetCamera(pageId)
    self.pageCamera = camera or { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE }

    SignalBus:emit("new_page", pageId)
end

function CreatorEvents:OnIndexChangeRequested(parameter)
    CreatorDatabinding:UpdateBlockedOverlays()

    local itemId = UI_ITEM_ID:GetIdFromHash(parameter)
    if not itemId or itemId == UI_ITEM_ID.INVALID then return end

    CreatorRenderer:UpdateItemFooter(itemId)

    SignalBus:emit("index_change_requested", itemId)
end

SignalBus:on("zoom_mode_changed", function(mode)
    if not mode then return end
    CreatorEvents.zoomMode = mode
end)

SignalBus:on("camera_updated", function(data)
    if not data then return end
    local zoomEnabled = data.Zoomed ~= nil and data.Zoomed ~= EDITOR_VIEW.INVALID
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__ZOOM_ENABLED, zoomEnabled)
end)

SignalBus:on("skintone_changed", function()
    if not Creator:IsAdvancedMode() then return end
    CreatorDatabinding:WriteOrHideHashArray(DATABINDING_ID.MAKEUP__BLUSHER__ARRAY, DATABINDING_ID.MAKEUP__BLUSHER__VISIBLE, CreatorRenderer:GetHeadAlbedoLabels(), "NATIVE_CREATOR_CUSTOM_HEAD_NONE")
    CreatorDatabinding:WriteInt(DATABINDING_ID.MAKEUP__BLUSHER__VALUE, Character.headAlbedo)
end)

SignalBus:on("hair_applied", function()
    if not Creator:IsDefaultMode() then return end
    if Character:IsFemale() then
        CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, false)
    else
        CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, true)
    end
end)

SignalBus:on("hair_removed", function()
    if not Creator:IsDefaultMode() then return end
    if Character:IsFemale() then
        CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, false)
    else
        CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, Character:WearingBeard())
    end
end)

SignalBus:on("beard_applied", function()
    if not Creator:IsDefaultMode() then return end
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, true)
    CreatorDatabinding:WriteBool(DATABINDING_ID.HAIR__BEARD_COLOR__ENABLED, true)
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__FACE__FACIAL_HAIR_HIDDEN, false)
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__FACE__FACIAL_HAIR_WORN, true)
end)

SignalBus:on("beard_removed", function()
    if not Creator:IsDefaultMode() then return end
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, Character:WearingHair())
    CreatorDatabinding:WriteBool(DATABINDING_ID.HAIR__BEARD_COLOR__ENABLED, false)
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__FACE__FACIAL_HAIR_HIDDEN, false)
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__FACE__FACIAL_HAIR_WORN, false)
end)

SignalBus:on("hair_color_applied", function(value)
    if not Creator:IsDefaultMode() then return end
    CreatorDatabinding:WriteInt(DATABINDING_ID.HAIR__HAIR_COLOR__VALUE, value)
    CreatorRenderer:UpdateColorSwatch(UI_ITEM_ID.HAIR__HAIR_COLOR, value)
end)

SignalBus:on("beard_color_applied", function(value)
    if not Creator:IsDefaultMode() then return end
    CreatorDatabinding:WriteInt(DATABINDING_ID.HAIR__BEARD_COLOR__VALUE, value)
    CreatorRenderer:UpdateColorSwatch(UI_ITEM_ID.HAIR__BEARD_COLOR, value)
end)

SignalBus:on("overlay_applied", function(layer)
    CreatorDatabinding:UpdateBlockedOverlays()

    local focusedItem = UI_ITEM_ID:GetIdFromHash(CreatorEvents.currentFocusedItem)
    if focusedItem then CreatorRenderer:UpdateItemFooter(focusedItem) end

    local supportsTint = OVERLAY_LAYER:GetSupportsTint(layer)
    if not supportsTint then return end

    local itemId = UI_ITEM_ID:GetIdFromOverlayLayer(layer)
    if not itemId or itemId == UI_ITEM_ID.INVALID then return end

    local swatchItemId = UI_ITEM_ID:GetSwatchItem(itemId)
    if not swatchItemId or swatchItemId == UI_ITEM_ID.INVALID then return end

    local swatchDatabinding = UI_ITEM_ID:GetDatabinding(swatchItemId)
    if not swatchDatabinding then return end

    CreatorDatabinding:WriteBool(swatchDatabinding.Visible, true)
    CreatorRenderer:UpdateColorSwatch(swatchItemId, Character:GetOverlayColor(layer))
end)

SignalBus:on("overlay_removed", function(layer)
    CreatorDatabinding:UpdateBlockedOverlays()

    local focusedItem = UI_ITEM_ID:GetIdFromHash(CreatorEvents.currentFocusedItem)
    if focusedItem then CreatorRenderer:UpdateItemFooter(focusedItem) end

    local supportsTint = OVERLAY_LAYER:GetSupportsTint(layer)
    if not supportsTint then return end

    local itemId = UI_ITEM_ID:GetIdFromOverlayLayer(layer)
    if not itemId or itemId == UI_ITEM_ID.INVALID then return end

    local swatchItemId = UI_ITEM_ID:GetSwatchItem(itemId)
    if not swatchItemId or swatchItemId == UI_ITEM_ID.INVALID then return end

    local swatchDatabinding = UI_ITEM_ID:GetDatabinding(swatchItemId)
    if not swatchDatabinding then return end

    CreatorDatabinding:WriteBool(swatchDatabinding.Visible, false)
end)

SignalBus:on("whistle_randomized", function(style, pitch, clarity)
    if not Creator:IsDefaultMode() then return end
    CreatorDatabinding:WriteInt(DATABINDING_ID.WHISTLE__STYLE__VALUE, style)
    CreatorDatabinding:WriteInt(DATABINDING_ID.WHISTLE__PITCH__VALUE, pitch)
    CreatorDatabinding:WriteInt(DATABINDING_ID.WHISTLE__CLARITY__VALUE, clarity)
end)

SignalBus:on("age_randomized", function(age)
    if not Creator:IsDefaultMode() then return end
    CreatorDatabinding:WriteInt(DATABINDING_ID.APPEARANCE__AGE__VALUE, age)
end)

SignalBus:on("custom_head_randomized", function(drawable, albedo, normal, material)
    if not Creator:IsAdvancedMode() then return end
    CreatorDatabinding:WriteInt(DATABINDING_ID.MAKEUP__FOUNDATION__VALUE, drawable)
    CreatorDatabinding:WriteInt(DATABINDING_ID.MAKEUP__BLUSHER__VALUE, albedo)
    CreatorDatabinding:WriteInt(DATABINDING_ID.MAKEUP__EYESHADOW__VALUE, normal)
    CreatorDatabinding:WriteInt(DATABINDING_ID.MAKEUP__EYELINER__VALUE, material)
end)

SignalBus:on("voice_randomized", function(style)
    if not Creator:IsAdvancedMode() then return end
    CreatorDatabinding:WriteInt(DATABINDING_ID.WHISTLE__STYLE__VALUE, style)
end)

SignalBus:on("randomized", function()
    CreatorDatabinding:ApplyFromCharacter()
end)
