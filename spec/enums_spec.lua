describe("Enums", function()
    before_each(function()
        _G.Enums = nil
        local modeContext = {
            mode = 1,
            GetMode = function(self)
                return self.mode
            end
        }
        _G.CreatorState = modeContext
        _G.Creator = modeContext

        dofile("client/enums.lua")
    end)

    it("creates registry and resolves names and ids", function()
        local Status = Enums.CreateRegistry({
            OPEN = 1,
            CLOSED = 2
        })

        assert.equal("OPEN", Status:GetName(1))
        assert.equal(2, Status:GetIdFromName("CLOSED"))
        assert.equal("UNKNOWN(99)", Status:ToString(99))
    end)

    it("supports custom attributes and reverse lookup", function()
        local Status = Enums.CreateRegistry({
            OPEN = 1,
            CLOSED = 2
        })

        Status:AddAttribute("Label", {
            [1] = "Open",
            [2] = "Closed"
        })

        assert.equal("Open", Status:GetLabel(1))
        assert.equal(2, Status:GetIdFromLabel("Closed"))
    end)

    it("supports mode-aware attributes", function()
        local Status = Enums.CreateRegistry({
            OPEN = 1,
            CLOSED = 2
        })

        Status:AddModeAttribute("Label", {
            [1] = { [1] = "Open A", [2] = "Closed A" },
            [2] = { [1] = "Open B", [2] = "Closed B" }
        })

        CreatorState.mode = 1
        Creator.mode = 1
        assert.equal("Open A", Status:GetLabel(1))
        assert.equal(2, Status:GetIdFromLabel("Closed A"))

        CreatorState.mode = 2
        Creator.mode = 2
        assert.equal("Open B", Status:GetLabel(1))
        assert.equal(2, Status:GetIdFromLabel("Closed B"))
    end)

    it("plucks values using a key mapping", function()
        local Status = Enums.CreateRegistry({
            OPEN = 1,
            CLOSED = 2
        })

        Status:AddAttribute("Label", {
            [1] = "Open",
            [2] = "Closed"
        })

        local mapped = Status:Pluck("Label", "Name")
        assert.are.same({
            OPEN = "Open",
            CLOSED = "Closed"
        }, mapped)
    end)
end)
