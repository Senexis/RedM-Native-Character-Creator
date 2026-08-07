---@class UI_PAGE_IDS : EnumRegistry
---@field GetHash fun(self, id: number): integer|nil
---@field GetIdFromHash fun(self, hash: integer): number|nil
---@field GetCamera fun(self, id: number): table|nil
---@field GetIdFromCamera fun(self, camera: table): number|nil
---@field GetUi fun(self, id: number): table|nil
---@field GetIdFromUi fun(self, ui: table): number|nil
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field ToString fun(self, id: number): string
local UI_PAGE_IDS = {
    INVALID    = -1,
    MAIN       = 1,
    APPEARANCE = 2,
    EYES       = 3,
    NOSE       = 4,
    MOUTH      = 5,
    JAW        = 6,
    EARS       = 7,
    CHEEKS     = 8,
    HAIR       = 9,
    LIFESTYLE  = 10,
    MAKEUP     = 11,
    WHISTLE    = 12,
    ATTRIBUTES = 13,
    END        = 14,
}

---@type UI_PAGE_IDS | EnumRegistry
UI_PAGE_ID = Enums.CreateRegistry(UI_PAGE_IDS)

UI_PAGE_ID:AddAttribute("Hash", {
    [UI_PAGE_IDS.INVALID]    = 0,
    [UI_PAGE_IDS.MAIN]       = `MPCC_UI_FOCUS_ITEM_PAGE_MAIN_MENU`,
    [UI_PAGE_IDS.APPEARANCE] = `MPCC_UI_FOCUS_ITEM_PAGE_APPEARANCE_MAIN`,
    [UI_PAGE_IDS.EYES]       = `MPCC_UI_FOCUS_ITEM_PAGE_EYES_AND_BROWS`,
    [UI_PAGE_IDS.NOSE]       = `MPCC_UI_FOCUS_ITEM_PAGE_NOSE`,
    [UI_PAGE_IDS.MOUTH]      = `MPCC_UI_FOCUS_ITEM_PAGE_MOUTH_AND_LIPS`,
    [UI_PAGE_IDS.JAW]        = `MPCC_UI_FOCUS_ITEM_PAGE_JAW_AND_CHIN`,
    [UI_PAGE_IDS.EARS]       = `MPCC_UI_FOCUS_ITEM_PAGE_EARS`,
    [UI_PAGE_IDS.CHEEKS]     = `MPCC_UI_FOCUS_ITEM_PAGE_CHEEKS`,
    [UI_PAGE_IDS.HAIR]       = `MPCC_UI_FOCUS_ITEM_PAGE_HAIR`,
    [UI_PAGE_IDS.LIFESTYLE]  = `MPCC_UI_FOCUS_ITEM_PAGE_LIFESTYLE`,
    [UI_PAGE_IDS.MAKEUP]     = `MPCC_UI_FOCUS_ITEM_PAGE_MAKEUP`,
    [UI_PAGE_IDS.WHISTLE]    = `MPCC_UI_FOCUS_ITEM_PAGE_WHISTLE`,
    [UI_PAGE_IDS.ATTRIBUTES] = `MPCC_UI_FOCUS_ITEM_PAGE_ATTRIBUTES`,
    [UI_PAGE_IDS.END]        = 0,
})

UI_PAGE_ID:AddModeAttribute("Camera", {
    [CREATOR_MODE.DEFAULT] = {
        [UI_PAGE_IDS.MAIN]       = { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE },
        [UI_PAGE_IDS.APPEARANCE] = { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE },
        [UI_PAGE_IDS.EYES]       = { Default = EDITOR_VIEW.FACE, Zoomed = EDITOR_VIEW.FACE_CLOSE },
        [UI_PAGE_IDS.NOSE]       = { Default = EDITOR_VIEW.FACE, Zoomed = EDITOR_VIEW.FACE_CLOSE },
        [UI_PAGE_IDS.MOUTH]      = { Default = EDITOR_VIEW.FACE, Zoomed = EDITOR_VIEW.FACE_CLOSE },
        [UI_PAGE_IDS.JAW]        = { Default = EDITOR_VIEW.FACE, Zoomed = EDITOR_VIEW.FACE_CLOSE },
        [UI_PAGE_IDS.EARS]       = { Default = EDITOR_VIEW.FACE, Zoomed = EDITOR_VIEW.FACE_CLOSE },
        [UI_PAGE_IDS.CHEEKS]     = { Default = EDITOR_VIEW.FACE, Zoomed = EDITOR_VIEW.FACE_CLOSE },
        [UI_PAGE_IDS.HAIR]       = { Default = EDITOR_VIEW.FACE, Zoomed = EDITOR_VIEW.FACE_CLOSE },
        [UI_PAGE_IDS.LIFESTYLE]  = { Default = EDITOR_VIEW.FACE_CLOSE, Zoomed = EDITOR_VIEW.INVALID },
        [UI_PAGE_IDS.MAKEUP]     = { Default = EDITOR_VIEW.FACE, Zoomed = EDITOR_VIEW.FACE_CLOSE },
        [UI_PAGE_IDS.WHISTLE]    = { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE },
        [UI_PAGE_IDS.ATTRIBUTES] = { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE },
    },
    [CREATOR_MODE.ADVANCED] = {
        [UI_PAGE_IDS.MAIN]       = { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE },
        [UI_PAGE_IDS.APPEARANCE] = { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE },
        [UI_PAGE_IDS.EYES]       = { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE },
        [UI_PAGE_IDS.NOSE]       = { Default = EDITOR_VIEW.FACE, Zoomed = EDITOR_VIEW.FACE_CLOSE },
        [UI_PAGE_IDS.MOUTH]      = { Default = EDITOR_VIEW.FACE, Zoomed = EDITOR_VIEW.FACE_CLOSE },
        [UI_PAGE_IDS.JAW]        = { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE },
        [UI_PAGE_IDS.LIFESTYLE]  = { Default = EDITOR_VIEW.FACE_CLOSE, Zoomed = EDITOR_VIEW.INVALID },
        [UI_PAGE_IDS.WHISTLE]    = { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE },
        [UI_PAGE_IDS.ATTRIBUTES] = { Default = EDITOR_VIEW.FULL_BODY, Zoomed = EDITOR_VIEW.FULL_BODY_CLOSE },
    }
})

UI_PAGE_ID:AddModeAttribute("Ui", {
    [CREATOR_MODE.DEFAULT] = {
        [UI_PAGE_IDS.MAIN]       = { Header = 0x512BEE55, Subheader = 0x5DD86BB9 },
        [UI_PAGE_IDS.APPEARANCE] = { Header = 0x7895C056, Subheader = 0x5A5948D4 },
        [UI_PAGE_IDS.EYES]       = { Header = 0x674FF992, Subheader = nil }, -- Note: Subheader uses preset name
        [UI_PAGE_IDS.NOSE]       = { Header = 0xCCA25CD9, Subheader = nil }, -- Note: Subheader uses preset name
        [UI_PAGE_IDS.MOUTH]      = { Header = 0x4DC83AE7, Subheader = nil }, -- Note: Subheader uses preset name
        [UI_PAGE_IDS.JAW]        = { Header = 0xF9C30897, Subheader = nil }, -- Note: Subheader uses preset name
        [UI_PAGE_IDS.EARS]       = { Header = 0x52F72AB7, Subheader = nil }, -- Note: Subheader uses preset name
        [UI_PAGE_IDS.CHEEKS]     = { Header = 0xF9611AD5, Subheader = nil }, -- Note: Subheader uses preset name
        [UI_PAGE_IDS.HAIR]       = { Header = 0x444C8898, Subheader = 0x4886F3B1 },
        [UI_PAGE_IDS.LIFESTYLE]  = { Header = 0x35F8C892, Subheader = 0x0E0DCFDD },
        [UI_PAGE_IDS.MAKEUP]     = { Header = 0x4E7C6BB0, Subheader = 0xA6AB1C48 },
        [UI_PAGE_IDS.WHISTLE]    = { Header = 0xD32B3446, Subheader = 0x05E5242F },
        [UI_PAGE_IDS.ATTRIBUTES] = { Header = 0x8DDD412F, Subheader = 0x0B4062EA },
    },
    [CREATOR_MODE.ADVANCED] = {
        [UI_PAGE_IDS.MAIN]       = { Header = 0x512BEE55, Subheader = "NATIVE_CREATOR_ADVANCED_MENU_HEADING" },
        [UI_PAGE_IDS.APPEARANCE] = { Header = 0x7895C056, Subheader = "NATIVE_CREATOR_ADVANCED_OPTIONS_HEADING" },
        [UI_PAGE_IDS.EYES]       = { Header = "NATIVE_CREATOR_TORSO_HEADING", Subheader = nil },   -- Note: Subheader uses preset name
        [UI_PAGE_IDS.NOSE]       = { Header = "NATIVE_CREATOR_CORNERS_HEADING", Subheader = nil }, -- Note: Subheader uses preset name
        [UI_PAGE_IDS.MOUTH]      = { Header = "NATIVE_CREATOR_CRANIAL_HEADING", Subheader = nil }, -- Note: Subheader uses preset name
        [UI_PAGE_IDS.JAW]        = { Header = "NATIVE_CREATOR_LIMBS_HEADING", Subheader = nil },   -- Note: Subheader uses preset name
        [UI_PAGE_IDS.LIFESTYLE]  = { Header = 0x35F8C892, Subheader = "NATIVE_CREATOR_ADVANCED_OPTIONS_HEADING" },
        [UI_PAGE_IDS.WHISTLE]    = { Header = "NATIVE_CREATOR_VOICE_HEADING", Subheader = "NATIVE_CREATOR_ADVANCED_OPTIONS_HEADING" },
    }
})
