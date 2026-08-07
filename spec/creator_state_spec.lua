describe("CreatorState", function()
    before_each(function()
        _G.CreatorState = nil

        _G.CREATOR_MODE = { DEFAULT = 1, ADVANCED = 2 }
        _G.UI_ITEM_TYPE = { GRID_X = 1, GRID_XY = 2 }
        _G.DATABINDING_ID = {
            ROOT__GRID__X_VALUE = 11,
            ROOT__GRID__Y_VALUE = 12,
        }

        local focusedId = 0
        local focusedType = UI_ITEM_TYPE.GRID_XY

        _G.UI_ITEM_ID = {
            INVALID = -1,
            GetIdFromHash = function(_, hash)
                if hash == focusedId then return focusedId end
                return nil
            end,
            GetType = function(_, _)
                return focusedType
            end,
        }

        local xValue = 0.0
        local yValue = 0.0

        _G.CreatorDatabinding = {
            ReadFloat = function(_, binding)
                if binding == DATABINDING_ID.ROOT__GRID__X_VALUE then
                    return xValue
                end
                return yValue
            end,
        }

        local emissions = {}
        _G.SignalBus = {
            emit = function(_, name, ...)
                emissions[#emissions + 1] = { name = name, args = { ... } }
            end,
        }

        local updateTextCalls = 0
        _G.CreatorRenderer = {
            UpdateText = function()
                updateTextCalls = updateTextCalls + 1
            end,
        }

        _G.CreatorPresets = {
            GetHeritages = function()
                return { { id = "HERITAGE_A" }, { id = "HERITAGE_B" } }
            end,
            GetExpressionZonePresets = function(_, zone)
                return { { id = zone .. "_A" }, { id = zone .. "_B" } }
            end,
        }

        _G.PED_EXPRESSION_ZONE = {
            GetQuery = function(_, zone)
                return zone == 1 and "query" or nil
            end,
            GetName = function(_, zone)
                return zone == 2 and "NOSE" or "UNKNOWN"
            end,
        }

        _G.Character = {
            gender = "M",
            IsMale = function(self)
                return self.gender == "M"
            end,
            IsFemale = function(self)
                return self.gender == "F"
            end,
            GetGenderShort = function(self)
                return self.gender
            end,
            GetHairColorString = function()
                return "M"
            end,
            GetBeardColorString = function()
                return "M"
            end,
        }

        _G.OVERLAY_LAYER = {
            EYEBROWS = 1,
            HEAD_HAIR = 2,
            FACIAL_HAIR = 3,
        }

        _G.CreatorConfig = {
            MaleHairs = { "NONE", 2 },
            FemaleHairs = { 1 },
            CustomMaleHairs = { { id = "CUSTOM_M" } },
            CustomFemaleHairs = { { id = "CUSTOM_F" } },
            HairColors = { "001", "002" },
            MaleBeards = { "NONE", 3 },
            CustomMaleBeards = { { id = "CUSTOM_BEARD" } },
            Overlays = {
                [OVERLAY_LAYER.EYEBROWS] = {
                    [1] = { id = "BROW_%s", gender = "M" },
                    [2] = { id = "BROW_%s", gender = "F" },
                },
            },
        }

        _G.CharacterOverlay = {
            GetLayerColors = function()
                return {
                    BLEND_A = { "BLEND_NONE", "BLEND_B" },
                    BLEND_NONE = { "BLEND_B" },
                }
            end,
        }

        _G.CharacterBlends = {
            Get = function(_, _, blend)
                if blend == "BLEND_B" then
                    return { palette = 9, tint0 = 1, tint1 = 2, tint2 = 3 }
                end
                return { palette = 0 }
            end,
        }

        local zoomPressed = false
        _G.IsControlPressed = function(_, _)
            return zoomPressed
        end

        dofile("client/creator/state.lua")

        CreatorState.currentFocusedItem = focusedId
        CreatorState.shouldPollGridX = true
        CreatorState.shouldPollGridXY = true

        _G.__creator_state_test = {
            setGrid = function(x, y)
                xValue = x
                yValue = y
            end,
            setZoom = function(pressed)
                zoomPressed = pressed
            end,
            setFocusedType = function(itemType)
                focusedType = itemType
            end,
            emissions = emissions,
            updateTextCalls = function()
                return updateTextCalls
            end,
        }
    end)

    it("sets mode and refreshes renderer text", function()
        CreatorState:SetMode(CREATOR_MODE.ADVANCED)

        assert.equal(CREATOR_MODE.ADVANCED, CreatorState:GetMode())
        assert.equal(1, __creator_state_test.updateTextCalls())
        assert.is_true(CreatorState:IsAdvancedMode())
    end)

    it("emits zoom updates when inspect zoom control changes", function()
        __creator_state_test.setZoom(true)
        CreatorState:Maintain()

        __creator_state_test.setZoom(false)
        CreatorState:Maintain()

        assert.equal("zoom_updated", __creator_state_test.emissions[1].name)
        assert.are.same({ true }, __creator_state_test.emissions[1].args)
        assert.equal("zoom_updated", __creator_state_test.emissions[2].name)
        assert.are.same({ false }, __creator_state_test.emissions[2].args)
    end)

    it("polls grid values and emits only when values change", function()
        __creator_state_test.setGrid(0.25, 0.5)
        CreatorState:Maintain()
        CreatorState:Maintain()

        assert.equal("grid_x_changed", __creator_state_test.emissions[1].name)
        assert.equal("grid_y_changed", __creator_state_test.emissions[2].name)
        assert.equal(2, #__creator_state_test.emissions)
    end)

    it("builds preset labels from preset data or fallback", function()
        assert.are.same({ "1_A", "1_B" }, CreatorState:GetPresetLabels(1))
        assert.are.same({ "NATIVE_CREATOR_NOSE_00" }, CreatorState:GetPresetLabels(2))
    end)

    it("builds hair labels for male and female", function()
        Character.gender = "M"
        assert.are.same({ "CLOTHING_ITEM_HAIR_NONE", "BARBER_STYLE_M_HAIR_002_PAGE", "CUSTOM_M" }, CreatorState:GetHairLabels())

        Character.gender = "F"
        assert.are.same({ "BARBER_STYLE_F_HAIR_001_PAGE", "CUSTOM_F" }, CreatorState:GetHairLabels())
    end)

    it("formats overlay labels and creates overlay swatches", function()
        Character.gender = "M"
        local labels = CreatorState:GetOverlayLabels(OVERLAY_LAYER.EYEBROWS)
        assert.equal("CHAR_CREATOR_LAYER_NONE", labels[1])
        assert.equal("BROW_M", labels[2])
        assert.equal(2, #labels)

        Character.gender = "F"
        local swatches = CreatorState:GetOverlaySwatches(OVERLAY_LAYER.EYEBROWS)
        assert.are.same({
            swatch = "UISW_FLAT_CK000",
            palette = 9,
            tint0 = 1,
            tint1 = 2,
            tint2 = 3,
        }, swatches.BLEND_B)
    end)
end)
