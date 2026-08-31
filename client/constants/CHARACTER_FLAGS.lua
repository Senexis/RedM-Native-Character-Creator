---@class CHARACTER_FLAGS : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local CHARACTER_FLAGS = {
    MODIFIED        = 1 << 0,
    RANDOMIZED      = 1 << 1,
    DIRTY           = 1 << 2,
    UPDATE_PED      = 1 << 3,
    UPDATE_HEIGHT   = 1 << 4,
    UPDATE_OVERLAYS = 1 << 5,
    OVERLAY_DIRTY   = 1 << 6,
}

---@type CHARACTER_FLAGS | EnumRegistry
CHARACTER_FLAG = Enums.CreateRegistry(CHARACTER_FLAGS)
