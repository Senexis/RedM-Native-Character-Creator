local repoRoot = assert(os.getenv("REPO_ROOT"), "REPO_ROOT environment variable must be set")

package.path = table.concat({
    repoRoot .. "/?.lua",
    repoRoot .. "/?/init.lua",
    package.path
}, ";")

_G.__eventHandlers = {}
_G.__currentResourceName = "native_cc_test"

function _G.AddEventHandler(eventName, callback)
    _G.__eventHandlers[eventName] = callback
end

function _G.GetCurrentResourceName()
    return _G.__currentResourceName
end

_G.CreatorConfig = {
    Debug = false
}

_G.msgpack = {
    pack = function()
        error("msgpack.pack mock not configured for test")
    end,
    unpack = function()
        error("msgpack.unpack mock not configured for test")
    end
}

