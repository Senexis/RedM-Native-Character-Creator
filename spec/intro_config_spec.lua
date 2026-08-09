describe("IntroConfig", function()
    before_each(function()
        _G.IntroConfig = nil
        _G.EDITOR_CONFIG = {
            MALE = 0,
            FEMALE = 1,
        }

        dofile("client/intro/config.lua")
    end)

    it("uses expected feature toggles", function()
        assert.is_true(IntroConfig.UseCutscene)
        assert.is_true(IntroConfig.UseDialog)
        assert.is_false(IntroConfig.UseCustomizeDialog)
    end)

    it("defines outfit presets for male and female", function()
        assert.is_table(IntroConfig.Outfits[EDITOR_CONFIG.MALE])
        assert.is_table(IntroConfig.Outfits[EDITOR_CONFIG.FEMALE])
        assert.is_true(#IntroConfig.Outfits[EDITOR_CONFIG.MALE] > 0)
        assert.is_true(#IntroConfig.Outfits[EDITOR_CONFIG.FEMALE] > 0)
        assert.is_string(IntroConfig.Outfits[EDITOR_CONFIG.MALE][1][1])
        assert.is_string(IntroConfig.Outfits[EDITOR_CONFIG.FEMALE][1][1])
    end)

    it("defines first names and surnames", function()
        assert.is_true(#IntroConfig.Names[EDITOR_CONFIG.MALE] > 0)
        assert.is_true(#IntroConfig.Names[EDITOR_CONFIG.FEMALE] > 0)
        assert.is_true(#IntroConfig.Names.surnames > 0)
    end)

    it("uses a valid fidget cooldown range", function()
        assert.is_number(IntroConfig.FidgetCooldownMin)
        assert.is_number(IntroConfig.FidgetCooldownMax)
        assert.is_true(IntroConfig.FidgetCooldownMin > 0)
        assert.is_true(IntroConfig.FidgetCooldownMax >= IntroConfig.FidgetCooldownMin)
    end)

    it("defines non-empty outfit item entries", function()
        for _, outfits in pairs(IntroConfig.Outfits) do
            for _, outfit in ipairs(outfits) do
                assert.is_true(#outfit > 0)
                for _, item in ipairs(outfit) do
                    assert.is_string(item)
                    assert.is_true(#item > 0)
                end
            end
        end
    end)

    it("includes valid timecycle modifier entries", function()
        assert.is_true(#IntroConfig.TimecycleModifiers > 0)

        local modifier = IntroConfig.TimecycleModifiers[1]
        assert.is_string(modifier.label)
        assert.is_string(modifier.value)
    end)
end)
