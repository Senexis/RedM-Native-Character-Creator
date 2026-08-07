---@class INTRO_FLAGS : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local INTRO_FLAGS = {
    CLEAR                        = 0,
    FORCE_EXIT                   = 1 << 0,
    PLAYER_POSITION_IN_INTRO     = 1 << 1,
    IS_REROLLING                 = 1 << 2,
    PED_IN_PHOTO_SEAT            = 1 << 3,
    FORCE_SELECT_ACTIVE_PED      = 1 << 5,
    PLAYER_CHOSE_SKIP_INTRO      = 1 << 6,
    NEW_CHARACTER_SAVE_TRIGGERED = 1 << 7,
    GENDER_SELECT_SCENESET_SET   = 1 << 9,
    CUSTOMIZATION_SCENESET_SET   = 1 << 10,
    EXIT_REQUESTED               = 1 << 12,
    PED_PRESET_SELECTED          = 1 << 13,
    IDLE_DIALOG_PLAYED           = 1 << 14,
    ROOM_DIALOG_STARTED          = 1 << 15,
    ROOM_DIALOG_PLAYED           = 1 << 16,
    DELAYED_SCREEN_FADE_IN       = 1 << 17,
    REROLL_CANCEL_ALERT_CREATED  = 1 << 18,
    REROLL_CANCEL_ALERT_CONFIRM  = 1 << 20,
    REROLL_CANCEL_ALERT_CANCEL   = 1 << 21,
    EDITOR_ZOOMED                = 1 << 22,
    MUGSHOT_TITLE_PROMPT         = 1 << 23,
    MALE_PED_RANDOMIZED          = 1 << 24,
    FEMALE_PED_RANDOMIZED        = 1 << 25,
    SUPPRESS_FIDGETS             = 1 << 26,
    SUPPRESS_ANIMATION           = 1 << 27,
    SUPPRESS_ROTATION            = 1 << 28,
}

---@type INTRO_FLAGS | EnumRegistry
INTRO_FLAG = Enums.CreateRegistry(INTRO_FLAGS)
