---@class INTRO_BACK_EDIT_STATES : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local INTRO_BACK_EDIT_STATES = {
    INIT        = 1,
    CAM         = 2,
    OVERLAY     = 3,
    WALK        = 4,
    ANIM_FINISH = 5,
    COMPLETE    = 6,
}

---@type INTRO_BACK_EDIT_STATES | EnumRegistry
INTRO_BACK_EDIT_STATE = Enums.CreateRegistry(INTRO_BACK_EDIT_STATES)
