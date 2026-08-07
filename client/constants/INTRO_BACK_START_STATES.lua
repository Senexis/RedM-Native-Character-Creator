---@class INTRO_BACK_START_STATES : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local INTRO_BACK_START_STATES = {
    INIT        = 1,
    CAM         = 2,
    COMPLETE    = 5,
}

---@type INTRO_BACK_START_STATES | EnumRegistry
INTRO_BACK_START_STATE = Enums.CreateRegistry(INTRO_BACK_START_STATES)
