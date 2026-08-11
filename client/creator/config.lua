CreatorConfig = {}

-- Whether to log debug information to the console
CreatorConfig.Debug = false

CreatorConfig.MaxNameLength = 50
CreatorConfig.MinAge = 18
CreatorConfig.MaxAge = 60
CreatorConfig.MinWeariness = 0.0
CreatorConfig.MaxWeariness = 0.5

CreatorConfig.SkipWhistle = false
CreatorConfig.SkipAttributePoints = false

CreatorConfig.Attributes = {
    Health  = { Default = 1, Min = 1, Max = 10 },
    Stamina = { Default = 1, Min = 1, Max = 10 },
    Deadeye = { Default = 1, Min = 1, Max = 10 }
}

-- The height corresponds to the key of the CreatorConfig.Heights table minus 1 (2 is the third entry)
CreatorConfig.DefaultHeight = 2

-- The weight corresponds to the key of the CreatorConfig.Weights table minus 1 (10 is the eleventh entry)
CreatorConfig.DefaultWeight = 10

-- Used for the digit parameter in the following:
-- CLOTHING_ITEM_M_HAIR_%03d_%s
-- BARBER_STYLE_M_HAIR_%03d_PAGE
CreatorConfig.MaleHairs = { "NONE", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 28, 300, 302 }

-- Used for the digit parameter in the following:
-- CLOTHING_ITEM_M_BEARD_%03d_%s
-- BARBER_STYLE_M_BEARD_%03d_PAGE
CreatorConfig.MaleBeards = { "NONE", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24 }

-- Used for the digit parameter in the following:
-- CLOTHING_ITEM_F_HAIR_%03d_%s
-- BARBER_STYLE_F_HAIR_%03d_PAGE
CreatorConfig.FemaleHairs = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 301, 302 }

-- Used for the digit parameter in the following:
-- CLOTHING_ITEM_M_TEETH_%03d
-- CLOTHING_ITEM_F_TEETH_%03d
CreatorConfig.Teeth = { 0, 1, 2, 3, 4, 5, 6 }

-- Used for the digit parameter in the following:
-- CLOTHING_ITEM_M_EYES_001_TINT_%03d
-- CLOTHING_ITEM_F_EYES_001_TINT_%03d
CreatorConfig.Eyes = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 }

-- Used for the digit parameter in display labels:
-- CHAR_CREATOR_WHISTLE_STYLE_%d
CreatorConfig.Whistles = { 1, 2, 3, 4, 5 }

-- Used for the string parameter in the following:
-- CLOTHING_ITEM_M_HAIR_%03d_%s
-- CLOTHING_ITEM_M_BEARD_%03d_%s
-- CLOTHING_ITEM_M_EYEBROWS_%03d_%s
-- CLOTHING_ITEM_F_HAIR_%03d_%s
-- CLOTHING_ITEM_F_EYEBROWS_%03d_%s
CreatorConfig.HairColors = {
    "BLONDE",
    "BROWN",
    "DARK_BLONDE",
    "DARK_GINGER",
    "DARK_GREY",
    "DARKEST_BROWN",
    "GINGER",
    "GREY",
    "JET_BLACK",
    "LIGHT_BLONDE",
    "LIGHT_BROWN",
    "LIGHT_GINGER",
    "LIGHT_GREY",
    "MEDIUM_BROWN",
    "SALT_PEPPER",
    "STRAWBERRY_BLONDE",
    "UNCLE_GREY",
}

-- The value is used for the ped's scale
CreatorConfig.Heights = {
    { id = "NATIVE_CREATOR_HEIGHT_01", label = "Petite",   value = 0.975 },
    { id = "NATIVE_CREATOR_HEIGHT_02", label = "Slender",  value = 0.987 },
    { id = "NATIVE_CREATOR_HEIGHT_03", label = "Standard", value = 1.0 },
    { id = "NATIVE_CREATOR_HEIGHT_04", label = "Elevated", value = 1.012 },
    { id = "NATIVE_CREATOR_HEIGHT_05", label = "Imposing", value = 1.025 },
}

-- The value is used for the outfit that is applied to the ped
CreatorConfig.Weights = {
    { id = "NATIVE_CREATOR_WEIGHT_01", label = "Underweight 10", value = 0x86155956 },
    { id = "NATIVE_CREATOR_WEIGHT_02", label = "Underweight 9",  value = 0x97F0FD0D },
    { id = "NATIVE_CREATOR_WEIGHT_03", label = "Underweight 8",  value = 0xEC92A64F },
    { id = "NATIVE_CREATOR_WEIGHT_04", label = "Underweight 7",  value = 0xC0794E49 },
    { id = "NATIVE_CREATOR_WEIGHT_05", label = "Underweight 6",  value = 0xCDA6E8A4 },
    { id = "NATIVE_CREATOR_WEIGHT_06", label = "Underweight 5",  value = 0xB418B588 },
    { id = "NATIVE_CREATOR_WEIGHT_07", label = "Underweight 4",  value = 0x3743BBB0 },
    { id = "NATIVE_CREATOR_WEIGHT_08", label = "Underweight 3",  value = 0x08EEDF07 },
    { id = "NATIVE_CREATOR_WEIGHT_09", label = "Underweight 2",  value = 0x17C87CBA },
    { id = "NATIVE_CREATOR_WEIGHT_10", label = "Underweight 1",  value = 0xD998005A },
    { id = "NATIVE_CREATOR_WEIGHT_11", label = "Standard",       value = 0x68109C55 },
    { id = "NATIVE_CREATOR_WEIGHT_12", label = "Overweight 1",   value = 0x3BDB43E7 },
    { id = "NATIVE_CREATOR_WEIGHT_13", label = "Overweight 2",   value = 0x4C35E49C },
    { id = "NATIVE_CREATOR_WEIGHT_14", label = "Overweight 3",   value = 0x1DF38818 },
    { id = "NATIVE_CREATOR_WEIGHT_15", label = "Overweight 4",   value = 0x833C52B8 },
    { id = "NATIVE_CREATOR_WEIGHT_16", label = "Overweight 5",   value = 0x927AF135 },
    { id = "NATIVE_CREATOR_WEIGHT_17", label = "Overweight 6",   value = 0x677F9B3F },
    { id = "NATIVE_CREATOR_WEIGHT_18", label = "Overweight 7",   value = 0x79A13F82 },
    { id = "NATIVE_CREATOR_WEIGHT_19", label = "Overweight 8",   value = 0xBA0BC056 },
    { id = "NATIVE_CREATOR_WEIGHT_20", label = "Overweight 9",   value = 0xCC4664CB },
    { id = "NATIVE_CREATOR_WEIGHT_21", label = "Overweight 10",  value = 0x74D74B1C },
}

CreatorConfig.Voices = {
    { id = "NATIVE_CREATOR_VOICE_01", label = "Style 1", value = 1 },
    { id = "NATIVE_CREATOR_VOICE_02", label = "Style 2", value = 2 },
    { id = "NATIVE_CREATOR_VOICE_03", label = "Style 3", value = 3 },
}

-- To reduce visual clutter, this is the percentage chance any overlay layer gets skipped
-- during randomization. It is only applicable to layers that support randomization, not presets
CreatorConfig.RandomizePercentToSkipOverlay = 30

-- To reduce visual clutter, this is the percentage chance the makeup preset application gets skipped
CreatorConfig.RandomizePercentToSkipMakeup = 30

-- Used to prevent odd-looking randomized characters, feel free to add or remove presets
-- Uses blend names from CharacterBlends (see client/character/blends.lua) and alphas.
-- For overlays that support tints (EYESHADOW, LIPSTICK), both blend and tint must be blend names.
-- You may choose to filter any preset by gender using the "gender" key ("M" or "F").
-- Additionally, currently only supports the following layers: FOUNDATION, BLUSHER, EYELINER, EYESHADOW, LIPSTICK
CreatorConfig.MakeupPresets = {
    {
        gender = "F",
        [OVERLAY_LAYER.EYESHADOW] = { blend = "BLEND_EYESHADOW_01_TINT_01", tint = "BLEND_EYESHADOW_01_TINT_04", alpha = 0.3 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.EYESHADOW] = { blend = "BLEND_EYESHADOW_01_TINT_01", tint = "BLEND_EYESHADOW_01_TINT_02", alpha = 0.59 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.BLUSHER]   = { blend = "BLEND_BLUSHER_01", alpha = 0.686 },
        [OVERLAY_LAYER.EYESHADOW] = { blend = "BLEND_EYESHADOW_01_TINT_01", tint = "BLEND_EYESHADOW_01_TINT_01", alpha = 0.35 },
        [OVERLAY_LAYER.LIPSTICK]  = { blend = "BLEND_LIPSTICK_01_TINT_01", tint = "BLEND_LIPSTICK_01_TINT_02", alpha = 0.57 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.EYESHADOW] = { blend = "BLEND_EYESHADOW_01_TINT_01", tint = "BLEND_EYESHADOW_01_TINT_01", alpha = 0.095 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.FOUNDATION] = { blend = "BLEND_FOUNDATION_01", alpha = 0.372 },
        [OVERLAY_LAYER.EYESHADOW]  = { blend = "BLEND_EYESHADOW_01_TINT_01", tint = "BLEND_EYESHADOW_01_TINT_01", alpha = 0.45 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.FOUNDATION] = { blend = "BLEND_FOUNDATION_01", alpha = 0.658 },
        [OVERLAY_LAYER.BLUSHER]    = { blend = "BLEND_BLUSHER_03", alpha = 0.294 },
        [OVERLAY_LAYER.EYESHADOW]  = { blend = "BLEND_EYESHADOW_02_TINT_01", tint = "BLEND_EYESHADOW_02_TINT_02", alpha = 0.786 },
        [OVERLAY_LAYER.EYELINER]   = { blend = "BLEND_EYELINER_01", alpha = 0.667 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.EYELINER] = { blend = "BLEND_EYELINER_01", alpha = 0.3 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.EYESHADOW] = { blend = "BLEND_EYESHADOW_01_TINT_01", tint = "BLEND_EYESHADOW_01_TINT_02", alpha = 0.35 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.BLUSHER]   = { blend = "BLEND_BLUSHER_01", alpha = 0.55 },
        [OVERLAY_LAYER.EYESHADOW] = { blend = "BLEND_EYESHADOW_01_TINT_01", tint = "BLEND_EYESHADOW_01_TINT_01", alpha = 0.227 },
        [OVERLAY_LAYER.EYELINER]  = { blend = "BLEND_EYELINER_01", alpha = 0.6 },
        [OVERLAY_LAYER.LIPSTICK]  = { blend = "BLEND_LIPSTICK_01_TINT_01", tint = "BLEND_LIPSTICK_01_TINT_02", alpha = 0.6 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.BLUSHER]   = { blend = "BLEND_BLUSHER_01", alpha = 1.0 },
        [OVERLAY_LAYER.EYESHADOW] = { blend = "BLEND_EYESHADOW_01_TINT_01", tint = "BLEND_EYESHADOW_01_TINT_01", alpha = 0.1 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.FOUNDATION] = { blend = "BLEND_FOUNDATION_01", alpha = 0.516 },
        [OVERLAY_LAYER.BLUSHER]    = { blend = "BLEND_BLUSHER_01", alpha = 0.925 },
        [OVERLAY_LAYER.EYESHADOW]  = { blend = "BLEND_EYESHADOW_01_TINT_01", tint = "BLEND_EYESHADOW_01_TINT_01", alpha = 0.35 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.FOUNDATION] = { blend = "BLEND_FOUNDATION_01", alpha = 0.25 },
        [OVERLAY_LAYER.BLUSHER]    = { blend = "BLEND_BLUSHER_02", alpha = 0.55 },
        [OVERLAY_LAYER.EYESHADOW]  = { blend = "BLEND_EYESHADOW_01_TINT_01", tint = "BLEND_EYESHADOW_01_TINT_01", alpha = 0.5 },
        [OVERLAY_LAYER.EYELINER]   = { blend = "BLEND_EYELINER_01", alpha = 0.66 },
    },
    {
        gender = "F",
        [OVERLAY_LAYER.BLUSHER] = { blend = "BLEND_BLUSHER_02", alpha = 0.312 },
    },
}

--- =========================================
--- ==         BODY BUILD CONFIG           ==
--- =========================================

-- You may add or remove body builds here.
-- The ID field is used for the stepper labels in the character creator UI.
-- Note that the "build" value must match the corresponding value in CHARACTER_BODY_BUILDS.
-- The "expressions" table contains the expression values for each body build, which are applied to the ped when the body build is selected.
-- The expression keys are based on the PED_EXPRESSION enum, which can be found in PED_EXPRESSIONS.
-- Note that the expression values are floats between -1.0 and 1.0 and will be translated to UI values between 0.0 and 1.0 later.

CreatorConfig.MaleBodyBuilds = {
    {
        id = "MPBODY_BUILD_MALE_1",
        build = CHARACTER_BODY_BUILD.SKINNY,
        expressions = {
            [PED_EXPRESSION.NECK_WIDTH]       = -0.9,
            [PED_EXPRESSION.NECK_DEPTH]       = -0.9,
            [PED_EXPRESSION.SHOULDERS_HEIGHT] = 0.3,
            [PED_EXPRESSION.SHOULDERS_DEPTH]  = -0.8,
            [PED_EXPRESSION.SHOULDERS_WIDTH]  = -0.7,
            [PED_EXPRESSION.TRAPS]            = -0.7,
            [PED_EXPRESSION.LATS]             = -0.8,
            [PED_EXPRESSION.CHEST_WIDTH]      = -0.8,
            [PED_EXPRESSION.CHEST_DEPTH]      = -0.7,
            [PED_EXPRESSION.CHEST_SAG]     = 0.0,
            [PED_EXPRESSION.BELLY_WIDTH]      = -0.8,
            [PED_EXPRESSION.BELLY_DEPTH]      = -0.8,
            [PED_EXPRESSION.GLUTES]           = 0.0,
            [PED_EXPRESSION.UPPER_ARMS]       = -0.7,
            [PED_EXPRESSION.FOREARMS]         = -0.7,
            [PED_EXPRESSION.UPPER_LEGS]       = -0.8,
            [PED_EXPRESSION.LOWER_LEGS]       = -0.8,
        }
    },
    {
        id = "MPBODY_BUILD_MALE_2",
        build = CHARACTER_BODY_BUILD.SKINNY_MUSCULAR,
        expressions = {
            [PED_EXPRESSION.NECK_WIDTH]       = -0.2,
            [PED_EXPRESSION.NECK_DEPTH]       = -0.4,
            [PED_EXPRESSION.SHOULDERS_HEIGHT] = 0.6,
            [PED_EXPRESSION.SHOULDERS_DEPTH]  = 0.3,
            [PED_EXPRESSION.SHOULDERS_WIDTH]  = -0.1,
            [PED_EXPRESSION.TRAPS]            = 0.7,
            [PED_EXPRESSION.LATS]             = 0.3,
            [PED_EXPRESSION.CHEST_WIDTH]      = -0.8,
            [PED_EXPRESSION.CHEST_DEPTH]      = -0.7,
            [PED_EXPRESSION.CHEST_SAG]     = 0.0,
            [PED_EXPRESSION.BELLY_WIDTH]      = -0.8,
            [PED_EXPRESSION.BELLY_DEPTH]      = -0.8,
            [PED_EXPRESSION.GLUTES]           = 0.0,
            [PED_EXPRESSION.UPPER_ARMS]       = -0.4,
            [PED_EXPRESSION.FOREARMS]         = -0.7,
            [PED_EXPRESSION.UPPER_LEGS]       = -0.3,
            [PED_EXPRESSION.LOWER_LEGS]       = -0.8,
        }
    },
    {
        id = "MPBODY_BUILD_MALE_3",
        build = CHARACTER_BODY_BUILD.NEUTRAL,
        expressions = {
            [PED_EXPRESSION.NECK_WIDTH]       = 0.0,
            [PED_EXPRESSION.NECK_DEPTH]       = 0.0,
            [PED_EXPRESSION.SHOULDERS_HEIGHT] = 0.0,
            [PED_EXPRESSION.SHOULDERS_DEPTH]  = 0.0,
            [PED_EXPRESSION.SHOULDERS_WIDTH]  = 0.0,
            [PED_EXPRESSION.TRAPS]            = 0.0,
            [PED_EXPRESSION.LATS]             = 0.0,
            [PED_EXPRESSION.CHEST_WIDTH]      = 0.0,
            [PED_EXPRESSION.CHEST_DEPTH]      = 0.0,
            [PED_EXPRESSION.CHEST_SAG]     = 0.0,
            [PED_EXPRESSION.BELLY_WIDTH]      = 0.0,
            [PED_EXPRESSION.BELLY_DEPTH]      = 0.0,
            [PED_EXPRESSION.GLUTES]           = 0.0,
            [PED_EXPRESSION.UPPER_ARMS]       = 0.0,
            [PED_EXPRESSION.FOREARMS]         = 0.0,
            [PED_EXPRESSION.UPPER_LEGS]       = 0.0,
            [PED_EXPRESSION.LOWER_LEGS]       = 0.0,
        }
    },
    {
        id = "MPBODY_BUILD_MALE_4",
        build = CHARACTER_BODY_BUILD.HEAVY,
        expressions = {
            [PED_EXPRESSION.NECK_WIDTH]       = 0.8,
            [PED_EXPRESSION.NECK_DEPTH]       = 0.8,
            [PED_EXPRESSION.SHOULDERS_HEIGHT] = -0.7,
            [PED_EXPRESSION.SHOULDERS_DEPTH]  = 0.6,
            [PED_EXPRESSION.SHOULDERS_WIDTH]  = 0.4,
            [PED_EXPRESSION.TRAPS]            = 0.8,
            [PED_EXPRESSION.LATS]             = 0.7,
            [PED_EXPRESSION.CHEST_WIDTH]      = -0.8,
            [PED_EXPRESSION.CHEST_DEPTH]      = 0.6,
            [PED_EXPRESSION.CHEST_SAG]     = 0.0,
            [PED_EXPRESSION.BELLY_WIDTH]      = 0.7,
            [PED_EXPRESSION.BELLY_DEPTH]      = 0.8,
            [PED_EXPRESSION.GLUTES]           = 0.0,
            [PED_EXPRESSION.UPPER_ARMS]       = 0.8,
            [PED_EXPRESSION.FOREARMS]         = 0.7,
            [PED_EXPRESSION.UPPER_LEGS]       = 0.8,
            [PED_EXPRESSION.LOWER_LEGS]       = -0.3,
        }
    },
    {
        id = "MPBODY_BUILD_MALE_5",
        build = CHARACTER_BODY_BUILD.HEAVY_MUSCULAR,
        expressions = {
            [PED_EXPRESSION.NECK_WIDTH]       = 0.9,
            [PED_EXPRESSION.NECK_DEPTH]       = 0.5,
            [PED_EXPRESSION.SHOULDERS_HEIGHT] = 0.8,
            [PED_EXPRESSION.SHOULDERS_DEPTH]  = 0.8,
            [PED_EXPRESSION.SHOULDERS_WIDTH]  = 0.6,
            [PED_EXPRESSION.TRAPS]            = 1.0,
            [PED_EXPRESSION.LATS]             = 0.8,
            [PED_EXPRESSION.CHEST_WIDTH]      = 0.8,
            [PED_EXPRESSION.CHEST_DEPTH]      = 0.8,
            [PED_EXPRESSION.CHEST_SAG]     = 0.0,
            [PED_EXPRESSION.BELLY_WIDTH]      = 0.7,
            [PED_EXPRESSION.BELLY_DEPTH]      = 0.8,
            [PED_EXPRESSION.GLUTES]           = 0.0,
            [PED_EXPRESSION.UPPER_ARMS]       = 0.8,
            [PED_EXPRESSION.FOREARMS]         = 0.7,
            [PED_EXPRESSION.UPPER_LEGS]       = 0.6,
            [PED_EXPRESSION.LOWER_LEGS]       = -0.7,
        }
    },
}

CreatorConfig.FemaleBodyBuilds = {
    {
        id = "MPBODY_BUILD_FEMALE_1",
        build = CHARACTER_BODY_BUILD.SKINNY,
        expressions = {
            [PED_EXPRESSION.NECK_WIDTH]       = -0.7,
            [PED_EXPRESSION.NECK_DEPTH]       = -0.7,
            [PED_EXPRESSION.SHOULDERS_HEIGHT] = -0.8,
            [PED_EXPRESSION.SHOULDERS_DEPTH]  = -0.8,
            [PED_EXPRESSION.SHOULDERS_WIDTH]  = -0.5,
            [PED_EXPRESSION.TRAPS]            = -0.7,
            [PED_EXPRESSION.LATS]             = -0.8,
            [PED_EXPRESSION.CHEST_WIDTH]      = -0.7,
            [PED_EXPRESSION.CHEST_DEPTH]      = -0.6,
            [PED_EXPRESSION.CHEST_SAG]     = 0.7,
            [PED_EXPRESSION.BELLY_WIDTH]      = -0.7,
            [PED_EXPRESSION.BELLY_DEPTH]      = -0.7,
            [PED_EXPRESSION.GLUTES]           = -0.7,
            [PED_EXPRESSION.UPPER_ARMS]       = -0.7,
            [PED_EXPRESSION.FOREARMS]         = -0.7,
            [PED_EXPRESSION.UPPER_LEGS]       = -0.8,
            [PED_EXPRESSION.LOWER_LEGS]       = -0.9,
        }
    },
    {
        id = "MPBODY_BUILD_FEMALE_2",
        build = CHARACTER_BODY_BUILD.SKINNY_MUSCULAR,
        expressions = {
            [PED_EXPRESSION.NECK_WIDTH]       = 0.3,
            [PED_EXPRESSION.NECK_DEPTH]       = 0.3,
            [PED_EXPRESSION.SHOULDERS_HEIGHT] = 0.5,
            [PED_EXPRESSION.SHOULDERS_DEPTH]  = -0.5,
            [PED_EXPRESSION.SHOULDERS_WIDTH]  = 0.4,
            [PED_EXPRESSION.TRAPS]            = 0.8,
            [PED_EXPRESSION.LATS]             = 0.5,
            [PED_EXPRESSION.CHEST_WIDTH]      = -0.3,
            [PED_EXPRESSION.CHEST_DEPTH]      = -0.6,
            [PED_EXPRESSION.CHEST_SAG]     = 0.8,
            [PED_EXPRESSION.BELLY_WIDTH]      = -0.7,
            [PED_EXPRESSION.BELLY_DEPTH]      = -0.7,
            [PED_EXPRESSION.GLUTES]           = -0.5,
            [PED_EXPRESSION.UPPER_ARMS]       = -0.2,
            [PED_EXPRESSION.FOREARMS]         = -0.4,
            [PED_EXPRESSION.UPPER_LEGS]       = -0.2,
            [PED_EXPRESSION.LOWER_LEGS]       = -0.9,
        }
    },
    {
        id = "MPBODY_BUILD_FEMALE_3",
        build = CHARACTER_BODY_BUILD.NEUTRAL,
        expressions = {
            [PED_EXPRESSION.NECK_WIDTH]       = 0.0,
            [PED_EXPRESSION.NECK_DEPTH]       = 0.0,
            [PED_EXPRESSION.SHOULDERS_HEIGHT] = 0.0,
            [PED_EXPRESSION.SHOULDERS_DEPTH]  = 0.0,
            [PED_EXPRESSION.SHOULDERS_WIDTH]  = 0.0,
            [PED_EXPRESSION.TRAPS]            = 0.0,
            [PED_EXPRESSION.LATS]             = 0.0,
            [PED_EXPRESSION.CHEST_WIDTH]      = 0.0,
            [PED_EXPRESSION.CHEST_DEPTH]      = 0.0,
            [PED_EXPRESSION.CHEST_SAG]     = 0.0,
            [PED_EXPRESSION.BELLY_WIDTH]      = 0.0,
            [PED_EXPRESSION.BELLY_DEPTH]      = 0.0,
            [PED_EXPRESSION.GLUTES]           = 0.0,
            [PED_EXPRESSION.UPPER_ARMS]       = 0.0,
            [PED_EXPRESSION.FOREARMS]         = 0.0,
            [PED_EXPRESSION.UPPER_LEGS]       = 0.0,
            [PED_EXPRESSION.LOWER_LEGS]       = 0.0,
        }
    },
    {
        id = "MPBODY_BUILD_FEMALE_4",
        build = CHARACTER_BODY_BUILD.HEAVY,
        expressions = {
            [PED_EXPRESSION.NECK_WIDTH]       = 0.7,
            [PED_EXPRESSION.NECK_DEPTH]       = 0.7,
            [PED_EXPRESSION.SHOULDERS_HEIGHT] = -0.5,
            [PED_EXPRESSION.SHOULDERS_DEPTH]  = 0.6,
            [PED_EXPRESSION.SHOULDERS_WIDTH]  = -0.5,
            [PED_EXPRESSION.TRAPS]            = 0.5,
            [PED_EXPRESSION.LATS]             = 0.7,
            [PED_EXPRESSION.CHEST_WIDTH]      = 0.6,
            [PED_EXPRESSION.CHEST_DEPTH]      = 0.8,
            [PED_EXPRESSION.CHEST_SAG]     = -0.7,
            [PED_EXPRESSION.BELLY_WIDTH]      = 0.7,
            [PED_EXPRESSION.BELLY_DEPTH]      = 0.7,
            [PED_EXPRESSION.GLUTES]           = 0.8,
            [PED_EXPRESSION.UPPER_ARMS]       = 0.7,
            [PED_EXPRESSION.FOREARMS]         = 0.6,
            [PED_EXPRESSION.UPPER_LEGS]       = 0.8,
            [PED_EXPRESSION.LOWER_LEGS]       = 0.8,
        }
    },
    {
        id = "MPBODY_BUILD_FEMALE_5",
        build = CHARACTER_BODY_BUILD.HEAVY_MUSCULAR,
        expressions = {
            [PED_EXPRESSION.NECK_WIDTH]       = 0.8,
            [PED_EXPRESSION.NECK_DEPTH]       = 0.7,
            [PED_EXPRESSION.SHOULDERS_HEIGHT] = 0.8,
            [PED_EXPRESSION.SHOULDERS_DEPTH]  = 0.8,
            [PED_EXPRESSION.SHOULDERS_WIDTH]  = 0.9,
            [PED_EXPRESSION.TRAPS]            = 0.9,
            [PED_EXPRESSION.LATS]             = 0.9,
            [PED_EXPRESSION.CHEST_WIDTH]      = 0.8,
            [PED_EXPRESSION.CHEST_DEPTH]      = 0.8,
            [PED_EXPRESSION.CHEST_SAG]     = 0.8,
            [PED_EXPRESSION.BELLY_WIDTH]      = 0.7,
            [PED_EXPRESSION.BELLY_DEPTH]      = 0.7,
            [PED_EXPRESSION.GLUTES]           = 0.6,
            [PED_EXPRESSION.UPPER_ARMS]       = 0.8,
            [PED_EXPRESSION.FOREARMS]         = 0.8,
            [PED_EXPRESSION.UPPER_LEGS]       = 0.8,
            [PED_EXPRESSION.LOWER_LEGS]       = 0.8,
        }
    },
}

--- =========================================
--- ==         CUSTOM HAIR CONFIG          ==
--- =========================================

-- The following are custom hair options not available in the base game.
-- Label and drawables are required, other keys are optional.
-- Optional keys: albedo, normal, material, palette

CreatorConfig.CustomMaleHairs = {
    { id = "NATIVE_CREATOR_M_HAIR_001", label = "Combed Back",              drawable = "hair_mr1_010" },
    { id = "NATIVE_CREATOR_M_HAIR_002", label = "Tapered Low Pompadour",    drawable = "hair_mr1_011" },
    { id = "NATIVE_CREATOR_M_HAIR_003", label = "Neat Shag",                drawable = "hair_mr1_012" },
    { id = "NATIVE_CREATOR_M_HAIR_004", label = "High Slick Back",          drawable = "hair_mr1_015" },
    { id = "NATIVE_CREATOR_M_HAIR_005", label = "Slicked Back",             drawable = "hair_mr1_016" },
    { id = "NATIVE_CREATOR_M_HAIR_006", label = "Thinning Layers",          drawable = "hair_mr1_017" },
    { id = "NATIVE_CREATOR_M_HAIR_007", label = "Slicked Shoulder Waves",   drawable = "hair_mr1_018" },
    { id = "NATIVE_CREATOR_M_HAIR_008", label = "Simple Balding",           drawable = "hair_mr1_019" },
    { id = "NATIVE_CREATOR_M_HAIR_009", label = "Neat Combover",            drawable = "hair_mr1_020" },
    { id = "NATIVE_CREATOR_M_HAIR_010", label = "Shoulder Waves",           drawable = "hair_mr1_023" },
    { id = "NATIVE_CREATOR_M_HAIR_011", label = "Small Ponytail",           drawable = "hair_mr1_024" },
    { id = "NATIVE_CREATOR_M_HAIR_012", label = "Combed Fade",              drawable = "hair_mr1_025" },
    { id = "NATIVE_CREATOR_M_HAIR_013", label = "Peaked",                   drawable = "hair_mr1_026" },
    { id = "NATIVE_CREATOR_M_HAIR_014", label = "Fancy High Fade",          drawable = "hair_mr1_027" },
    { id = "NATIVE_CREATOR_M_HAIR_015", label = "Tall Pompadour",           drawable = "hair_mr1_028" },
    { id = "NATIVE_CREATOR_M_HAIR_016", label = "Dramatic Layers",          drawable = "hair_mr1_029" },
    { id = "NATIVE_CREATOR_M_HAIR_017", label = "Messy Shag",               drawable = "hair_mr1_030" },
    { id = "NATIVE_CREATOR_M_HAIR_018", label = "Tousled Shag",             drawable = "hair_mr1_030_dishevel" },
    { id = "NATIVE_CREATOR_M_HAIR_019", label = "Wild Shag",                drawable = "hair_mr1_031" },
    { id = "NATIVE_CREATOR_M_HAIR_020", label = "Mop Top",                  drawable = "hair_mr1_032" },
    { id = "NATIVE_CREATOR_M_HAIR_021", label = "Shoulder Curtains",        drawable = "hair_mr1_033" },
    { id = "NATIVE_CREATOR_M_HAIR_022", label = "Brushed Back",             drawable = "hair_mr1_034" },
    { id = "NATIVE_CREATOR_M_HAIR_023", label = "Tidy Balding",             drawable = "hair_mr1_035" },
    { id = "NATIVE_CREATOR_M_HAIR_024", label = "Messy Layers",             drawable = "hair_mr1_037" },
    { id = "NATIVE_CREATOR_M_HAIR_025", label = "Scruffy Balding",          drawable = "hair_mr1_038" },
    { id = "NATIVE_CREATOR_M_HAIR_026", label = "Framed Curtains",          drawable = "hair_mr1_039" },
    { id = "NATIVE_CREATOR_M_HAIR_027", label = "Side-shaved Braid",        drawable = "hair_mr1_040" },
    { id = "NATIVE_CREATOR_M_HAIR_028", label = "Shoulder Mop",             drawable = "hair_mr1_041" },
    { id = "NATIVE_CREATOR_M_HAIR_029", label = "Combed Pompadour",         drawable = "hair_mr1_042" },
    { id = "NATIVE_CREATOR_M_HAIR_030", label = "Windswept Wild",           drawable = "hair_mr1_043" },
    { id = "NATIVE_CREATOR_M_HAIR_031", label = "Short Brush Back",         drawable = "hair_mr1_044" },
    { id = "NATIVE_CREATOR_M_HAIR_032", label = "Wavy Pompadour",           drawable = "hair_mr1_044_bigguy" },
    { id = "NATIVE_CREATOR_M_HAIR_033", label = "Wiffle Cut",               drawable = "hair_mr1_045" },
    { id = "NATIVE_CREATOR_M_HAIR_034", label = "Tight Combed",             drawable = "hair_mr1_046" },
    { id = "NATIVE_CREATOR_M_HAIR_035", label = "Slicked Undercut",         drawable = "hair_mr1_047" },
    { id = "NATIVE_CREATOR_M_HAIR_036", label = "Short Cut Balding",        drawable = "hair_mr1_048" },
    { id = "NATIVE_CREATOR_M_HAIR_037", label = "Carefree Dreads",          drawable = "hair_mr1_054" },
    { id = "NATIVE_CREATOR_M_HAIR_038", label = "Unkempt Balding",          drawable = "hair_mr1_055" },
    { id = "NATIVE_CREATOR_M_HAIR_039", label = "Swept Back",               drawable = "hair_mr1_056" },
    { id = "NATIVE_CREATOR_M_HAIR_040", label = "Center Parted Brush Back", drawable = "hair_mr1_057" },
    { id = "NATIVE_CREATOR_M_HAIR_041", label = "Scruffy Combover",         drawable = "hair_mr1_058" },
    { id = "NATIVE_CREATOR_M_HAIR_042", label = "Classic Pompadour",        drawable = "hair_mr1_059" },
    { id = "NATIVE_CREATOR_M_HAIR_043", label = "Curly Mop Top",            drawable = "hair_mr1_060" },
    { id = "NATIVE_CREATOR_M_HAIR_044", label = "Low Curled",               drawable = "hair_mr1_061" },
    { id = "NATIVE_CREATOR_M_HAIR_045", label = "Front Balding",            drawable = "hair_mr1_062" },
    { id = "NATIVE_CREATOR_M_HAIR_046", label = "Thinning Combover",        drawable = "hair_mr1_064" },
    { id = "NATIVE_CREATOR_M_HAIR_047", label = "Arched Waves",             drawable = "hair_mr1_065" },
    { id = "NATIVE_CREATOR_M_HAIR_048", label = "Short Waves",              drawable = "hair_mr1_066" },
    { id = "NATIVE_CREATOR_M_HAIR_049", label = "Windswept Balding",        drawable = "hair_mr1_068" },
    { id = "NATIVE_CREATOR_M_HAIR_050", label = "Short Curls",              drawable = "hair_mr1_069" },
    { id = "NATIVE_CREATOR_M_HAIR_051", label = "Center Curtains",          drawable = "hair_mr1_070" },
    { id = "NATIVE_CREATOR_M_HAIR_052", label = "Side Part",                drawable = "hair_mr1_071" },
    { id = "NATIVE_CREATOR_M_HAIR_053", label = "Balding Comb Over",        drawable = "hair_mr1_072" },
    { id = "NATIVE_CREATOR_M_HAIR_054", label = "Windswept Layers",         drawable = "hair_mr1_073" },
    { id = "NATIVE_CREATOR_M_HAIR_055", label = "Center Curtain Cut",       drawable = "hair_mr1_074" },
    { id = "NATIVE_CREATOR_M_HAIR_056", label = "Front Plait",              drawable = "hair_mr1_075_alt01" },
    { id = "NATIVE_CREATOR_M_HAIR_057", label = "Shoulder Neat Waves",      drawable = "hair_mr1_077" },
    { id = "NATIVE_CREATOR_M_HAIR_058", label = "Long Waves",               drawable = "hair_mr1_078" },
    { id = "NATIVE_CREATOR_M_HAIR_059", label = "Thin Long Waves",          drawable = "hair_mr1_078_alt01" },
    { id = "NATIVE_CREATOR_M_HAIR_060", label = "Long Combed",              drawable = "hair_mr1_079" },
    { id = "NATIVE_CREATOR_M_HAIR_061", label = "Slicked Receding",         drawable = "hair_mr1_080" },
    { id = "NATIVE_CREATOR_M_HAIR_062", label = "Bowl Cut",                 drawable = "hair_mr1_081" },
    { id = "NATIVE_CREATOR_M_HAIR_063", label = "French Crop",              drawable = "hair_mr1_082" },
    { id = "NATIVE_CREATOR_M_HAIR_064", label = "Messy Swept Back",         drawable = "hair_mr1_083" },
    { id = "NATIVE_CREATOR_M_HAIR_065", label = "Close Fade",               drawable = "hair_mr1_084" },
    { id = "NATIVE_CREATOR_M_HAIR_066", label = "Receding",                 drawable = "hair_mr1_085" },
    { id = "NATIVE_CREATOR_M_HAIR_067", label = "Combed Layers",            drawable = "hair_mr1_086" },
    { id = "NATIVE_CREATOR_M_HAIR_068", label = "Neat Swept Back",          drawable = "hair_mr1_091" },
    { id = "NATIVE_CREATOR_M_HAIR_069", label = "Tied Swept Back",          drawable = "hair_mr1_092" },
    { id = "NATIVE_CREATOR_M_HAIR_070", label = "Long Swept Waves",         drawable = "hair_mr1_093" },
}

CreatorConfig.CustomFemaleHairs = {
    { id = "NATIVE_CREATOR_F_HAIR_001", label = "Rear Crown Braid",       drawable = "hair_fr1_024" },
    { id = "NATIVE_CREATOR_F_HAIR_002", label = "Loose Swept Waves",      drawable = "hair_fr1_026" },
    { id = "NATIVE_CREATOR_F_HAIR_003", label = "Gibson Updo",            drawable = "hair_fr1_027" },
    { id = "NATIVE_CREATOR_F_HAIR_004", label = "Balding Bouffant",       drawable = "hair_fr1_027_balding" },
    { id = "NATIVE_CREATOR_F_HAIR_005", label = "Loose Pompadour",        drawable = "hair_fr1_027_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_006", label = "Loose Ringlets",         drawable = "hair_fr1_028" },
    { id = "NATIVE_CREATOR_F_HAIR_007", label = "Carefree Side Plait",    drawable = "hair_fr1_029_alt01" },
    { id = "NATIVE_CREATOR_F_HAIR_008", label = "Ruined Side Plait",      drawable = "hair_fr1_029_balding" },
    { id = "NATIVE_CREATOR_F_HAIR_009", label = "Framed Pigtails",        drawable = "hair_fr1_031" },
    { id = "NATIVE_CREATOR_F_HAIR_010", label = "Back Pigtails",          drawable = "hair_fr1_032_alt01" },
    { id = "NATIVE_CREATOR_F_HAIR_011", label = "Neat Corkscrew Curls",   drawable = "hair_fr1_033_alt03" },
    { id = "NATIVE_CREATOR_F_HAIR_012", label = "Corkscrew Curl Updo",    drawable = "hair_fr1_033_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_013", label = "Tidy Pompadour",         drawable = "hair_fr1_035" },
    { id = "NATIVE_CREATOR_F_HAIR_014", label = "Ruined Pompadour",       drawable = "hair_fr1_035_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_015", label = "Tall Pompadour",         drawable = "hair_fr1_036" },
    { id = "NATIVE_CREATOR_F_HAIR_016", label = "Curled High Chignon",    drawable = "hair_fr1_037" },
    { id = "NATIVE_CREATOR_F_HAIR_017", label = "Carefree High Chignon",  drawable = "hair_fr1_037_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_018", label = "Low Pompadour",          drawable = "hair_fr1_041" },
    { id = "NATIVE_CREATOR_F_HAIR_019", label = "Unkempt Pigtails",       drawable = "hair_fr1_042_alt02" },
    { id = "NATIVE_CREATOR_F_HAIR_020", label = "Messy Pigtails",         drawable = "hair_fr1_042_balding" },
    { id = "NATIVE_CREATOR_F_HAIR_021", label = "Carefree Short Waves",   drawable = "hair_fr1_043" },
    { id = "NATIVE_CREATOR_F_HAIR_022", label = "Neat Chignon",           drawable = "hair_fr1_045" },
    { id = "NATIVE_CREATOR_F_HAIR_023", label = "Low Chignon",            drawable = "hair_fr1_045_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_024", label = "Simple Updo",            drawable = "hair_fr1_046" },
    { id = "NATIVE_CREATOR_F_HAIR_025", label = "Tidy Updo",              drawable = "hair_fr1_047" },
    { id = "NATIVE_CREATOR_F_HAIR_026", label = "Messy Halo Braid",       drawable = "hair_fr1_048_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_027", label = "Carefree Layers",        drawable = "hair_fr1_049_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_028", label = "Low Double Bun ",        drawable = "hair_fr1_050" },
    { id = "NATIVE_CREATOR_F_HAIR_029", label = "Tucked Chignon",         drawable = "hair_fr1_051_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_030", label = "Right Curly Ponytail",   drawable = "hair_fr1_052" },
    { id = "NATIVE_CREATOR_F_HAIR_031", label = "Unkempt Full Ponytail",  drawable = "hair_fr1_052_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_032", label = "Left Curly Ponytail",    drawable = "hair_fr1_052_mirrored" },
    { id = "NATIVE_CREATOR_F_HAIR_033", label = "Neat Bun",               drawable = "hair_fr1_053" },
    { id = "NATIVE_CREATOR_F_HAIR_034", label = "Messy Looped Chignon",   drawable = "hair_fr1_053_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_035", label = "Messy Single Plait",     drawable = "hair_fr1_054" },
    { id = "NATIVE_CREATOR_F_HAIR_036", label = "Messy Plait",            drawable = "hair_fr1_054_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_037", label = "Unkempt Waves",          drawable = "hair_fr1_055_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_038", label = "Curled Waves",           drawable = "hair_fr1_056" },
    { id = "NATIVE_CREATOR_F_HAIR_039", label = "Tousled Carefree Waves", drawable = "hair_fr1_056_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_040", label = "Low Bun",                drawable = "hair_fr1_057" },
    { id = "NATIVE_CREATOR_F_HAIR_041", label = "Wind-swept Chignon",     drawable = "hair_fr1_057_dishevelled" },
    { id = "NATIVE_CREATOR_F_HAIR_042", label = "Carefree Chignon",       drawable = "hair_fr1_063" },
}

-- When the above tables do not contain optional keys, the following will be used.
CreatorConfig.CustomHairFallbacks = {
    albedo   = "HAIR_GEN_999_C0_999_AB",
    normal   = "HAIR_GEN_999_C0_999_NM",
    material = "HAIR_GEN_999_C0_999_M",
    palette  = "METAPED_TINT_HAIR",
}

-- Make sure the keys in this table match the ones in CreatorConfig.HairColors.
CreatorConfig.CustomHairTints = {
    BLONDE            = { 68, 57, 79 },
    BROWN             = { 23, 50, 19 },
    DARKEST_BROWN     = { 9, 9, 27 },
    DARK_BLONDE       = { 23, 54, 70 },
    DARK_GINGER       = { 9, 99, 98 },
    DARK_GREY         = { 9, 9, 3 },
    GINGER            = { 89, 96, 59 },
    GREY              = { 9, 3, 3 },
    JET_BLACK         = { 9, 9, 9 },
    LIGHT_BLONDE      = { 78, 67, 81 },
    LIGHT_BROWN       = { 23, 87, 57 },
    LIGHT_GINGER      = { 42, 83, 68 },
    LIGHT_GREY        = { 9, 1, 1 },
    MEDIUM_BROWN      = { 23, 66, 19 },
    SALT_PEPPER       = { 9, 9, 1 },
    STRAWBERRY_BLONDE = { 87, 70, 71 },
    UNCLE_GREY        = { 68, 1, 70 },
}

CreatorConfig.CustomMaleBeards = {
    { id = "NATIVE_CREATOR_M_BEARD_001", label = "Rounded Full Beard",      drawable = "beard_mr1_000" },
    { id = "NATIVE_CREATOR_M_BEARD_002", label = "Lampshade Goatee",        drawable = "beard_mr1_001" },
    { id = "NATIVE_CREATOR_M_BEARD_003", label = "Drover's Beard",          drawable = "beard_mr1_003" },
    { id = "NATIVE_CREATOR_M_BEARD_004", label = "Flat Muttonchops",        drawable = "beard_mr1_004" },
    { id = "NATIVE_CREATOR_M_BEARD_005", label = "Ferryman's Beard",        drawable = "beard_mr1_005" },
    { id = "NATIVE_CREATOR_M_BEARD_006", label = "Shenandoah",              drawable = "beard_mr1_006" },
    { id = "NATIVE_CREATOR_M_BEARD_007", label = "Bushy Horseshoe",         drawable = "beard_mr1_008" },
    { id = "NATIVE_CREATOR_M_BEARD_008", label = "Stockman's Beard",        drawable = "beard_mr1_009" },
    { id = "NATIVE_CREATOR_M_BEARD_009", label = "Long Full Beard",         drawable = "beard_mr1_010" },
    { id = "NATIVE_CREATOR_M_BEARD_010", label = "Cavalier Mustache",       drawable = "beard_mr1_011" },
    { id = "NATIVE_CREATOR_M_BEARD_011", label = "The Prospector",          drawable = "beard_mr1_013" },
    { id = "NATIVE_CREATOR_M_BEARD_012", label = "Nest",                    drawable = "beard_mr1_014" },
    { id = "NATIVE_CREATOR_M_BEARD_013", label = "Messy Beard",             drawable = "beard_mr1_015" },
    { id = "NATIVE_CREATOR_M_BEARD_014", label = "Long Ducktail",           drawable = "beard_mr1_016" },
    { id = "NATIVE_CREATOR_M_BEARD_015", label = "Tapered Box Beard",       drawable = "beard_mr1_017" },
    { id = "NATIVE_CREATOR_M_BEARD_016", label = "Vandyke",                 drawable = "beard_mr1_018" },
    { id = "NATIVE_CREATOR_M_BEARD_017", label = "Pencil Goatee",           drawable = "beard_mr1_019" },
    { id = "NATIVE_CREATOR_M_BEARD_018", label = "Pencil",                  drawable = "beard_mr1_022" },
    { id = "NATIVE_CREATOR_M_BEARD_019", label = "Tapered Beard",           drawable = "beard_mr1_023" },
    { id = "NATIVE_CREATOR_M_BEARD_020", label = "Handlebar Goatee",        drawable = "beard_mr1_024" },
    { id = "NATIVE_CREATOR_M_BEARD_021", label = "Heavy Chops",             drawable = "beard_mr1_025" },
    { id = "NATIVE_CREATOR_M_BEARD_022", label = "Bushy Walrus Verdi",      drawable = "beard_mr1_026" },
    { id = "NATIVE_CREATOR_M_BEARD_023", label = "Long Mountaineers",       drawable = "beard_mr1_027" },
    { id = "NATIVE_CREATOR_M_BEARD_024", label = "Short Shenandoah",        drawable = "beard_mr1_028" },
    { id = "NATIVE_CREATOR_M_BEARD_025", label = "Handlebar with Chops",    drawable = "beard_mr1_029" },
    { id = "NATIVE_CREATOR_M_BEARD_026", label = "Cropped Full",            drawable = "beard_mr1_030" },
    { id = "NATIVE_CREATOR_M_BEARD_027", label = "Handlebar Chevron",       drawable = "beard_mr1_031" },
    { id = "NATIVE_CREATOR_M_BEARD_028", label = "Full Handlebar",          drawable = "beard_mr1_032" },
    { id = "NATIVE_CREATOR_M_BEARD_029", label = "Handlebar Verdi",         drawable = "beard_mr1_033" },
    { id = "NATIVE_CREATOR_M_BEARD_030", label = "Bootleggers Beard",       drawable = "beard_mr1_034" },
    { id = "NATIVE_CREATOR_M_BEARD_031", label = "Full with Walrus",        drawable = "beard_mr1_035" },
    { id = "NATIVE_CREATOR_M_BEARD_032", label = "Heavy Walrus",            drawable = "beard_mr1_036" },
    { id = "NATIVE_CREATOR_M_BEARD_033", label = "Natural Bushy",           drawable = "beard_mr1_037" },
    { id = "NATIVE_CREATOR_M_BEARD_034", label = "Homesteaders",            drawable = "beard_mr1_038" },
    { id = "NATIVE_CREATOR_M_BEARD_035", label = "Scruffy Whiskers",        drawable = "beard_mr1_039" },
    { id = "NATIVE_CREATOR_M_BEARD_036", label = "Short Full Beard",        drawable = "beard_mr1_040" },
    { id = "NATIVE_CREATOR_M_BEARD_037", label = "Boxed with Handlebar",    drawable = "beard_mr1_041" },
    { id = "NATIVE_CREATOR_M_BEARD_038", label = "Scruffy Chevron",         drawable = "beard_mr1_042" },
    { id = "NATIVE_CREATOR_M_BEARD_039", label = "Petite Pencil Handlebar", drawable = "beard_mr1_043" },
    { id = "NATIVE_CREATOR_M_BEARD_040", label = "Scruffy Handlebar",       drawable = "beard_mr1_044" },
    { id = "NATIVE_CREATOR_M_BEARD_041", label = "Chops and Cropped Beard", drawable = "beard_mr1_045" },
    { id = "NATIVE_CREATOR_M_BEARD_042", label = "Walrus Verdi",            drawable = "beard_mr1_046" },
    { id = "NATIVE_CREATOR_M_BEARD_043", label = "Bushy Homesteaders",      drawable = "beard_mr1_047" },
    { id = "NATIVE_CREATOR_M_BEARD_044", label = "Imperial Beard",          drawable = "beard_mr1_048" },
    { id = "NATIVE_CREATOR_M_BEARD_045", label = "Mini Muttonchops",        drawable = "beard_mr1_049" },
    { id = "NATIVE_CREATOR_M_BEARD_046", label = "Forked Beard",            drawable = "beard_mr1_050" },
    { id = "NATIVE_CREATOR_M_BEARD_047", label = "Forked Pioneer's Beard",  drawable = "beard_mr1_051" },
    { id = "NATIVE_CREATOR_M_BEARD_048", label = "Thin Boxed Beard",        drawable = "modular_beard_mr1_shv_chin_000_03" },
    { id = "NATIVE_CREATOR_M_BEARD_049", label = "Trimmed Box Beard",       drawable = "modular_beard_mr1_shv_chin_000_05" },
    { id = "NATIVE_CREATOR_M_BEARD_050", label = "Wide Box Beard",          drawable = "modular_beard_mr1_shv_chin_000_06" },
    { id = "NATIVE_CREATOR_M_BEARD_051", label = "Long Boxed Beard",        drawable = "modular_beard_mr1_shv_chin_000_07" },
    { id = "NATIVE_CREATOR_M_BEARD_052", label = "Messy Box Beard",         drawable = "modular_beard_mr1_shv_chin_000_08" },
    { id = "NATIVE_CREATOR_M_BEARD_053", label = "Extra Long Box Beard",    drawable = "modular_beard_mr1_shv_chin_000_09" },
    { id = "NATIVE_CREATOR_M_BEARD_054", label = "Scruffy Boxed Beard",     drawable = "modular_beard_mr1_shv_chin_001" },
    { id = "NATIVE_CREATOR_M_BEARD_055", label = "Pointed Goatee",          drawable = "modular_beard_mr1_shv_chin_001_03" },
    { id = "NATIVE_CREATOR_M_BEARD_056", label = "Shaved Chops",            drawable = "modular_beard_mr1_shv_chops_000_02" },
    { id = "NATIVE_CREATOR_M_BEARD_057", label = "Cropped Muttonchops",     drawable = "modular_beard_mr1_shv_chops_000_03" },
    { id = "NATIVE_CREATOR_M_BEARD_058", label = "Thinning Chops",          drawable = "modular_beard_mr1_shv_chops_000_04" },
    { id = "NATIVE_CREATOR_M_BEARD_059", label = "Medium Chops",            drawable = "modular_beard_mr1_shv_chops_000_05" },
    { id = "NATIVE_CREATOR_M_BEARD_060", label = "Bushy Chops",             drawable = "modular_beard_mr1_shv_chops_000_06" },
    { id = "NATIVE_CREATOR_M_BEARD_061", label = "Angled Chops",            drawable = "modular_beard_mr1_shv_chops_000_07" },
    { id = "NATIVE_CREATOR_M_BEARD_062", label = "Pointed Chops",           drawable = "modular_beard_mr1_shv_chops_000_08" },
    { id = "NATIVE_CREATOR_M_BEARD_063", label = "Long Chops",              drawable = "modular_beard_mr1_shv_chops_000_09" },
    { id = "NATIVE_CREATOR_M_BEARD_064", label = "Wide Chops",              drawable = "modular_beard_mr1_shv_chops_000_10" },
    { id = "NATIVE_CREATOR_M_BEARD_065", label = "Small Muttonchops",       drawable = "modular_beard_mr1_shv_chops_001_06" },
    { id = "NATIVE_CREATOR_M_BEARD_066", label = "Thinning Brush",          drawable = "modular_beard_mr1_shv_stache_000_03" },
    { id = "NATIVE_CREATOR_M_BEARD_067", label = "Weak Walrus",             drawable = "modular_beard_mr1_shv_stache_000_05" },
    { id = "NATIVE_CREATOR_M_BEARD_068", label = "Sargeant's Mustache",     drawable = "modular_beard_mr1_shv_stache_000_06" },
    { id = "NATIVE_CREATOR_M_BEARD_069", label = "Drooped Walrus",          drawable = "modular_beard_mr1_shv_stache_000_07" },
    { id = "NATIVE_CREATOR_M_BEARD_070", label = "Neat Walrus",             drawable = "modular_beard_mr1_shv_stache_000_08" },
    { id = "NATIVE_CREATOR_M_BEARD_071", label = "Bushy Walrus",            drawable = "modular_beard_mr1_shv_stache_000_09" },
    { id = "NATIVE_CREATOR_M_BEARD_072", label = "Simple Walrus",           drawable = "modular_beard_mr1_shv_stache_000_10" },
    { id = "NATIVE_CREATOR_M_BEARD_073", label = "Wavy Horseshoe",          drawable = "modular_beard_mr1_shv_stache_001" },
    { id = "NATIVE_CREATOR_M_BEARD_074", label = "Pencil Handlebar",        drawable = "modular_beard_mr1_shv_stache_001_05" },
    { id = "NATIVE_CREATOR_M_BEARD_075", label = "Unkempt Handlebar",       drawable = "modular_beard_mr1_shv_stache_001_09" },
    { id = "NATIVE_CREATOR_M_BEARD_076", label = "Bold Handlebar",          drawable = "modular_beard_mr1_shv_stache_002_08" },
    { id = "NATIVE_CREATOR_M_BEARD_077", label = "Handlebar",               drawable = "modular_beard_mr1_shv_stache_002_09" },
    { id = "NATIVE_CREATOR_M_BEARD_078", label = "Cowboy Horseshoe",        drawable = "modular_beard_mr1_shv_stache_003" },
}

-- When the above tables do not contain optional keys, the following will be used.
CreatorConfig.CustomBeardFallbacks = {
    albedo   = "BEARD_MR1_000_C0_005_AB",
    normal   = "BEARD_MR1_000_C0_000_NM",
    material = "BEARD_MR1_000_C0_000_M",
    palette  = "METAPED_TINT_HAIR",
}

-- Make sure the keys in this table match the ones in CreatorConfig.HairColors.
CreatorConfig.CustomBeardTints = {
    BLONDE            = { 68, 57, 2 },
    BROWN             = { 23, 50, 19 },
    DARKEST_BROWN     = { 9, 9, 27 },
    DARK_BLONDE       = { 23, 54, 70 },
    DARK_GINGER       = { 9, 99, 98 },
    DARK_GREY         = { 9, 9, 3 },
    GINGER            = { 89, 96, 59 },
    GREY              = { 9, 3, 3 },
    JET_BLACK         = { 9, 9, 9 },
    LIGHT_BLONDE      = { 78, 67, 1 },
    LIGHT_BROWN       = { 23, 87, 57 },
    LIGHT_GINGER      = { 42, 83, 68 },
    LIGHT_GREY        = { 9, 1, 1 },
    MEDIUM_BROWN      = { 23, 66, 19 },
    SALT_PEPPER       = { 9, 9, 1 },
    STRAWBERRY_BLONDE = { 87, 70, 71 },
    UNCLE_GREY        = { 68, 1, 70 },
}

--- =========================================
--- ==           OVERLAY CONFIG            ==
--- =========================================

-- Blends are configurations that will be applied as an overlay to the ped's head.
-- They can be configured through "client/character/blends.lua".
-- You may choose to filter any overlay by gender using the "gender" key.

CreatorConfig.Overlays = {
    -- The aging blend used will depend on the preset selected, but it can also be
    -- manually changed in advanced mode, the label is only used in advanced mode
    [OVERLAY_LAYER.AGEING] = {
        { id = "NATIVE_CREATOR_AGING_01", label = "Style 1",  blend = "BLEND_AGING_01" },
        { id = "NATIVE_CREATOR_AGING_02", label = "Style 2",  blend = "BLEND_AGING_02" },
        { id = "NATIVE_CREATOR_AGING_03", label = "Style 3",  blend = "BLEND_AGING_03" },
        { id = "NATIVE_CREATOR_AGING_04", label = "Style 4",  blend = "BLEND_AGING_04" },
        { id = "NATIVE_CREATOR_AGING_05", label = "Style 5",  blend = "BLEND_AGING_05" },
        { id = "NATIVE_CREATOR_AGING_06", label = "Style 6",  blend = "BLEND_AGING_06" },
        { id = "NATIVE_CREATOR_AGING_07", label = "Style 7",  blend = "BLEND_AGING_07" },
        { id = "NATIVE_CREATOR_AGING_08", label = "Style 8",  blend = "BLEND_AGING_08" },
        { id = "NATIVE_CREATOR_AGING_09", label = "Style 9",  blend = "BLEND_AGING_09" },
        { id = "NATIVE_CREATOR_AGING_10", label = "Style 10", blend = "BLEND_AGING_10" },
        { id = "NATIVE_CREATOR_AGING_11", label = "Style 11", blend = "BLEND_AGING_11" },
        { id = "NATIVE_CREATOR_AGING_12", label = "Style 12", blend = "BLEND_AGING_12" },
        { id = "NATIVE_CREATOR_AGING_13", label = "Style 13", blend = "BLEND_AGING_13" },
        { id = "NATIVE_CREATOR_AGING_14", label = "Style 14", blend = "BLEND_AGING_14" },
        { id = "NATIVE_CREATOR_AGING_15", label = "Style 15", blend = "BLEND_AGING_15" },
        { id = "NATIVE_CREATOR_AGING_16", label = "Style 16", blend = "BLEND_AGING_16" },
        { id = "NATIVE_CREATOR_AGING_17", label = "Style 17", blend = "BLEND_AGING_17" },
        { id = "NATIVE_CREATOR_AGING_18", label = "Style 18", blend = "BLEND_AGING_18" },
        { id = "NATIVE_CREATOR_AGING_19", label = "Style 19", blend = "BLEND_AGING_19" },
        { id = "NATIVE_CREATOR_AGING_20", label = "Style 20", blend = "BLEND_AGING_20" },
        { id = "NATIVE_CREATOR_AGING_21", label = "Style 21", blend = "BLEND_AGING_21" },
        { id = "NATIVE_CREATOR_AGING_22", label = "Style 22", blend = "BLEND_AGING_22" },
        { id = "NATIVE_CREATOR_AGING_23", label = "Style 23", blend = "BLEND_AGING_23" },
        { id = "NATIVE_CREATOR_AGING_24", label = "Style 24", blend = "BLEND_AGING_24" },
    },
    -- "%s" will be replaced by the current hair color
    [OVERLAY_LAYER.EYEBROWS] = {
        { id = "CHAR_CREATOR_EYEBROWS_01",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_01_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_02",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_02_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_03",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_03_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_04",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_04_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_05",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_05_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_06",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_06_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_07",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_07_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_08",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_08_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_09",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_09_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_10",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_10_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_11",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_11_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_12",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_12_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_13",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_13_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_14",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_14_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_15",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_15_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_16",   label = nil, gender = "M", blend = "BLEND_EYEBROWS_M_16_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_F_01", label = nil, gender = "F", blend = "BLEND_EYEBROWS_F_01_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_F_02", label = nil, gender = "F", blend = "BLEND_EYEBROWS_F_02_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_F_03", label = nil, gender = "F", blend = "BLEND_EYEBROWS_F_03_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_F_04", label = nil, gender = "F", blend = "BLEND_EYEBROWS_F_04_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_F_05", label = nil, gender = "F", blend = "BLEND_EYEBROWS_F_05_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_F_06", label = nil, gender = "F", blend = "BLEND_EYEBROWS_F_06_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_F_07", label = nil, gender = "F", blend = "BLEND_EYEBROWS_F_07_%s" },
        { id = "CHAR_CREATOR_EYEBROWS_F_08", label = nil, gender = "F", blend = "BLEND_EYEBROWS_F_08_%s" },
    },
    [OVERLAY_LAYER.SKIN_MOTTLING] = {
        { id = "CHAR_CREATOR_SKIN_MOTTLING_01", label = nil, blend = "BLEND_SKIN_MOTTLING_01" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_02", label = nil, blend = "BLEND_SKIN_MOTTLING_02" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_03", label = nil, blend = "BLEND_SKIN_MOTTLING_03" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_04", label = nil, blend = "BLEND_SKIN_MOTTLING_04" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_05", label = nil, blend = "BLEND_SKIN_MOTTLING_05" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_06", label = nil, blend = "BLEND_SKIN_MOTTLING_06" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_07", label = nil, blend = "BLEND_SKIN_MOTTLING_07" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_08", label = nil, blend = "BLEND_SKIN_MOTTLING_08" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_09", label = nil, blend = "BLEND_SKIN_MOTTLING_09" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_10", label = nil, blend = "BLEND_SKIN_MOTTLING_10" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_11", label = nil, blend = "BLEND_SKIN_MOTTLING_11" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_12", label = nil, blend = "BLEND_SKIN_MOTTLING_12" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_13", label = nil, blend = "BLEND_SKIN_MOTTLING_13" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_14", label = nil, blend = "BLEND_SKIN_MOTTLING_14" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_15", label = nil, blend = "BLEND_SKIN_MOTTLING_15" },
        { id = "CHAR_CREATOR_SKIN_MOTTLING_16", label = nil, blend = "BLEND_SKIN_MOTTLING_16" },
    },
    [OVERLAY_LAYER.COMPLEXION] = {
        { id = "CHAR_CREATOR_COMPLEXION_01", label = nil, blend = "BLEND_COMPLEXION_01" },
        { id = "CHAR_CREATOR_COMPLEXION_02", label = nil, blend = "BLEND_COMPLEXION_02" },
        { id = "CHAR_CREATOR_COMPLEXION_03", label = nil, blend = "BLEND_COMPLEXION_03" },
        { id = "CHAR_CREATOR_COMPLEXION_04", label = nil, blend = "BLEND_COMPLEXION_04" },
        { id = "CHAR_CREATOR_COMPLEXION_05", label = nil, blend = "BLEND_COMPLEXION_05" },
        { id = "CHAR_CREATOR_COMPLEXION_06", label = nil, blend = "BLEND_COMPLEXION_06" },
        { id = "CHAR_CREATOR_COMPLEXION_07", label = nil, blend = "BLEND_COMPLEXION_07" },
        { id = "CHAR_CREATOR_COMPLEXION_08", label = nil, blend = "BLEND_COMPLEXION_08" },
        { id = "CHAR_CREATOR_COMPLEXION_09", label = nil, blend = "BLEND_COMPLEXION_09" },
        { id = "CHAR_CREATOR_COMPLEXION_10", label = nil, blend = "BLEND_COMPLEXION_10" },
        { id = "CHAR_CREATOR_COMPLEXION_11", label = nil, blend = "BLEND_COMPLEXION_11" },
        { id = "CHAR_CREATOR_COMPLEXION_12", label = nil, blend = "BLEND_COMPLEXION_12" },
        { id = "CHAR_CREATOR_COMPLEXION_13", label = nil, blend = "BLEND_COMPLEXION_13" },
        { id = "CHAR_CREATOR_COMPLEXION_14", label = nil, blend = "BLEND_COMPLEXION_14" },
    },
    [OVERLAY_LAYER.COMPLEXION_2] = {
        { id = "CHAR_CREATOR_COMPLEXION_01", label = nil, blend = "BLEND_COMPLEXION_2_01" },
        { id = "CHAR_CREATOR_COMPLEXION_02", label = nil, blend = "BLEND_COMPLEXION_2_02" },
        { id = "CHAR_CREATOR_COMPLEXION_03", label = nil, blend = "BLEND_COMPLEXION_2_03" },
        { id = "CHAR_CREATOR_COMPLEXION_04", label = nil, blend = "BLEND_COMPLEXION_2_04" },
        { id = "CHAR_CREATOR_COMPLEXION_05", label = nil, blend = "BLEND_COMPLEXION_2_05" },
        { id = "CHAR_CREATOR_COMPLEXION_06", label = nil, blend = "BLEND_COMPLEXION_2_06" },
        { id = "CHAR_CREATOR_COMPLEXION_07", label = nil, blend = "BLEND_COMPLEXION_2_07" },
        { id = "CHAR_CREATOR_COMPLEXION_08", label = nil, blend = "BLEND_COMPLEXION_2_08" },
        { id = "CHAR_CREATOR_COMPLEXION_09", label = nil, blend = "BLEND_COMPLEXION_2_09" },
        { id = "CHAR_CREATOR_COMPLEXION_10", label = nil, blend = "BLEND_COMPLEXION_2_10" },
        { id = "CHAR_CREATOR_COMPLEXION_11", label = nil, blend = "BLEND_COMPLEXION_2_11" },
        { id = "CHAR_CREATOR_COMPLEXION_12", label = nil, blend = "BLEND_COMPLEXION_2_12" },
        { id = "CHAR_CREATOR_COMPLEXION_13", label = nil, blend = "BLEND_COMPLEXION_2_13" },
        { id = "CHAR_CREATOR_COMPLEXION_14", label = nil, blend = "BLEND_COMPLEXION_2_14" },
    },
    [OVERLAY_LAYER.FRECKLES] = {
        { id = "CHAR_CREATOR_FRECKLES_01",   label = nil,        blend = "BLEND_FRECKLES_01" },
        { id = "CHAR_CREATOR_FRECKLES_02",   label = nil,        blend = "BLEND_FRECKLES_02" },
        { id = "CHAR_CREATOR_FRECKLES_03",   label = nil,        blend = "BLEND_FRECKLES_03" },
        { id = "CHAR_CREATOR_FRECKLES_04",   label = nil,        blend = "BLEND_FRECKLES_04" },
        { id = "CHAR_CREATOR_FRECKLES_05",   label = nil,        blend = "BLEND_FRECKLES_05" },
        { id = "CHAR_CREATOR_FRECKLES_06",   label = nil,        blend = "BLEND_FRECKLES_06" },
        { id = "CHAR_CREATOR_FRECKLES_07",   label = nil,        blend = "BLEND_FRECKLES_07" },
        { id = "CHAR_CREATOR_FRECKLES_08",   label = nil,        blend = "BLEND_FRECKLES_08" },
        { id = "CHAR_CREATOR_FRECKLES_09",   label = nil,        blend = "BLEND_FRECKLES_09" },
        { id = "CHAR_CREATOR_FRECKLES_10",   label = nil,        blend = "BLEND_FRECKLES_10" },
        { id = "CHAR_CREATOR_FRECKLES_11",   label = nil,        blend = "BLEND_FRECKLES_11" },
        { id = "NATIVE_CREATOR_FRECKLES_12", label = "Style 12", blend = "BLEND_FRECKLES_12" },
        { id = "NATIVE_CREATOR_FRECKLES_13", label = "Style 13", blend = "BLEND_FRECKLES_13" },
        { id = "NATIVE_CREATOR_FRECKLES_14", label = "Style 14", blend = "BLEND_FRECKLES_14" },
        { id = "NATIVE_CREATOR_FRECKLES_15", label = "Style 15", blend = "BLEND_FRECKLES_15" },
    },
    [OVERLAY_LAYER.MOLES] = {
        { id = "CHAR_CREATOR_MOLES_01", label = nil, blend = "BLEND_MOLES_01" },
        { id = "CHAR_CREATOR_MOLES_02", label = nil, blend = "BLEND_MOLES_02" },
        { id = "CHAR_CREATOR_MOLES_03", label = nil, blend = "BLEND_MOLES_03" },
        { id = "CHAR_CREATOR_MOLES_04", label = nil, blend = "BLEND_MOLES_04" },
        { id = "CHAR_CREATOR_MOLES_05", label = nil, blend = "BLEND_MOLES_05" },
        { id = "CHAR_CREATOR_MOLES_06", label = nil, blend = "BLEND_MOLES_06" },
        { id = "CHAR_CREATOR_MOLES_07", label = nil, blend = "BLEND_MOLES_07" },
        { id = "CHAR_CREATOR_MOLES_08", label = nil, blend = "BLEND_MOLES_08" },
        { id = "CHAR_CREATOR_MOLES_09", label = nil, blend = "BLEND_MOLES_09" },
        { id = "CHAR_CREATOR_MOLES_10", label = nil, blend = "BLEND_MOLES_10" },
        { id = "CHAR_CREATOR_MOLES_11", label = nil, blend = "BLEND_MOLES_11" },
        { id = "CHAR_CREATOR_MOLES_12", label = nil, blend = "BLEND_MOLES_12" },
        { id = "CHAR_CREATOR_MOLES_13", label = nil, blend = "BLEND_MOLES_13" },
        { id = "CHAR_CREATOR_MOLES_14", label = nil, blend = "BLEND_MOLES_14" },
        { id = "CHAR_CREATOR_MOLES_15", label = nil, blend = "BLEND_MOLES_15" },
        { id = "CHAR_CREATOR_MOLES_16", label = nil, blend = "BLEND_MOLES_16" },
    },
    [OVERLAY_LAYER.SPOTS] = {
        { id = "CHAR_CREATOR_SPOTS_01",   label = nil,         blend = "BLEND_SPOTS_01" },
        { id = "CHAR_CREATOR_SPOTS_02",   label = nil,         blend = "BLEND_SPOTS_02" },
        { id = "CHAR_CREATOR_SPOTS_03",   label = nil,         blend = "BLEND_SPOTS_03" },
        { id = "CHAR_CREATOR_SPOTS_04",   label = nil,         blend = "BLEND_SPOTS_04" },
        { id = "CHAR_CREATOR_SPOTS_05",   label = nil,         blend = "BLEND_SPOTS_05" },
        { id = "CHAR_CREATOR_SPOTS_06",   label = nil,         blend = "BLEND_SPOTS_06" },
        { id = "CHAR_CREATOR_SPOTS_07",   label = nil,         blend = "BLEND_SPOTS_07" },
        { id = "CHAR_CREATOR_SPOTS_08",   label = nil,         blend = "BLEND_SPOTS_08" },
        { id = "CHAR_CREATOR_SPOTS_09",   label = nil,         blend = "BLEND_SPOTS_09" },
        { id = "CHAR_CREATOR_SPOTS_10",   label = nil,         blend = "BLEND_SPOTS_10" },
        { id = "CHAR_CREATOR_SPOTS_11",   label = nil,         blend = "BLEND_SPOTS_11" },
        { id = "CHAR_CREATOR_SPOTS_12",   label = nil,         blend = "BLEND_SPOTS_12" },
        { id = "CHAR_CREATOR_SPOTS_13",   label = nil,         blend = "BLEND_SPOTS_13" },
        { id = "CHAR_CREATOR_SPOTS_14",   label = nil,         blend = "BLEND_SPOTS_14" },
        { id = "CHAR_CREATOR_SPOTS_15",   label = nil,         blend = "BLEND_SPOTS_15" },
        { id = "CHAR_CREATOR_SPOTS_16",   label = nil,         blend = "BLEND_SPOTS_16" },
        { id = "NATIVE_CREATOR_SPOTS_17", label = "Mild Acne", blend = "BLEND_SPOTS_17" },
    },
    [OVERLAY_LAYER.SCAR] = {
        { id = "CHAR_CREATOR_SCAR_01", label = nil, blend = "BLEND_SCAR_01" },
        { id = "CHAR_CREATOR_SCAR_02", label = nil, blend = "BLEND_SCAR_02" },
        { id = "CHAR_CREATOR_SCAR_03", label = nil, blend = "BLEND_SCAR_03" },
        { id = "CHAR_CREATOR_SCAR_04", label = nil, blend = "BLEND_SCAR_04" },
        { id = "CHAR_CREATOR_SCAR_05", label = nil, blend = "BLEND_SCAR_05" },
        { id = "CHAR_CREATOR_SCAR_06", label = nil, blend = "BLEND_SCAR_06" },
        { id = "CHAR_CREATOR_SCAR_07", label = nil, blend = "BLEND_SCAR_07" },
        { id = "CHAR_CREATOR_SCAR_08", label = nil, blend = "BLEND_SCAR_08" },
        { id = "CHAR_CREATOR_SCAR_09", label = nil, blend = "BLEND_SCAR_09" },
        { id = "CHAR_CREATOR_SCAR_10", label = nil, blend = "BLEND_SCAR_10" },
        { id = "CHAR_CREATOR_SCAR_11", label = nil, blend = "BLEND_SCAR_11" },
        { id = "CHAR_CREATOR_SCAR_12", label = nil, blend = "BLEND_SCAR_12" },
        { id = "CHAR_CREATOR_SCAR_13", label = nil, blend = "BLEND_SCAR_13" },
        { id = "CHAR_CREATOR_SCAR_14", label = nil, blend = "BLEND_SCAR_14" },
        { id = "CHAR_CREATOR_SCAR_15", label = nil, blend = "BLEND_SCAR_15" },
        { id = "CHAR_CREATOR_SCAR_16", label = nil, blend = "BLEND_SCAR_16" },
    },
    [OVERLAY_LAYER.FOUNDATION] = {
        { id = "CHAR_CREATOR_FOUNDATION_01", label = nil, gender = "F", blend = "BLEND_FOUNDATION_01" },
    },
    [OVERLAY_LAYER.BLUSHER] = {
        { id = "CHAR_CREATOR_BLUSHER_01", label = nil, gender = "F", blend = "BLEND_BLUSHER_01" },
        { id = "CHAR_CREATOR_BLUSHER_02", label = nil, gender = "F", blend = "BLEND_BLUSHER_02" },
        { id = "CHAR_CREATOR_BLUSHER_03", label = nil, gender = "F", blend = "BLEND_BLUSHER_03" },
        { id = "CHAR_CREATOR_BLUSHER_04", label = nil, gender = "F", blend = "BLEND_BLUSHER_04" },
    },
    [OVERLAY_LAYER.EYELINER] = {
        { id = "CHAR_CREATOR_EYELINER_01",   label = nil,        gender = "F", blend = "BLEND_EYELINER_01" },
        { id = "CHAR_CREATOR_EYELINER_02",   label = nil,        gender = "F", blend = "BLEND_EYELINER_02" },
        { id = "CHAR_CREATOR_EYELINER_03",   label = nil,        gender = "F", blend = "BLEND_EYELINER_03" },
        { id = "CHAR_CREATOR_EYELINER_04",   label = nil,        gender = "F", blend = "BLEND_EYELINER_04" },
        { id = "CHAR_CREATOR_EYELINER_05",   label = nil,        gender = "F", blend = "BLEND_EYELINER_05" },
        { id = "CHAR_CREATOR_EYELINER_06",   label = nil,        gender = "F", blend = "BLEND_EYELINER_06" },
        { id = "NATIVE_CREATOR_EYELINER_07", label = "Style 7",  gender = "F", blend = "BLEND_EYELINER_07" },
        { id = "NATIVE_CREATOR_EYELINER_08", label = "Style 8",  gender = "F", blend = "BLEND_EYELINER_08" },
        { id = "NATIVE_CREATOR_EYELINER_09", label = "Style 9",  gender = "F", blend = "BLEND_EYELINER_09" },
        { id = "NATIVE_CREATOR_EYELINER_10", label = "Style 10", gender = "F", blend = "BLEND_EYELINER_10" },
        { id = "NATIVE_CREATOR_EYELINER_11", label = "Style 11", gender = "F", blend = "BLEND_EYELINER_11" },
        { id = "NATIVE_CREATOR_EYELINER_12", label = "Style 12", gender = "F", blend = "BLEND_EYELINER_12" },
        { id = "NATIVE_CREATOR_EYELINER_13", label = "Style 13", gender = "F", blend = "BLEND_EYELINER_13" },
        { id = "NATIVE_CREATOR_EYELINER_14", label = "Style 14", gender = "F", blend = "BLEND_EYELINER_14" },
        { id = "NATIVE_CREATOR_EYELINER_15", label = "Style 15", gender = "F", blend = "BLEND_EYELINER_15" },
        { id = "NATIVE_CREATOR_EYELINER_16", label = "Style 16", gender = "F", blend = "BLEND_EYELINER_16" },
    },
    [OVERLAY_LAYER.EYESHADOW] = {
        { id = "CHAR_CREATOR_EYESHADOW_01", label = nil, gender = "F", blend = "BLEND_EYESHADOW_01_TINT_01", colors = { "BLEND_EYESHADOW_01_TINT_01", "BLEND_EYESHADOW_01_TINT_02", "BLEND_EYESHADOW_01_TINT_03", "BLEND_EYESHADOW_01_TINT_04" } },
        { id = "CHAR_CREATOR_EYESHADOW_02", label = nil, gender = "F", blend = "BLEND_EYESHADOW_02_TINT_01", colors = { "BLEND_EYESHADOW_02_TINT_01", "BLEND_EYESHADOW_02_TINT_02", "BLEND_EYESHADOW_02_TINT_03", "BLEND_EYESHADOW_02_TINT_04" } },
        { id = "CHAR_CREATOR_EYESHADOW_03", label = nil, gender = "F", blend = "BLEND_EYESHADOW_03_TINT_01", colors = { "BLEND_EYESHADOW_03_TINT_01", "BLEND_EYESHADOW_03_TINT_02", "BLEND_EYESHADOW_03_TINT_03", "BLEND_EYESHADOW_03_TINT_04" } },
        { id = "CHAR_CREATOR_EYESHADOW_04", label = nil, gender = "F", blend = "BLEND_EYESHADOW_04_TINT_01", colors = { "BLEND_EYESHADOW_04_TINT_01", "BLEND_EYESHADOW_04_TINT_02", "BLEND_EYESHADOW_04_TINT_03", "BLEND_EYESHADOW_04_TINT_04" } },
        { id = "CHAR_CREATOR_EYESHADOW_05", label = nil, gender = "F", blend = "BLEND_EYESHADOW_05_TINT_01", colors = { "BLEND_EYESHADOW_05_TINT_01", "BLEND_EYESHADOW_05_TINT_02", "BLEND_EYESHADOW_05_TINT_03", "BLEND_EYESHADOW_05_TINT_04" } },
        { id = "CHAR_CREATOR_EYESHADOW_06", label = nil, gender = "F", blend = "BLEND_EYESHADOW_06_TINT_01", colors = { "BLEND_EYESHADOW_06_TINT_01", "BLEND_EYESHADOW_06_TINT_02", "BLEND_EYESHADOW_06_TINT_03", "BLEND_EYESHADOW_06_TINT_04" } },
    },
    [OVERLAY_LAYER.LIPSTICK] = {
        { id = "CHAR_CREATOR_LIPSTICK_01",   label = nil,        gender = "F", blend = "BLEND_LIPSTICK_01_TINT_01", colors = { "BLEND_LIPSTICK_01_TINT_01", "BLEND_LIPSTICK_01_TINT_02", "BLEND_LIPSTICK_01_TINT_03", "BLEND_LIPSTICK_01_TINT_04" } },
        { id = "CHAR_CREATOR_LIPSTICK_02",   label = nil,        gender = "F", blend = "BLEND_LIPSTICK_02_TINT_01", colors = { "BLEND_LIPSTICK_02_TINT_01", "BLEND_LIPSTICK_02_TINT_02", "BLEND_LIPSTICK_02_TINT_03", "BLEND_LIPSTICK_02_TINT_04" } },
        { id = "CHAR_CREATOR_LIPSTICK_03",   label = nil,        gender = "F", blend = "BLEND_LIPSTICK_03_TINT_01", colors = { "BLEND_LIPSTICK_03_TINT_01", "BLEND_LIPSTICK_03_TINT_02", "BLEND_LIPSTICK_03_TINT_03", "BLEND_LIPSTICK_03_TINT_04" } },
        { id = "CHAR_CREATOR_LIPSTICK_04",   label = nil,        gender = "F", blend = "BLEND_LIPSTICK_04_TINT_01", colors = { "BLEND_LIPSTICK_04_TINT_01", "BLEND_LIPSTICK_04_TINT_02", "BLEND_LIPSTICK_04_TINT_03", "BLEND_LIPSTICK_04_TINT_04" } },
        { id = "NATIVE_CREATOR_LIPSTICK_05", label = "Chaplin",  gender = "F", blend = "BLEND_LIPSTICK_05_TINT_01", colors = { "BLEND_LIPSTICK_05_TINT_01", "BLEND_LIPSTICK_05_TINT_02", "BLEND_LIPSTICK_05_TINT_03", "BLEND_LIPSTICK_05_TINT_04" } },
        { id = "NATIVE_CREATOR_LIPSTICK_06", label = "Heart",    gender = "F", blend = "BLEND_LIPSTICK_06_TINT_01", colors = { "BLEND_LIPSTICK_06_TINT_01", "BLEND_LIPSTICK_06_TINT_02", "BLEND_LIPSTICK_06_TINT_03", "BLEND_LIPSTICK_06_TINT_04" } },
        { id = "NATIVE_CREATOR_LIPSTICK_07", label = "Outlined", gender = "F", blend = "BLEND_LIPSTICK_07_TINT_01", colors = { "BLEND_LIPSTICK_07_TINT_01", "BLEND_LIPSTICK_07_TINT_02", "BLEND_LIPSTICK_07_TINT_03", "BLEND_LIPSTICK_07_TINT_04" } },
    },
    -- "%s" will be replaced by the current beard color
    [OVERLAY_LAYER.FACIAL_HAIR] = {
        { id = "NATIVE_CREATOR_FACIAL_HAIR_01", label = "Style 1", gender = "M", blend = "BLEND_FACIALHAIR_01_%s" },
        { id = "NATIVE_CREATOR_FACIAL_HAIR_02", label = "Style 2", gender = "M", blend = "BLEND_FACIALHAIR_02_%s" },
        { id = "NATIVE_CREATOR_FACIAL_HAIR_03", label = "Style 3", gender = "M", blend = "BLEND_FACIALHAIR_03_%s" },
    },
    [OVERLAY_LAYER.GRIME] = {
        { id = "CHAR_CREATOR_GRIME_01", label = nil, blend = "BLEND_GRIME_01" },
        { id = "CHAR_CREATOR_GRIME_02", label = nil, blend = "BLEND_GRIME_02" },
        { id = "CHAR_CREATOR_GRIME_03", label = nil, blend = "BLEND_GRIME_03" },
        { id = "CHAR_CREATOR_GRIME_04", label = nil, blend = "BLEND_GRIME_04" },
        { id = "CHAR_CREATOR_GRIME_05", label = nil, blend = "BLEND_GRIME_05" },
        { id = "CHAR_CREATOR_GRIME_06", label = nil, blend = "BLEND_GRIME_06" },
        { id = "CHAR_CREATOR_GRIME_07", label = nil, blend = "BLEND_GRIME_07" },
        { id = "CHAR_CREATOR_GRIME_08", label = nil, blend = "BLEND_GRIME_08" },
        { id = "CHAR_CREATOR_GRIME_09", label = nil, blend = "BLEND_GRIME_09" },
        { id = "CHAR_CREATOR_GRIME_10", label = nil, blend = "BLEND_GRIME_10" },
        { id = "CHAR_CREATOR_GRIME_11", label = nil, blend = "BLEND_GRIME_11" },
        { id = "CHAR_CREATOR_GRIME_12", label = nil, blend = "BLEND_GRIME_12" },
        { id = "CHAR_CREATOR_GRIME_13", label = nil, blend = "BLEND_GRIME_13" },
        { id = "CHAR_CREATOR_GRIME_14", label = nil, blend = "BLEND_GRIME_14" },
        { id = "CHAR_CREATOR_GRIME_15", label = nil, blend = "BLEND_GRIME_15" },
        { id = "CHAR_CREATOR_GRIME_16", label = nil, blend = "BLEND_GRIME_16" },
    },
    -- "%s" will be replaced by the current hair color
    [OVERLAY_LAYER.HEAD_HAIR] = {
        { id = "NATIVE_CREATOR_HEAD_HAIR_01", label = "Style 1", blend = "BLEND_HEADHAIR_01_%s" },
        { id = "NATIVE_CREATOR_HEAD_HAIR_02", label = "Style 2", blend = "BLEND_HEADHAIR_02_%s" },
        { id = "NATIVE_CREATOR_HEAD_HAIR_03", label = "Style 3", blend = "BLEND_HEADHAIR_03_%s" },
        { id = "NATIVE_CREATOR_HEAD_HAIR_04", label = "Style 4", blend = "BLEND_HEADHAIR_04_%s" },
    },
    [OVERLAY_LAYER.SCAR_2] = {
        { id = "CHAR_CREATOR_SCAR_01", label = nil, blend = "BLEND_SCAR_01" },
        { id = "CHAR_CREATOR_SCAR_02", label = nil, blend = "BLEND_SCAR_02" },
        { id = "CHAR_CREATOR_SCAR_03", label = nil, blend = "BLEND_SCAR_03" },
        { id = "CHAR_CREATOR_SCAR_04", label = nil, blend = "BLEND_SCAR_04" },
        { id = "CHAR_CREATOR_SCAR_05", label = nil, blend = "BLEND_SCAR_05" },
        { id = "CHAR_CREATOR_SCAR_06", label = nil, blend = "BLEND_SCAR_06" },
        { id = "CHAR_CREATOR_SCAR_07", label = nil, blend = "BLEND_SCAR_07" },
        { id = "CHAR_CREATOR_SCAR_08", label = nil, blend = "BLEND_SCAR_08" },
        { id = "CHAR_CREATOR_SCAR_09", label = nil, blend = "BLEND_SCAR_09" },
        { id = "CHAR_CREATOR_SCAR_10", label = nil, blend = "BLEND_SCAR_10" },
        { id = "CHAR_CREATOR_SCAR_11", label = nil, blend = "BLEND_SCAR_11" },
        { id = "CHAR_CREATOR_SCAR_12", label = nil, blend = "BLEND_SCAR_12" },
        { id = "CHAR_CREATOR_SCAR_13", label = nil, blend = "BLEND_SCAR_13" },
        { id = "CHAR_CREATOR_SCAR_14", label = nil, blend = "BLEND_SCAR_14" },
        { id = "CHAR_CREATOR_SCAR_15", label = nil, blend = "BLEND_SCAR_15" },
        { id = "CHAR_CREATOR_SCAR_16", label = nil, blend = "BLEND_SCAR_16" },
    },
}
