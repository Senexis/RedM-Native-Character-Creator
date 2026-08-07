---@class ROTATION_SETTINGS : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local ROTATION_SETTINGS = {
    ANIMATED = 1,
    SMOOTH   = 2,
}

---@type ROTATION_SETTINGS | EnumRegistry
ROTATION_SETTING = Enums.CreateRegistry(ROTATION_SETTINGS)
