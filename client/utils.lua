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

function Utils:ExportData(data)
    local binaryData = msgpack.pack(data)

    return (binaryData:gsub('.', function(c)
        return string.format('%02x', string.byte(c))
    end))
end

function Utils:ImportData(hexString)
    local binaryData = hexString:gsub('..', function(cc)
        return string.char(tonumber(cc, 16))
    end)

    return msgpack.unpack(binaryData)
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
    print(string.format("[NativeCC] %s", table.concat(formattedArgs, " ")))
end
