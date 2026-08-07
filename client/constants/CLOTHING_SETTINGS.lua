---@class CLOTHING_SETTINGS : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local CLOTHING_SETTINGS = {
    DEFAULT = 1,
    HATLESS = 2,
    TOPLESS = 3,
    NUDE    = 4,
}

---@type CLOTHING_SETTINGS | EnumRegistry
CLOTHING_SETTING = Enums.CreateRegistry(CLOTHING_SETTINGS)
