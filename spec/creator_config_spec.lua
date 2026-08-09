describe("CreatorConfig", function()
    before_each(function()
        _G.CreatorConfig = nil

        local nextOverlayId = 1
        _G.OVERLAY_LAYER = setmetatable({}, {
            __index = function(t, key)
                local value = nextOverlayId
                nextOverlayId = nextOverlayId + 1
                rawset(t, key, value)
                return value
            end
        })

        dofile("client/creator/config.lua")
    end)

    it("defines basic editor constraints and toggles", function()
        assert.is_false(CreatorConfig.Debug)
        assert.equal(50, CreatorConfig.MaxNameLength)
        assert.equal(18, CreatorConfig.MinAge)
        assert.equal(60, CreatorConfig.MaxAge)
        assert.is_true(CreatorConfig.RespectPresetLimits)
        assert.is_false(CreatorConfig.SkipWhistle)
        assert.is_false(CreatorConfig.SkipAttributePoints)
    end)

    it("defines valid attribute defaults and ranges", function()
        for _, key in ipairs({ "Health", "Stamina", "Deadeye" }) do
            local data = CreatorConfig.Attributes[key]
            assert.is_table(data)
            assert.is_true(data.Min <= data.Default)
            assert.is_true(data.Default <= data.Max)
        end
    end)

    it("provides selectable lists for appearance groups", function()
        assert.is_true(#CreatorConfig.MaleHairs > 0)
        assert.is_true(#CreatorConfig.FemaleHairs > 0)
        assert.is_true(#CreatorConfig.MaleBeards > 0)
        assert.is_true(#CreatorConfig.Eyes > 0)
        assert.is_true(#CreatorConfig.Teeth > 0)
        assert.is_true(#CreatorConfig.HairColors > 0)
    end)

    it("defines height, weight, and voice entries with required fields", function()
        for _, entry in ipairs(CreatorConfig.Heights) do
            assert.is_string(entry.id)
            assert.is_string(entry.label)
            assert.is_number(entry.value)
        end

        for _, entry in ipairs(CreatorConfig.Weights) do
            assert.is_string(entry.id)
            assert.is_string(entry.label)
            assert.is_number(entry.value)
        end

        for _, entry in ipairs(CreatorConfig.Voices) do
            assert.is_string(entry.id)
            assert.is_string(entry.label)
            assert.is_number(entry.value)
        end
    end)

    it("includes custom hair and beard fallbacks and tint maps", function()
        assert.is_table(CreatorConfig.CustomHairFallbacks)
        assert.is_string(CreatorConfig.CustomHairFallbacks.albedo)
        assert.is_string(CreatorConfig.CustomHairFallbacks.normal)
        assert.is_string(CreatorConfig.CustomHairFallbacks.material)
        assert.is_string(CreatorConfig.CustomHairFallbacks.palette)

        assert.is_table(CreatorConfig.CustomBeardFallbacks)
        assert.is_string(CreatorConfig.CustomBeardFallbacks.albedo)
        assert.is_string(CreatorConfig.CustomBeardFallbacks.normal)
        assert.is_string(CreatorConfig.CustomBeardFallbacks.material)
        assert.is_string(CreatorConfig.CustomBeardFallbacks.palette)

        local tintKey = CreatorConfig.HairColors[1]
        assert.is_table(CreatorConfig.CustomHairTints[tintKey])
        assert.is_table(CreatorConfig.CustomBeardTints[tintKey])
    end)

    it("defines overlay entries with required blend configuration", function()
        local checked = 0
        for _, layer in pairs(CreatorConfig.Overlays) do
            if type(layer) == "table" and #layer > 0 then
                local item = layer[1]
                assert.is_string(item.id)
                assert.is_string(item.blend)
                checked = checked + 1
            end
        end

        assert.is_true(checked > 0)
    end)
end)
