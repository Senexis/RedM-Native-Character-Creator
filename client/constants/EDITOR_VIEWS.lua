---@class EDITOR_VIEWS : EnumRegistry
---@field GetHash fun(self, id: number): integer|nil
---@field GetIdFromHash fun(self, hash: integer): number|nil
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local EDITOR_VIEWS = {
    INVALID         = -1,
    FULL_BODY       = 1,
    FULL_BODY_CLOSE = 2,
    FACE            = 3,
    FACE_CLOSE      = 4,
    EYES            = 5,
}

---@type EDITOR_VIEWS | EnumRegistry
EDITOR_VIEW = Enums.CreateRegistry(EDITOR_VIEWS)

EDITOR_VIEW:AddAttribute("Hash", {
    [EDITOR_VIEWS.INVALID]         = 0,
    [EDITOR_VIEWS.FULL_BODY]       = `FRONT_FULL_BODY`,
    [EDITOR_VIEWS.FULL_BODY_CLOSE] = `FRONT_FULL_BODY_CLOSE`,
    [EDITOR_VIEWS.FACE]            = `FRONT_FACE`,
    [EDITOR_VIEWS.FACE_CLOSE]      = `FRONT_FACE_CLOSE`,
    [EDITOR_VIEWS.EYES]            = `FRONT_EYES`,
})
