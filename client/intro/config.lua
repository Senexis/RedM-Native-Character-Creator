IntroConfig = {}

-- Whether to play the sheriff intro cutscene or start directly in gender selection
IntroConfig.UseCutscene = true

-- Whether to use the sheriff's spoken dialog during the intro
IntroConfig.UseDialog = true

-- Whether to skip specifically the character customization dialog
IntroConfig.UseCustomizeDialog = true

-- Whether to show the "Settings" prompt in the Character Creator
IntroConfig.EnableSettings = false

-- Whether to show the "Start Fresh" prompt (gender select and creator)
IntroConfig.EnableStartFresh = false

-- Whether to show the "Import" prompt on the gender select screen
IntroConfig.EnableImport = false

-- Whether to show the mugshot "Options" prompt (hold for Details / Extra Time / Title)
IntroConfig.EnableDetails = false

-- Whether to show the "Export" prompt (main menu Confirm item and mugshot)
IntroConfig.EnableExport = false

-- Which screen to open after gender select:
-- "main"     = Name / Create / Advanced / Confirm menu
-- "basic"    = basic character creator (skips the main menu; Name uses the same rename keyboard)
IntroConfig.StartMenu = "main"

-- Minimum and maximum cooldown time (in seconds) between idle fidget animations
IntroConfig.FidgetCooldownMin = 30
IntroConfig.FidgetCooldownMax = 60

-- Create outfits to randomly apply to the preset peds during the intro
IntroConfig.Outfits = {
    [EDITOR_CONFIG.MALE] = {
        { "CLOTHING_ITEM_M_UST_000_TINT_003",   "CLOTHING_ITEM_M_PANTS_000_TINT_001", "CLOTHING_ITEM_M_BOOTS_002_TINT_002", "CLOTHING_ITEM_M_SUSPENDERS_000_TINT_002", },
        { "CLOTHING_ITEM_M_PANTS_013_TINT_005", "CLOTHING_ITEM_M_SHIRT_006_TINT_001", "CLOTHING_ITEM_M_VEST_005_TINT_001",  "CLOTHING_ITEM_M_BOOTS_000_TINT_003",      "CLOTHING_ITEM_M_SUSPENDERS_000_TINT_002", },
        { "CLOTHING_ITEM_M_PANTS_002_TINT_005", "CLOTHING_ITEM_M_UST_000_TINT_005",   "CLOTHING_ITEM_M_VEST_003_TINT_002",  "CLOTHING_ITEM_M_BOOTS_002_TINT_006",      "CLOTHING_ITEM_M_SUSPENDERS_000_TINT_006", },
        { "CLOTHING_ITEM_M_VEST_004_TINT_005",  "CLOTHING_ITEM_M_PANTS_000_TINT_001", "CLOTHING_ITEM_M_SHIRT_004_TINT_003", "CLOTHING_ITEM_M_BOOTS_000_TINT_001",      "CLOTHING_ITEM_M_SPURS_001_TINT_002", },
        { "CLOTHING_ITEM_M_VEST_001_TINT_001",  "CLOTHING_ITEM_M_SHIRT_005_TINT_006", "CLOTHING_ITEM_M_PANTS_000_TINT_002", "CLOTHING_ITEM_M_BOOTS_000_TINT_005",      "CLOTHING_ITEM_M_SPURS_002_TINT_001", },
    },
    [EDITOR_CONFIG.FEMALE] = {
        { "CLOTHING_ITEM_F_CHEMISE_000_TINT_001", "CLOTHING_ITEM_F_PANTS_000_TINT_004", "CLOTHING_ITEM_F_BOOTS_002_TINT_001", "CLOTHING_ITEM_F_SUSPENDERS_000_TINT_006", },
        { "CLOTHING_ITEM_F_VEST_005_TINT_007",    "CLOTHING_ITEM_F_SHIRT_009_TINT_002", "CLOTHING_ITEM_F_PANTS_013_TINT_004", "CLOTHING_ITEM_F_BOOTS_000_TINT_002", },
        { "CLOTHING_ITEM_F_VEST_004_TINT_001",    "CLOTHING_ITEM_F_SKIRT_001_TINT_003", "CLOTHING_ITEM_F_SHIRT_001_TINT_004", "CLOTHING_ITEM_F_BOOTS_002_TINT_006", },
        { "CLOTHING_ITEM_F_VEST_003_TINT_001",    "CLOTHING_ITEM_F_SHIRT_001_TINT_005", "CLOTHING_ITEM_F_SKIRT_000_TINT_003", "CLOTHING_ITEM_F_BOOTS_001_TINT_001", },
        { "CLOTHING_ITEM_F_SHIRT_003_TINT_004",   "CLOTHING_ITEM_F_PANTS_004_TINT_003", "CLOTHING_ITEM_F_BOOTS_002_TINT_001", "CLOTHING_ITEM_F_SUSPENDERS_001_TINT_001", },
    }
}

-- Add timecycle modifiers to pick between in the Character Creator settings menu
IntroConfig.TimecycleModifiers = {
    { label = "Default",         value = "Online_Character_Editor" },
    { label = "Wardrobe",        value = "rho_fenceshop_int", },
    { label = "Cold Cave",       value = "Bea_Cave", },
    { label = "Bright Store",    value = "val_genstore_int", },
    { label = "Harsh",           value = "hea_tunnel_01", },
    { label = "Warm Interior",   value = "val_hotel_int", },
    { label = "Photo Studio",    value = "bla_photo_int", },
    { label = "Overcast Day",    value = "exposureCurveDebugMod", },
    { label = "Sunny Day",       value = "newDeadeyeBase", },
    { label = "Spotlight",       value = "dreams_coyote_final", },
    { label = "Cold Day",        value = "dreams_deer_strawberry_updated", },
    { label = "Sunset",          value = "guama2_sunPosExt_6", },
    { label = "Direct",          value = "Gang_1_mod", },
    { label = "Cold Interior",   value = "finale1_outroHighhon_bidging1", },
    { label = "Bright Interior", value = "TRAILER2_shot37", },
    { label = "Washed Out",      value = "DeathFailClarity", },
    { label = "Dark Gray",       value = "PedKill", },
    { label = "Noon",            value = "EagleEyeBase", },
    { label = "Scenic",          value = "int_extlight_none_dark", },
}
