SignalBus = {
    listeners = {}
}

--- Subscribe to an event
---@param eventName string The name of the signal to listen for
---@param callback function The function to run when the signal fires
---@return function unsubscribe Call this returned function to remove the listener
function SignalBus:on(eventName, callback)
    if not self.listeners[eventName] then
        self.listeners[eventName] = {}
    end

    table.insert(self.listeners[eventName], callback)

    -- Return an immediate cleanup function for convenience
    return function()
        self:off(eventName, callback)
    end
end

--- Unsubscribe a specific callback from an event
---@param eventName string
---@param callback function
function SignalBus:off(eventName, callback)
    local handlers = self.listeners[eventName]
    if not handlers then return end

    for i = #handlers, 1, -1 do
        if handlers[i] == callback then
            table.remove(handlers, i)
            break
        end
    end
end

--- Emit a signal to all active listeners
---@param eventName string
---@param ... any Arguments passed to the callback handlers
function SignalBus:emit(eventName, ...)
    local handlers = self.listeners[eventName]
    if not handlers then return end

    for i = 1, #handlers do
        handlers[i](...)
    end
end

--- Wipe all registered listeners (useful on resource stop/reset)
function SignalBus:clear()
    self.listeners = {}
end

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    SignalBus:clear()
end)
