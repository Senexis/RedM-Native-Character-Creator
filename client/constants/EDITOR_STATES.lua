---@class EDITOR_STATES : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local EDITOR_STATES = {
    INVALID               = 0,
    INIT                  = 1,
    REGISTER_DATABINDINGS = 2,
    LOAD_XML              = 3,
    WAIT_TO_START         = 4,
    SETUP                 = 5,
    IN_MENU               = 6,
    IN_EDITOR             = 7,
    TRANSITION_TO_MENU    = 8,
    TRANSITION_TO_EDITOR  = 9,
    QUICK_SWITCH          = 10,
    TEARDOWN              = 11,
}

---@type EDITOR_STATES | EnumRegistry
EDITOR_STATE = Enums.CreateRegistry(EDITOR_STATES)
