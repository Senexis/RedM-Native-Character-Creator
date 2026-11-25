---@class CHARACTER_ACTIONS : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local CHARACTER_ACTIONS = {
    APPLY_HERITAGE          = 1,
    APPLY_SKINTONE          = 2,
    APPLY_AGE_ALPHA         = 3,
    APPLY_BODY_BUILD        = 4,
    APPLY_EYE_COLOR         = 5,
    APPLY_TEETH             = 6,
    APPLY_HAIR_STYLE        = 7,
    APPLY_HAIR_COLOR        = 8,
    APPLY_BEARD_STYLE       = 9,
    APPLY_BEARD_COLOR       = 10,
    APPLY_WHISTLE_STYLE     = 11,
    APPLY_WHISTLE_PITCH     = 12,
    APPLY_WHISTLE_CLARITY   = 13,
    APPLY_HEIGHT            = 17,
    APPLY_WEIGHT            = 18,
    APPLY_HEAD_DRAWABLE     = 19,
    APPLY_HEAD_ALBEDO       = 20,
    APPLY_HEAD_NORMAL       = 21,
    APPLY_HEAD_MATERIAL     = 22,
    APPLY_VOICE             = 23,

    -- Select actions
    PLAY_WHISTLE_SOUND      = 24,
    RANDOMIZE_ITEM          = 25,
    PLAY_VOCALIZATION       = 26,
    RANDOMIZE_ADVANCED_ITEM = 27,
    MATCH_HAIR_COLOR        = 28,
    TOGGLE_BEARD            = 29,
    SHOW_BEARD              = 30,
    TOGGLE_CLOTHING         = 31,
    SHOW_CLOTHING           = 32,
}

---@type CHARACTER_ACTIONS | EnumRegistry
CHARACTER_ACTION = Enums.CreateRegistry(CHARACTER_ACTIONS)
