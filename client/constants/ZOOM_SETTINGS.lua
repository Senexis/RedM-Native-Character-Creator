---@class ZOOM_MODES : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local ZOOM_MODES = {
    HOLD   = 1,
    TOGGLE = 2,
}

---@type ZOOM_MODES | EnumRegistry
ZOOM_MODE = Enums.CreateRegistry(ZOOM_MODES)
