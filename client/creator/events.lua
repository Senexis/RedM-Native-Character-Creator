CreatorEvents = {}

function CreatorEvents:OnToggleBeard()
    if CreatorState.shouldHideBeard == true then
        Character:RemoveBeard()
    else
        Character:ApplyBeard()
    end
end

function CreatorEvents:Maintain()
    while EventsUiIsPending(`ui_character_creator_events`) do
        local data = DataView.ArrayBuffer(8 * 4)

        if Citizen.InvokeNative(0x90237103F27F7937, `ui_character_creator_events`, data:Buffer()) ~= 0 then -- EVENTS_UI_PEEK_MESSAGE
            local event = data:GetInt32(0)
            local index = data:GetInt32(8)
            local parameter = data:GetInt32(16)

            if event == `ITEM_FOCUSED` then
                CreatorState.currentFocusedItem = parameter
                local ok, error = pcall(CreatorEvents.OnItemFocused, CreatorEvents, parameter)
                if not ok then
                    local enum = UI_ITEM_ID:GetIdFromHash(parameter)
                    Utils:Debug(string.format("Failed to handle item focused event on item %s: %s", enum, error))
                end
            elseif event == `DATA_ADJUSTABLE_CHANGED` then
                parameter = CreatorState.currentFocusedItem
                local ok, error = pcall(CreatorEvents.OnDataAdjustableChanged, CreatorEvents, parameter, index)
                if not ok then
                    local enum = UI_ITEM_ID:GetIdFromHash(parameter)
                    Utils:Debug(string.format("Failed to handle data adjustable changed event on item %s: %s", enum, error))
                end
            elseif event == `ITEM_SELECTED` then
                local ok, error = pcall(CreatorEvents.OnItemSelected, CreatorEvents, parameter)
                if not ok then
                    local enum = UI_ACTION_ID:GetIdFromHash(parameter)
                    Utils:Debug(string.format("Failed to handle item selected event on item %s: %s", enum, error))
                end
            elseif event == `NEW_PAGE` then
                CreatorState.currentPage = parameter
                local ok, error = pcall(CreatorEvents.OnNewPage, CreatorEvents, parameter)
                if not ok then
                    local enum = UI_PAGE_ID:GetIdFromHash(parameter)
                    Utils:Debug(string.format("Failed to handle new page event on page %s: %s", enum, error))
                end
            elseif event == `INDEX_CHANGE_REQUESTED` then
                local ok, error = pcall(CreatorEvents.OnIndexChangeRequested, CreatorEvents, parameter)
                if not ok then
                    local enum = UI_ITEM_ID:GetIdFromHash(parameter)
                    Utils:Debug(string.format("Failed to handle index change requested event on item %s: %s", enum, error))
                end
            end
        end

        EventsUiPopMessage(`ui_character_creator_events`)
    end
end

function CreatorEvents:OnItemFocused(parameter)
    local itemId = UI_ITEM_ID:GetIdFromHash(parameter)
    if not itemId or itemId == UI_ITEM_ID.INVALID then return end

    local itemType = UI_ITEM_ID:GetType(itemId)
    if not itemType then return end

    local uiData = UI_ITEM_ID:GetUi(itemId)
    if not uiData then return end

    CreatorRenderer:HideColorSwatch()
    CreatorRenderer:HideGrid()
    CreatorRenderer:UpdateItemFooter(itemId)

    if itemType == UI_ITEM_TYPE.COLOR then
        CreatorRenderer:ShowColorSwatch(itemId)
    elseif itemType == UI_ITEM_TYPE.GRID_X or itemType == UI_ITEM_TYPE.GRID_XY then
        CreatorRenderer:UpdateGrid(itemId)
        CreatorRenderer:ShowGrid(itemId)
    end

    local camera = UI_ITEM_ID:GetCamera(itemId) or CreatorState.pageCamera
    if camera then
        SignalBus:emit("camera_updated", camera)
    end

    if itemId == UI_ITEM_ID.APPEARANCE__TEETH then
        SignalBus:emit("show_teeth", true)
    else
        SignalBus:emit("show_teeth", false)
    end

    if itemId == UI_ITEM_ID.APPEARANCE__EYE_COLOR or itemId == UI_ITEM_ID.LIFESTYLE__EYE_REDNESS then
        SignalBus:emit("show_eyes", true)
    else
        SignalBus:emit("show_eyes", false)
    end
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

    CreatorRenderer:HideGrid()

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

    local itemId = UI_ITEM_ID:GetIdFromHash(CreatorState.currentFocusedItem)

    if actionId == UI_ACTION_ID.TOGGLE_FACIAL_HAIR then
        if CreatorState.shouldHideBeard == true then
            CreatorState.shouldHideBeard = false
        else
            CreatorState.shouldHideBeard = true
        end
        self:OnToggleBeard()
    elseif actionId == UI_ACTION_ID.RESET_FACIAL_HAIR then
        CreatorState.shouldHideBeard = false
        self:OnToggleBeard()
    elseif actionId == UI_ACTION_ID.MATCH_HAIR_COLOR then
        if itemId == UI_ITEM_ID.HAIR__BEARD_COLOR then
            local beardColor = Character.beardColor
            Character:ApplyHairColor(beardColor)

            local value = CreatorDatabinding:ReadInt(DATABINDING_ID.HAIR__BEARD_COLOR__VALUE)
            CreatorRenderer:UpdateColorSwatch(UI_ITEM_ID.HAIR__HAIR_COLOR, value)
        else
            local hairColor = Character.hairColor
            Character:ApplyBeardColor(hairColor)

            local value = CreatorDatabinding:ReadInt(DATABINDING_ID.HAIR__HAIR_COLOR__VALUE)
            CreatorRenderer:UpdateColorSwatch(UI_ITEM_ID.HAIR__BEARD_COLOR, value)
        end

        CharacterOverlay:RequestUpdate()
    elseif actionId == UI_ACTION_ID.CONFIRM_EDIT then
        Creator:CloseEditor(true)
    elseif actionId == UI_ACTION_ID.CANCEL_EDIT then
        Creator:CloseEditor(true)
    elseif actionId == UI_ACTION_ID.ROTATE then
        -- Handled in the state loop, no need to emit anything
    else
        SignalBus:emit("action_selected", actionId, itemId)
    end
end

function CreatorEvents:OnNewPage(parameter)
    CreatorDatabinding:UpdateBlockedOverlays()

    local pageId = UI_PAGE_ID:GetIdFromHash(parameter)
    if not pageId or pageId == UI_PAGE_ID.INVALID then return end

    local uiData = UI_PAGE_ID:GetUi(pageId)
    if not uiData then return end

    CreatorRenderer:UpdateHeaderLabel(uiData.Header)
    CreatorRenderer:UpdateSubheaderOverride(pageId)
    CreatorRenderer:UpdateSubheaderLabel(uiData.Subheader)

    if CreatorState.shouldHideBeard == true then
        CreatorState.shouldHideBeard = false
        self:OnToggleBeard()
    end

    local camera = UI_PAGE_ID:GetCamera(pageId)
    CreatorState.pageCamera = camera or { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE }
end

function CreatorEvents:OnIndexChangeRequested(parameter)
    CreatorDatabinding:UpdateBlockedOverlays()

    local itemId = UI_ITEM_ID:GetIdFromHash(parameter)
    if not itemId or itemId == UI_ITEM_ID.INVALID then return end

    CreatorRenderer:UpdateItemFooter(itemId)
end

SignalBus:on("camera_updated", function(data)
    if not data then return end
    local zoomEnabled = data.Zoomed ~= nil and data.Zoomed ~= EDITOR_VIEW.INVALID
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__ZOOM_ENABLED, zoomEnabled)
end)

SignalBus:on("hair_applied", function()
    if Character:IsFemale() then
        CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, false)
    else
        CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, true)
    end
end)

SignalBus:on("hair_removed", function()
    if Character:IsFemale() then
        CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, false)
    else
        CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, Character:WearingBeard())
    end
end)

SignalBus:on("beard_applied", function()
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, true)
    CreatorDatabinding:WriteBool(DATABINDING_ID.HAIR__BEARD_COLOR__ENABLED, true)
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__FACE__FACIAL_HAIR_HIDDEN, false)
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__FACE__FACIAL_HAIR_WORN, true)
end)

SignalBus:on("beard_removed", function()
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__HAIR_MATCH__ENABLED, Character:WearingHair())
    CreatorDatabinding:WriteBool(DATABINDING_ID.HAIR__BEARD_COLOR__ENABLED, false)
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__FACE__FACIAL_HAIR_HIDDEN, false)
    CreatorDatabinding:WriteBool(DATABINDING_ID.ROOT__FACE__FACIAL_HAIR_WORN, false)
end)

SignalBus:on("overlay_applied", function(layer)
    CreatorDatabinding:UpdateBlockedOverlays()

    local focusedItem = UI_ITEM_ID:GetIdFromHash(CreatorState.currentFocusedItem)
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

    local focusedItem = UI_ITEM_ID:GetIdFromHash(CreatorState.currentFocusedItem)
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
    CreatorDatabinding:WriteInt(DATABINDING_ID.WHISTLE__STYLE__VALUE, style)
    CreatorDatabinding:WriteInt(DATABINDING_ID.WHISTLE__PITCH__VALUE, pitch)
    CreatorDatabinding:WriteInt(DATABINDING_ID.WHISTLE__CLARITY__VALUE, clarity)
end)

SignalBus:on("age_randomized", function(age)
    CreatorDatabinding:WriteInt(DATABINDING_ID.APPEARANCE__AGE__VALUE, age)
end)

SignalBus:on("voice_randomized", function(style)
    CreatorDatabinding:WriteInt(DATABINDING_ID.WHISTLE__STYLE__VALUE, style)
end)

SignalBus:on("randomized", function()
    CreatorDatabinding:ApplyFromCharacter()
end)
