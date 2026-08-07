---@class CREATOR_MODES : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local CREATOR_MODES = {
    MENU = 0,
    DEFAULT = 1,
    ADVANCED = 2,
}

---@type CREATOR_MODES | EnumRegistry
CREATOR_MODE = Enums.CreateRegistry(CREATOR_MODES)
