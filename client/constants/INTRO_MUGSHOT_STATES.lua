---@class INTRO_MUGSHOT_STATES : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local INTRO_MUGSHOT_STATES = {
    PROMPT        = 1,
    INIT          = 2,
    WETPLATE      = 3,
    REQUEST_PHOTO = 4,
    START_PHOTO   = 5,
    TAKE_PHOTO    = 6,
    SAVE_PHOTO    = 7,
    FADE          = 8,
    COMPLETE      = 9,
}

---@type INTRO_MUGSHOT_STATES | EnumRegistry
INTRO_MUGSHOT_STATE = Enums.CreateRegistry(INTRO_MUGSHOT_STATES)
