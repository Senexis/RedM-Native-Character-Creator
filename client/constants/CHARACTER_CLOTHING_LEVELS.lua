---@class CHARACTER_CLOTHING_LEVELS : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local CHARACTER_CLOTHING_LEVELS = {
    DEFAULT = 1,
    HATLESS = 2,
    TOPLESS = 3,
    NUDE    = 4,
}

---@type CHARACTER_CLOTHING_LEVELS | EnumRegistry
CHARACTER_CLOTHING_LEVEL = Enums.CreateRegistry(CHARACTER_CLOTHING_LEVELS)
