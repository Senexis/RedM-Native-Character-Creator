---@class CHARACTER_BODY_BUILDS : EnumRegistry
---@field GetHash fun(self, id: number): integer|nil
---@field GetIdFromHash fun(self, hash: integer): number|nil
---@field GetOutfit fun(self, id: number): string|nil
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local CHARACTER_BODY_BUILDS = {
    SKINNY_MUSCULAR = 0,
    SKINNY          = 1,
    NEUTRAL         = 2,
    HEAVY_MUSCULAR  = 3,
    HEAVY           = 4,
}

---@type CHARACTER_BODY_BUILDS | EnumRegistry
CHARACTER_BODY_BUILD = Enums.CreateRegistry(CHARACTER_BODY_BUILDS)

CHARACTER_BODY_BUILD:AddAttribute("Hash", {
    [CHARACTER_BODY_BUILDS.SKINNY_MUSCULAR] = `CLOTHING_MP_BODY_TYPE_SKINNY_MUSCULAR`,
    [CHARACTER_BODY_BUILDS.SKINNY]          = `CLOTHING_MP_BODY_TYPE_SKINNY`,
    [CHARACTER_BODY_BUILDS.NEUTRAL]         = `CLOTHING_MP_BODY_TYPE_NEUTRAL`,
    [CHARACTER_BODY_BUILDS.HEAVY_MUSCULAR]  = `CLOTHING_MP_BODY_TYPE_HEAVY_MUSCULAR`,
    [CHARACTER_BODY_BUILDS.HEAVY]           = `CLOTHING_MP_BODY_TYPE_HEAVY`,
})

CHARACTER_BODY_BUILD:AddAttribute("Outfit", {
    [CHARACTER_BODY_BUILDS.SKINNY_MUSCULAR] = "MPCREATOR_SKINNY_MUSCULAR",
    [CHARACTER_BODY_BUILDS.SKINNY]          = "MPCREATOR_SKINNY",
    [CHARACTER_BODY_BUILDS.NEUTRAL]         = "MPCREATOR_NEUTRAL",
    [CHARACTER_BODY_BUILDS.HEAVY_MUSCULAR]  = "MPCREATOR_HEAVY_MUSCULAR",
    [CHARACTER_BODY_BUILDS.HEAVY]           = "MPCREATOR_HEAVY",
})
