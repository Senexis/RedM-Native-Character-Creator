---@class INTRO_TO_EDIT_STATES : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local INTRO_TO_EDIT_STATES = {
    INIT     = 0,
    CAM      = 1,
    MOVE_NET = 2,
    COMPLETE = 3,
}

---@type INTRO_TO_EDIT_STATES | EnumRegistry
INTRO_TO_EDIT_STATE = Enums.CreateRegistry(INTRO_TO_EDIT_STATES)
