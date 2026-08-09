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
    APPLY_ATTRIBUTE_HEALTH  = 14,
    APPLY_ATTRIBUTE_STAMINA = 15,
    APPLY_ATTRIBUTE_DEADEYE = 16,
    APPLY_VOICE             = 17,
    APPLY_HEIGHT            = 18,
    APPLY_WEIGHT            = 19,

    -- Select actions
    PLAY_WHISTLE_SOUND      = 20,
    RANDOMIZE_ITEM          = 21,
    PLAY_VOCALIZATION       = 22,
    RANDOMIZE_ADVANCED_ITEM = 23,
}

---@type CHARACTER_ACTIONS | EnumRegistry
CHARACTER_ACTION = Enums.CreateRegistry(CHARACTER_ACTIONS)
