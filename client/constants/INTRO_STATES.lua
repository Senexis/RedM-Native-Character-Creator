---@class INTRO_STATES : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local INTRO_STATES = {
    WAITING_TO_START             = 0,
    INIT                         = 1,
    LOAD_ASSETS                  = 2,
    LOAD_AREA                    = 3,
    CREATE_MOCAP_PEDS            = 4,
    CREATE_PED_PRESETS           = 5,
    APPLY_CLOTHES                = 6,
    APPLY_RANDOMIZATION          = 7,
    INIT_CAM                     = 8,
    INTRO                        = 9,
    SELECT_GENDER                = 10,
    TRANSITION_TO_CUSTOMIZE      = 11,
    TRANSITION_BACK_TO_INTRO     = 12,
    CUSTOMIZE                    = 13,
    TRANSITION_TO_MUGSHOT        = 14,
    TRANSITION_BACK_TO_CUSTOMIZE = 15,
    MUGSHOT                      = 16,
    CANCEL_BACK_TO_FREEROAM      = 17,
    CONFIRM_BACK_TO_FREEROAM     = 18,
    EXIT                         = 19,
}

---@type INTRO_STATES | EnumRegistry
INTRO_STATE = Enums.CreateRegistry(INTRO_STATES)
