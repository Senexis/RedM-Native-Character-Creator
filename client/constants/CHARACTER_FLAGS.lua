---@class CHARACTER_FLAGS : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local CHARACTER_FLAGS = {
    DIRTY           = 1 << 0,
    UPDATE_PED      = 1 << 1,
    UPDATE_HEIGHT   = 1 << 2,
    UPDATE_OVERLAYS = 1 << 3,
    OVERLAY_DIRTY   = 1 << 4,
}

---@type CHARACTER_FLAGS | EnumRegistry
CHARACTER_FLAG = Enums.CreateRegistry(CHARACTER_FLAGS)
