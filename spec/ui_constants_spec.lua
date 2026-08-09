describe("UI constants", function()
    before_each(function()
        _G.Enums = nil
        _G.UI_ITEM_TYPE = nil
        _G.DATABINDING_ID = nil
        _G.CHARACTER_ACTION = nil

        _G.CreatorState = {
            GetMode = function()
                return 1
            end
        }

        dofile("client/enums.lua")
        dofile("client/constants/UI_ITEM_TYPES.lua")
        dofile("client/constants/DATABINDING_IDS.lua")
        dofile("client/constants/CHARACTER_ACTIONS.lua")
    end)

    it("defines expected menu UI item types", function()
        assert.equal(1, UI_ITEM_TYPE.TEXT)
        assert.equal(2, UI_ITEM_TYPE.STEPPER)
        assert.equal(8, UI_ITEM_TYPE.SLIDER)
        assert.equal(9, UI_ITEM_TYPE.TANKS)
        assert.equal("TEXT", UI_ITEM_TYPE:GetName(1))
        assert.equal(9, UI_ITEM_TYPE:GetIdFromName("TANKS"))
    end)

    it("keeps databinding ids contiguous and complete", function()
        local values = DATABINDING_ID:Values()
        table.sort(values)

        assert.equal(421, #values)
        assert.equal(1, values[1])
        assert.equal(421, values[#values])

        for i, value in ipairs(values) do
            assert.equal(i, value)
        end
    end)

    it("exposes critical databinding keys used by the UI", function()
        assert.equal(1, DATABINDING_ID:GetIdFromName("ROOT"))
        assert.equal(48, DATABINDING_ID:GetIdFromName("MAIN__CONFIRM"))
        assert.equal(390, DATABINDING_ID:GetIdFromName("WHISTLE__STYLE"))
        assert.equal(421, DATABINDING_ID:GetIdFromName("ATTRIBUTES__DEADEYE__TOTAL_TANKS"))
        assert.equal("MAIN__NAME__VALUE", DATABINDING_ID:GetName(39))
    end)

    it("keeps character action ids unique and sequential", function()
        local values = CHARACTER_ACTION:Values()
        table.sort(values)

        assert.equal(23, #values)
        for i, value in ipairs(values) do
            assert.equal(i, value)
        end

        assert.equal(1, CHARACTER_ACTION.APPLY_HERITAGE)
        assert.equal(20, CHARACTER_ACTION.PLAY_WHISTLE_SOUND)
        assert.equal(23, CHARACTER_ACTION.RANDOMIZE_ADVANCED_ITEM)
    end)
end)
