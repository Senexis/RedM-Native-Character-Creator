local defaults = {
    stateXmlFile = 0,
    loadedXmlFile = 0,
    xmlRequestState = nil,
}

CreatorXml = setmetatable({}, { __index = defaults })

function CreatorXml:Reset()
    if ParseddataIsFileLoaded(self.stateXmlFile) == 1 then
        ParseddataUnloadFile(self.stateXmlFile)
    end

    for k in pairs(self) do
        if type(self[k]) == "function" then
            goto continue
        end
        self[k] = nil
        ::continue::
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

    -- DATAFILE::PARSEDDATA_RQ_FILLOUT_NODE
    local result, node = Citizen.InvokeNative(0x83C3ED532B6E5D07, Citizen.PointerValueInt(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())
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

    -- DATAFILE::_PARSEDDATA_RQ_GET_NUM_NODES
    return Citizen.InvokeNative(0xDF01B1F7A886B42D, self.xmlRequestState:Buffer(), Citizen.ResultAsInteger())
end

function CreatorXml:GetBool(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    -- DATAFILE::_PARSEDDATA_RQ_FILLOUT_BOOL
    local result, response = Citizen.InvokeNative(0x0D9138F3F8261DF7, Citizen.PointerValueInt(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())

    if result ~= 1 then return false end
    return response == 1
end

function CreatorXml:GetInt(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    -- DATAFILE::_PARSEDDATA_RQ_FILLOUT_INT
    local result, response = Citizen.InvokeNative(0xEF44ACC657352A35, Citizen.PointerValueInt(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())

    if result ~= 1 then return 0 end
    return response
end

function CreatorXml:GetFloat(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    -- DATAFILE::_PARSEDDATA_RQ_FILLOUT_FLOAT
    local result, response = Citizen.InvokeNative(0x7F034FC3E891B57A, Citizen.PointerValueFloat(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())

    if result ~= 1 then return 0.0 end
    return math.floor(response * 10000 + 0.5) / 10000
end

function CreatorXml:GetHash(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    -- DATAFILE::PARSEDDATA_RQ_FILLOUT_HASH
    local result, response = Citizen.InvokeNative(0xFBFF3FF2F5E80C0B, Citizen.PointerValueInt(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())

    if result ~= 1 then return 0 end
    return response
end

function CreatorXml:GetVector(queryId, parameter1, parameter2)
    local query = EDITOR_XML_QUERY:GetHash(queryId)
    if not query then error("Invalid query ID: " .. EDITOR_XML_QUERY:ToString(queryId), 2) end

    self.xmlRequestState:SetInt32(2 * 8, query or 0)
    self.xmlRequestState:SetInt32(3 * 8, parameter1 or 0)
    self.xmlRequestState:SetInt32(4 * 8, parameter2 or 0)

    -- DATAFILE::_PARSEDDATA_RQ_FILLOUT_VECTOR
    local result, response = Citizen.InvokeNative(0x06FBF89B12DA279C, Citizen.PointerValueVector(), self.xmlRequestState:Buffer(), Citizen.ReturnResultAnyway())

    if result ~= 1 then return vector3(0, 0, 0) end
    return response
end
