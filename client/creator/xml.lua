local function GetDefaultData()
    return {
        stateXmlFile = 0,
        loadedXmlFile = 0,
        xmlRequestState = nil,
    }
end

local defaults = GetDefaultData()
CreatorXml = setmetatable({}, { __index = defaults })

function CreatorXml:Reset()
    if ParseddataIsFileLoaded(self.stateXmlFile) == 1 then
        ParseddataUnloadFile(self.stateXmlFile)
    end

    defaults = GetDefaultData()

    for k, v in pairs(defaults) do
        if type(v) ~= "function" then
            self[k] = v
        end
    end
end

function CreatorXml:Initialize()
    if ParseddataIsFileValid(self.stateXmlFile) ~= 1 then
        local file = ParseddataLoadFileHash(`CHARACTER_EDITOR_DATA`)
        if file == 0 then return false end

        self.stateXmlFile = file
    end

    if ParseddataIsFileLoaded(self.stateXmlFile) ~= 1 then
        return false
    end

    local queries = EDITOR_XML_QUERY:Pluck("Query", "Hash")
    for hash, query in pairs(queries) do
        ParseddataRegisterQuery(self.stateXmlFile, hash, query)
    end

    self.loadedXmlFile = self.stateXmlFile

    local request = DataView.ArrayBuffer(40)
    request:SetInt32(0 * 8, self.loadedXmlFile)
    request:SetInt32(1 * 8, 0)
    request:SetInt32(2 * 8, 0)
    request:SetInt32(3 * 8, 0)
    request:SetInt32(4 * 8, 0)

    self.xmlRequestState = request

    return true
end

function CreatorXml:RequestSetNode(node)
    self.xmlRequestState:SetInt32(1 * 8, node or 0)
end

function CreatorXml:RequestGetNode()
    return self.xmlRequestState:GetInt32(1 * 8)
end

function CreatorXml:RequestReset(node)
    self:RequestSetNode(node or 0)
    self.xmlRequestState:SetInt32(2 * 8, 0)
    self.xmlRequestState:SetInt32(3 * 8, 0)
    self.xmlRequestState:SetInt32(4 * 8, 0)
end

function CreatorXml:GetNode(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    local result, node = Citizen.InvokeNative(Natives.ParseddataRqFilloutNode, Citizen.PointerValueInt(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())
    if result ~= 1 then return false end

    self.xmlRequestState:SetInt32(1 * 8, node)
    return true
end

function CreatorXml:GetCount(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    return Citizen.InvokeNative(Natives.ParseddataRqGetNumNodes, self.xmlRequestState:Buffer(), Citizen.ResultAsInteger())
end

function CreatorXml:GetBool(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    local result, response = Citizen.InvokeNative(Natives.ParseddataRqFilloutBool, Citizen.PointerValueInt(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())

    if result ~= 1 then return false end
    return response == 1
end

function CreatorXml:GetInt(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    local result, response = Citizen.InvokeNative(Natives.ParseddataRqFilloutInt, Citizen.PointerValueInt(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())

    if result ~= 1 then return 0 end
    return response
end

function CreatorXml:GetFloat(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    local result, response = Citizen.InvokeNative(Natives.ParseddataRqFilloutFloat, Citizen.PointerValueFloat(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())

    if result ~= 1 then return 0.0 end
    return math.floor(response * 10000 + 0.5) / 10000
end

function CreatorXml:GetHash(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    local result, response = Citizen.InvokeNative(Natives.ParseddataRqFilloutHash, Citizen.PointerValueInt(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())

    if result ~= 1 then return 0 end
    return response
end

function CreatorXml:GetVector(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    local result, response = Citizen.InvokeNative(Natives.ParseddataRqFilloutVector, Citizen.PointerValueVector(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())

    if result ~= 1 then return vector3(0, 0, 0) end
    return response
end
