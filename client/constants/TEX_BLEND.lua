---@class TEX_BLENDS : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local TEX_BLENDS = {
    ALPHA = 0,
    OVERLAY = 1,
    MULTIPLY = 2,
}

---@type TEX_BLENDS | EnumRegistry
TEX_BLEND = Enums.CreateRegistry(TEX_BLENDS)
