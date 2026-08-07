---@class EDITOR_FLAGS : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local EDITOR_FLAGS = {
    CLEAR              = 0,
    INITIALIZE         = 1 << 0,
    STARTED            = 1 << 1,
    ACTIVE             = 1 << 2,
    MENU_RUNNING       = 1 << 3,
    EDITOR_ACTIVE      = 1 << 4,
    EDITOR_RUNNING     = 1 << 5,
    DEFAULT_CONFIRMED  = 1 << 6,
    ADVANCED_CONFIRMED = 1 << 7,
    END_REQUESTED      = 1 << 8,
    CONFIRMED          = 1 << 9,
    CANCELLED          = 1 << 10,
    FACIAL_HAIR_HIDDEN = 1 << 11,
    HEADS_REQUESTED    = 1 << 12,
    REROLLING          = 1 << 13,
    NAME_PROMPT        = 1 << 14,
    IMPORT_PROMPT      = 1 << 15,
    QUICK_SWITCH       = 1 << 16,
    BODIES_REQUESTED   = 1 << 17,
}

---@type EDITOR_FLAGS | EnumRegistry
EDITOR_FLAG = Enums.CreateRegistry(EDITOR_FLAGS)
