describe("Utils", function()
    local utilsPath = os.getenv("REPO_ROOT") .. "/client/utils.lua"

    before_each(function()
        _G.Utils = nil
        _G.CreatorConfig = { Debug = false }
        dofile(utilsPath)
    end)

    it("deep copies tables and excludes non-serializable values", function()
        local co = coroutine.create(function()
        end)
        local file = io.tmpfile()
        local source = {
            nested = {
                value = 7
            },
            fn = function()
            end,
            thread = co,
            userdata = file
        }

        local copy = Utils:CopyData(source)
        file:close()

        assert.are_not.equal(source, copy)
        assert.are_not.equal(source.nested, copy.nested)
        assert.equal(7, copy.nested.value)
        assert.is_nil(copy.fn)
        assert.is_nil(copy.thread)
        assert.is_nil(copy.userdata)
    end)

    it("exports and imports data through msgpack hex encoding", function()
        local payload = { key = "value" }
        local packed = "A\0\255"

        msgpack.pack = function(value)
            assert.are.same(payload, value)
            return packed
        end

        msgpack.unpack = function(value)
            assert.equal(packed, value)
            return payload
        end

        local hex = Utils:ExportData(payload)
        local unpacked = Utils:ImportData(hex)

        assert.equal("4100ff", hex)
        assert.are.same(payload, unpacked)
    end)

    it("prints debug messages only when enabled", function()
        local output = {}
        local originalPrint = _G.print

        _G.print = function(message)
            table.insert(output, message)
        end

        Utils:Debug("hello", 123)
        assert.equal(0, #output)

        CreatorConfig.Debug = true
        Utils:Debug("hello", 123)

        _G.print = originalPrint

        assert.equal(1, #output)
        assert.equal("[NativeCC] hello 123", output[1])
    end)
end)

