describe("CharacterBlend", function()
    before_each(function()
        _G.CharacterBlend = nil
        _G.OVERLAY_LAYER = {
            GetPriority = function(_, layer)
                if layer == 3 then return 30 end
                return nil
            end,
            GetSkintoneAlphas = function(_, layer)
                if layer == 3 then return { 0.2, 2.5, -1.0 } end
                return nil
            end,
            GetSupportsTint = function(_, layer)
                if layer == 3 then return true end
                return nil
            end,
            GetSupportsHair = function(_, layer)
                if layer == 3 then return true end
                return nil
            end
        }

        dofile("client/character/blend.lua")
    end)

    it("creates a blend with defaults", function()
        local blend = CharacterBlend:New()
        assert.equal("BLEND_NONE", blend.id)
        assert.equal(-1, blend.layer)
        assert.equal(1.0, blend.alpha)
    end)

    it("updates known fields and applies tint aliases", function()
        local blend = CharacterBlend:New()
        blend:Update({
            id = "BLEND_TEST",
            tint = 7
        })

        assert.equal("BLEND_TEST", blend.id)
        assert.equal(7, blend.tint0)
        assert.equal(7, blend.tint1)
        assert.equal(7, blend.tint2)
    end)

    it("refreshes overlay-derived fields when layer changes", function()
        local blend = CharacterBlend:New()
        blend:Update({ layer = 3 })

        assert.equal(30, blend.priority)
        assert.are.same({ 0.2, 2.5, -1.0 }, blend.skintoneAlphas)
        assert.is_true(blend.isTint)
        assert.is_true(blend.isHair)
    end)

    it("computes alpha and clamps invalid skintone alpha values", function()
        local blend = CharacterBlend:New({
            texAlpha = 0.5,
            alpha = 0.8,
            layer = 3
        })

        assert.near(0.08, blend:GetAlpha(1), 0.0001)
        assert.near(0.4, blend:GetAlpha(2), 0.0001)
        assert.near(0.0, blend:GetAlpha(3), 0.0001)
    end)
end)
