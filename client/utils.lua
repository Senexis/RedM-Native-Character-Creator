Utils = {}

function Utils:CopyData(source, target)
    target = target or {}
    for k, v in pairs(source) do
        local vType = type(v)
        if vType == "table" then
            target[k] = self:CopyData(v, {})
        elseif vType ~= "function" and vType ~= "userdata" and vType ~= "thread" then
            target[k] = v
        end
    end
    return target
end

function Utils:Debug(...)
    if CreatorConfig.Debug ~= true then return end

    local args = { ... }
    local formattedArgs = {}

    -- Loop through all passed arguments and convert them to string
    for i = 1, select('#', ...) do
        table.insert(formattedArgs, tostring(args[i]))
    end

    -- Join all stringified arguments with a space separator
    print(string.format("^5[NativeCC] [DEBUG]^0 %s", table.concat(formattedArgs, " ")))
end

function Utils:Warn(...)
    local args = { ... }
    local formattedArgs = {}

    -- Loop through all passed arguments and convert them to string
    for i = 1, select('#', ...) do
        table.insert(formattedArgs, tostring(args[i]))
    end

    -- Join all stringified arguments with a space separator
    print(string.format("^3[NativeCC] [WARN]^0 %s", table.concat(formattedArgs, " ")))
end

function Utils:Error(...)
    local args = { ... }
    local formattedArgs = {}

    -- Loop through all passed arguments and convert them to string
    for i = 1, select('#', ...) do
        table.insert(formattedArgs, tostring(args[i]))
    end

    -- Join all stringified arguments with a space separator
    print(string.format("^1[NativeCC] [ERROR]^0 %s", table.concat(formattedArgs, " ")))
end
