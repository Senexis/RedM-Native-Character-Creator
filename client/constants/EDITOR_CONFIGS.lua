---@class EDITOR_CONFIGS : EnumRegistry
---@field GetHash fun(self, id: number): integer|nil
---@field GetIdFromHash fun(self, hash: integer): number|nil
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field GetPedPreset fun(self, id: number): integer|nil
---@field ToString fun(self, id: number): string
local EDITOR_CONFIGS = {
    INVALID = 0,
    MALE    = 1,
    FEMALE  = 2,
}

---@type EDITOR_CONFIGS | EnumRegistry
EDITOR_CONFIG = Enums.CreateRegistry(EDITOR_CONFIGS)

EDITOR_CONFIG:AddAttribute("Hash", {
    [EDITOR_CONFIG.INVALID] = 0,
    [EDITOR_CONFIG.MALE]    = `MPINTRO_MALE`,
    [EDITOR_CONFIG.FEMALE]  = `MPINTRO_FEMALE`,
})

EDITOR_CONFIG:AddAttribute("PedPreset", {
    [EDITOR_CONFIG.INVALID] = 0,
    [EDITOR_CONFIG.MALE]    = `MALE_01`,
    [EDITOR_CONFIG.FEMALE]  = `FEMALE_01`,
})
