describe("SignalBus", function()
    local signalsPath = os.getenv("REPO_ROOT") .. "/client/signals.lua"

    before_each(function()
        _G.SignalBus = nil
        _G.__eventHandlers = {}
        _G.__currentResourceName = "native_cc_test"
        dofile(signalsPath)
        SignalBus:clear()
    end)

    it("emits events to registered listeners", function()
        local received = {}
        SignalBus:on("changed", function(a, b)
            received = { a, b }
        end)

        SignalBus:emit("changed", "alpha", 42)

        assert.are.same({ "alpha", 42 }, received)
    end)

    it("returns an unsubscribe function", function()
        local called = 0
        local unsubscribe = SignalBus:on("changed", function()
            called = called + 1
        end)

        SignalBus:emit("changed")
        unsubscribe()
        SignalBus:emit("changed")

        assert.equal(1, called)
    end)

    it("clears listeners only for matching onResourceStop", function()
        local called = 0
        SignalBus:on("changed", function()
            called = called + 1
        end)

        assert.is_function(_G.__eventHandlers.onResourceStop)

        _G.__eventHandlers.onResourceStop("another_resource")
        SignalBus:emit("changed")

        _G.__eventHandlers.onResourceStop("native_cc_test")
        SignalBus:emit("changed")

        assert.equal(1, called)
    end)
end)

