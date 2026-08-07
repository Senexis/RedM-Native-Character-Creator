---@class ANIMATION_SETTINGS : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local ANIMATION_SETTINGS = {
    DEFAULT  = 1,
    REDUCED  = 2,
    DISABLED = 3,
}

---@type ANIMATION_SETTINGS | EnumRegistry
ANIMATION_SETTING = Enums.CreateRegistry(ANIMATION_SETTINGS)
