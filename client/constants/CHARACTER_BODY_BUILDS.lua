---@class CHARACTER_BODY_BUILDS : EnumRegistry
---@field GetHash fun(self, id: number): integer|nil
---@field GetIdFromHash fun(self, hash: integer): number|nil
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field GetMoveNetSignal fun(self, id: number): number|nil
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

CHARACTER_BODY_BUILD:AddAttribute("MoveNetSignal", {
    [CHARACTER_BODY_BUILDS.SKINNY_MUSCULAR] = 1.0,
    [CHARACTER_BODY_BUILDS.SKINNY]          = 0.75,
    [CHARACTER_BODY_BUILDS.NEUTRAL]         = 0.5,
    [CHARACTER_BODY_BUILDS.HEAVY_MUSCULAR]  = 0.25,
    [CHARACTER_BODY_BUILDS.HEAVY]           = 0.0,
})
