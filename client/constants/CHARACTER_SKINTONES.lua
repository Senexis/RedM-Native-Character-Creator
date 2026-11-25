---@class CHARACTER_SKINTONES : EnumRegistry
---@field GetValue fun(self, id: number): integer|nil
---@field GetIdFromValue fun(self, value: integer): number|nil
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local CHARACTER_SKINTONES = {
    SKINTONE_01 = 1,
    SKINTONE_02 = 2,
    SKINTONE_03 = 3,
    SKINTONE_04 = 4,
    SKINTONE_05 = 5,
    SKINTONE_06 = 6,
}

---@type CHARACTER_SKINTONES | EnumRegistry
CHARACTER_SKINTONE = Enums.CreateRegistry(CHARACTER_SKINTONES)

-- The skin tone in the editor XML
CHARACTER_SKINTONE:AddAttribute("Value", {
    [CHARACTER_SKINTONE.SKINTONE_01] = 0,
    [CHARACTER_SKINTONE.SKINTONE_02] = 3,
    [CHARACTER_SKINTONE.SKINTONE_03] = 2,
    [CHARACTER_SKINTONE.SKINTONE_04] = 1,
    [CHARACTER_SKINTONE.SKINTONE_05] = 4,
    [CHARACTER_SKINTONE.SKINTONE_06] = 5,
})
