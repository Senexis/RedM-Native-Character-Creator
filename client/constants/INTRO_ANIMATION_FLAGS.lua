---@class INTRO_ANIMATION_FLAGS : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local INTRO_ANIMATION_FLAGS = {
    IDLE              = 1 << 0,
    FACING_FORWARD    = 1 << 1,
    TURNING           = 1 << 4,
    STILL_IDLE        = 1 << 5,
    STEP_RIGHT_ACTIVE = 1 << 7,
    STEP_LEFT_ACTIVE  = 1 << 8,
    EYES_WIDENED      = 1 << 9,
    MOUTH_STARTED     = 1 << 10,
    MOUTH_OPENED      = 1 << 11,
    LOOK_LEFT         = 1 << 12,
    LOOK_RIGHT        = 1 << 13,
    EYES_STARTED      = 1 << 14,
    ZOOM_MOOD         = 1 << 15,
}

---@type INTRO_ANIMATION_FLAGS | EnumRegistry
INTRO_ANIMATION_FLAG = Enums.CreateRegistry(INTRO_ANIMATION_FLAGS)
