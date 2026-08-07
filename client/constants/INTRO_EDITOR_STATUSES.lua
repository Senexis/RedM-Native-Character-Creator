---@class INTRO_EDITOR_STATUSES : EnumRegistry
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local INTRO_EDITOR_STATUSES = {
    STOPPED = 0,
    RUNNING = 1,
    CANCEL  = 2,
    CONFIRM = 3,
}

---@type INTRO_EDITOR_STATUSES | EnumRegistry
INTRO_EDITOR_STATUS = Enums.CreateRegistry(INTRO_EDITOR_STATUSES)
