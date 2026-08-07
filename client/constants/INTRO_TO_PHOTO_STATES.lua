---@class INTRO_TO_PHOTO_STATES : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local INTRO_TO_PHOTO_STATES = {
    INIT     = 1,
    CAM      = 2,
    CHECK    = 3,
    COMPLETE = 5,
}

---@type INTRO_TO_PHOTO_STATES | EnumRegistry
INTRO_TO_PHOTO_STATE = Enums.CreateRegistry(INTRO_TO_PHOTO_STATES)
