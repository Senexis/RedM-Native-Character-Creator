---@class UI_ITEM_TYPES : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local UI_ITEM_TYPES = {
    TEXT    = 1,
    STEPPER = 2,
    COLOR   = 3,
    INTEGER = 4,
    PRESET  = 5,
    GRID_XY = 6,
    GRID_X  = 7,
    SLIDER  = 8,
    TANKS   = 9,
}

---@type UI_ITEM_TYPES | EnumRegistry
UI_ITEM_TYPE = Enums.CreateRegistry(UI_ITEM_TYPES)
