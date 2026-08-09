---@class PED_EXPRESSIONS : EnumRegistry
---@field GetHash fun(self, id: number): integer|nil
---@field GetIdFromHash fun(self, hash: integer): number|nil
---@field GetNameFromId fun(self, id: number): string|nil
---@field GetIdFromName fun(self, name: string): number|nil
---@field GetReversed fun(self, id: number): boolean|nil
---@field GetRandomized fun(self, id: number): boolean|nil
---@field ToString fun(self, id: number): string
local PED_EXPRESSIONS = {
    BROW_WIDTH          = 12281, -- Eyes & Brows > Brow Shape
    BROW_HEIGHT         = 13059, -- Eyes & Brows > Brow Shape
    BROW_DEPTH          = 19153, -- Eyes & Brows > Brow Depth
    EYE_WIDTH           = 7019,  -- Eyes & Brows > Eye Size
    EYE_HEIGHT          = 35627, -- Eyes & Brows > Eye Size
    EYE_ANGLE           = 53862, -- Eyes & Brows > Eye Socket
    EYE_DEPTH           = 60996, -- Eyes & Brows > Eye Socket
    EYE_H_POS           = 42318, -- Eyes & Brows > Eye Position
    EYE_V_POS           = 56827, -- Eyes & Brows > Eye Position
    NOSE_WIDTH          = 28287, -- Nose > Nose Size
    NOSE_HEIGHT         = 1013,  -- Nose > Nose Size
    NOSE_BREAK          = 61782, -- Nose > Nose Shape
    NOSE_LENGTH         = 13425, -- Nose > Nose Shape
    NOSTRIL_WIDTH       = 22046, -- Nose > Nose Tip
    NOSE_TILT           = 13489, -- Nose > Nose Tip
    MOUTH_WIDTH         = 61541, -- Mouth & Lips > Mouth
    MOUTH_DEPTH         = 43625, -- Mouth & Lips > Mouth
    MOUTH_V_POS         = 16653, -- Mouth & Lips > Mouth Position
    UPPER_LIP_WIDTH     = 37313, -- Mouth & Lips > Upper Lip
    UPPER_LIP_THICKNESS = 6656,  -- Mouth & Lips > Upper Lip
    LOWER_LIP_WIDTH     = 45232, -- Mouth & Lips > Lower Lip
    LOWER_LIP_THICKNESS = 47949, -- Mouth & Lips > Lower Lip
    UPPER_LIPDEPTH      = 50037, -- Mouth & Lips > Lip Depth
    LOWER_LIP_DEPTH     = 23830, -- Mouth & Lips > Lip Depth
    JAW_WIDTH           = 60334, -- Jaw & Chin > Jaw Shape
    JAW_HEIGHT          = 36106, -- Jaw & Chin > Jaw Shape
    JAW_DEPTH           = 7670,  -- Jaw & Chin > Jaw Depth
    CHIN_WIDTH          = 50098, -- Jaw & Chin > Chin Shape
    CHIN_TILT           = 15375, -- Jaw & Chin > Chin Shape
    CHIN_DEPTH          = 58147, -- Jaw & Chin > Chin Depth
    EAR_ROTATION        = 46798, -- Ears > Ear Shape
    EAR_LENGTH          = 10308, -- Ears > Ear Shape
    EAR_SIZE            = 49231, -- Ears > Ear Size
    EAR_LOBE            = 60720, -- Ears > Ear Size
    CHEEKS_WIDTH        = 43983, -- Cheeks > Cheek Shape
    CHEEKS_HEIGHT       = 27147, -- Cheeks > Cheek Shape
    CHEEKS_DEPTH        = 13709, -- Cheeks > Cheek Depth

    -- Advanced mode
    SHOULDERS_WIDTH     = 50039, -- Back > Shoulder Frame
    SHOULDERS_DEPTH     = 7010,  -- Back > Shoulder Frame
    SHOULDERS_HEIGHT    = 15833, -- Back > Shoulder Height
    LATS                = 18046, -- Back > Upper Back
    TRAPS               = 33485, -- Back > Upper Back
    UPPER_ARMS          = 46032, -- Limbs > Arm Thickness
    FOREARMS            = 8420,  -- Limbs > Arm Thickness
    UPPER_LEGS          = 64834, -- Limbs > Leg Thickness
    LOWER_LEGS          = 42067, -- Limbs > Leg Thickness
    MOUTHCRN_L_WIDTH    = 57350, -- Mouth > Corner Width
    MOUTHCRN_R_WIDTH    = 60292, -- Mouth > Corner Width
    MOUTH_H_POS         = 31427, -- Mouth > Mouth Horizontal Shift
    MOUTHCRN_L_DEPTH    = 40950, -- Mouth > Corner Depth
    MOUTHCRN_R_DEPTH    = 49299, -- Mouth > Corner Depth
    MOUTHCRN_L_HEIGHT   = 46661, -- Mouth > Corner Height
    MOUTHCRN_R_HEIGHT   = 55718, -- Mouth > Corner Height
    MOUTHCRN_L_LIP_DIST = 22344, -- Mouth > Corner Separation
    MOUTHCRN_R_LIP_DIST = 9423,  -- Mouth > Corner Separation
    CHEST_WIDTH         = 41478, -- Torso > Chest Size
    CHEST_DEPTH         = 27779, -- Torso > Chest Size
    CHEST_SAG           = 46240, -- Torso > Chest Sag
    BELLY_WIDTH         = 50460, -- Torso > Midsection
    BELLY_DEPTH         = 49787, -- Torso > Midsection
    GLUTES              = 8991,  -- Torso > Glute Volume
    FACE_WIDTH          = 34006, -- Face > Shape
    CHEEKS_FULLNESS     = 41396, -- Face > Shape
    EYELID_L_POS        = 52902, -- Face > Eyelid Height
    EYELID_R_POS        = 22421, -- Face > Eyelid Height
    NECK_WIDTH          = 36277, -- Neck > Neck Proportions
    NECK_DEPTH          = 60890, -- Neck > Neck Proportions
}

---@type PED_EXPRESSIONS | EnumRegistry
PED_EXPRESSION = Enums.CreateRegistry(PED_EXPRESSIONS)

PED_EXPRESSION:AddAttribute("Hash", {
    [PED_EXPRESSIONS.BROW_WIDTH]          = `PEDEXPRESS_BROW_WIDTH`,
    [PED_EXPRESSIONS.BROW_HEIGHT]         = `PEDEXPRESS_BROW_HEIGHT`,
    [PED_EXPRESSIONS.BROW_DEPTH]          = `PEDEXPRESS_BROW_DEPTH`,
    [PED_EXPRESSIONS.EYE_WIDTH]           = `PEDEXPRESS_EYE_WIDTH`,
    [PED_EXPRESSIONS.EYE_HEIGHT]          = `PEDEXPRESS_EYE_HEIGHT`,
    [PED_EXPRESSIONS.EYE_ANGLE]           = `PEDEXPRESS_EYE_ANGLE`,
    [PED_EXPRESSIONS.EYE_DEPTH]           = `PEDEXPRESS_EYE_DEPTH`,
    [PED_EXPRESSIONS.EYE_H_POS]           = `PEDEXPRESS_EYE_H_POS`,
    [PED_EXPRESSIONS.EYE_V_POS]           = `PEDEXPRESS_EYE_V_POS`,
    [PED_EXPRESSIONS.NOSE_WIDTH]          = `PEDEXPRESS_NOSE_WIDTH`,
    [PED_EXPRESSIONS.NOSE_HEIGHT]         = `PEDEXPRESS_NOSE_HEIGHT`,
    [PED_EXPRESSIONS.NOSE_BREAK]          = `PEDEXPRESS_NOSE_BREAK`,
    [PED_EXPRESSIONS.NOSE_LENGTH]         = `PEDEXPRESS_NOSE_LENGTH`,
    [PED_EXPRESSIONS.NOSTRIL_WIDTH]       = `PEDEXPRESS_NOSTRIL_WIDTH`,
    [PED_EXPRESSIONS.NOSE_TILT]           = `PEDEXPRESS_NOSE_TILT`,
    [PED_EXPRESSIONS.MOUTH_WIDTH]         = `PEDEXPRESS_MOUTH_WIDTH`,
    [PED_EXPRESSIONS.MOUTH_DEPTH]         = `PEDEXPRESS_MOUTH_DEPTH`,
    [PED_EXPRESSIONS.MOUTH_V_POS]         = `PEDEXPRESS_MOUTH_V_POS`,
    [PED_EXPRESSIONS.UPPER_LIP_WIDTH]     = `PEDEXPRESS_UPPER_LIP_WIDTH`,
    [PED_EXPRESSIONS.UPPER_LIP_THICKNESS] = `PEDEXPRESS_UPPER_LIP_THICKNESS`,
    [PED_EXPRESSIONS.LOWER_LIP_WIDTH]     = `PEDEXPRESS_LOWER_LIP_WIDTH`,
    [PED_EXPRESSIONS.LOWER_LIP_THICKNESS] = `PEDEXPRESS_LOWER_LIP_THICKNESS`,
    [PED_EXPRESSIONS.UPPER_LIPDEPTH]      = `PEDEXPRESS_UPPER_LIPDEPTH`,
    [PED_EXPRESSIONS.LOWER_LIP_DEPTH]     = `PEDEXPRESS_LOWER_LIP_DEPTH`,
    [PED_EXPRESSIONS.JAW_WIDTH]           = `PEDEXPRESS_JAW_WIDTH`,
    [PED_EXPRESSIONS.JAW_HEIGHT]          = `PEDEXPRESS_JAW_HEIGHT`,
    [PED_EXPRESSIONS.JAW_DEPTH]           = `PEDEXPRESS_JAW_DEPTH`,
    [PED_EXPRESSIONS.CHIN_WIDTH]          = `PEDEXPRESS_CHIN_WIDTH`,
    [PED_EXPRESSIONS.CHIN_TILT]           = `PEDEXPRESS_CHIN_TILT`,
    [PED_EXPRESSIONS.CHIN_DEPTH]          = `PEDEXPRESS_CHIN_DEPTH`,
    [PED_EXPRESSIONS.EAR_ROTATION]        = `PEDEXPRESS_EAR_ROTATION`,
    [PED_EXPRESSIONS.EAR_LENGTH]          = `PEDEXPRESS_EAR_LENGTH`,
    [PED_EXPRESSIONS.EAR_SIZE]            = `PEDEXPRESS_EAR_SIZE`,
    [PED_EXPRESSIONS.EAR_LOBE]            = `PEDEXPRESS_EAR_LOBE`,
    [PED_EXPRESSIONS.CHEEKS_WIDTH]        = `PEDEXPRESS_CHEEKS_WIDTH`,
    [PED_EXPRESSIONS.CHEEKS_HEIGHT]       = `PEDEXPRESS_CHEEKS_HEIGHT`,
    [PED_EXPRESSIONS.CHEEKS_DEPTH]        = `PEDEXPRESS_CHEEKS_DEPTH`,

    -- Advanced mode
    [PED_EXPRESSIONS.SHOULDERS_WIDTH]     = `PEDEXPRESS_SHOULDERS_WIDTH`,
    [PED_EXPRESSIONS.SHOULDERS_DEPTH]     = `PEDEXPRESS_SHOULDERS_DEPTH`,
    [PED_EXPRESSIONS.SHOULDERS_HEIGHT]    = `PEDEXPRESS_SHOULDERS_HEIGHT`,
    [PED_EXPRESSIONS.CHEST_WIDTH]         = `PEDEXPRESS_CHEST_WIDTH`,
    [PED_EXPRESSIONS.CHEST_DEPTH]         = `PEDEXPRESS_CHEST_DEPTH`,
    [PED_EXPRESSIONS.BELLY_WIDTH]         = `PEDEXPRESS_BELLY_WIDTH`,
    [PED_EXPRESSIONS.BELLY_DEPTH]         = `PEDEXPRESS_BELLY_DEPTH`,
    [PED_EXPRESSIONS.LATS]                = `PEDEXPRESS_LATS`,
    [PED_EXPRESSIONS.TRAPS]               = `PEDEXPRESS_TRAPS`,
    [PED_EXPRESSIONS.UPPER_ARMS]          = `PEDEXPRESS_UPPER_ARMS`,
    [PED_EXPRESSIONS.FOREARMS]            = `PEDEXPRESS_FOREARMS`,
    [PED_EXPRESSIONS.UPPER_LEGS]          = `PEDEXPRESS_UPPER_LEGS`,
    [PED_EXPRESSIONS.LOWER_LEGS]          = `PEDEXPRESS_LOWER_LEGS`,
    [PED_EXPRESSIONS.NECK_WIDTH]          = `PEDEXPRESS_NECK_WIDTH`,
    [PED_EXPRESSIONS.NECK_DEPTH]          = `PEDEXPRESS_NECK_DEPTH`,
    [PED_EXPRESSIONS.MOUTHCRN_L_WIDTH]    = `PEDEXPRESS_MOUTHCRN_L_WIDTH`,
    [PED_EXPRESSIONS.MOUTHCRN_R_WIDTH]    = `PEDEXPRESS_MOUTHCRN_R_WIDTH`,
    [PED_EXPRESSIONS.MOUTH_H_POS]         = `PEDEXPRESS_MOUTH_H_POS`,
    [PED_EXPRESSIONS.MOUTHCRN_L_DEPTH]    = `PEDEXPRESS_MOUTHCRN_L_DEPTH`,
    [PED_EXPRESSIONS.MOUTHCRN_R_DEPTH]    = `PEDEXPRESS_MOUTHCRN_R_DEPTH`,
    [PED_EXPRESSIONS.MOUTHCRN_L_HEIGHT]   = `PEDEXPRESS_MOUTHCRN_L_HEIGHT`,
    [PED_EXPRESSIONS.MOUTHCRN_R_HEIGHT]   = `PEDEXPRESS_MOUTHCRN_R_HEIGHT`,
    [PED_EXPRESSIONS.MOUTHCRN_L_LIP_DIST] = `PEDEXPRESS_MOUTHCRN_L_LIP_DIST`,
    [PED_EXPRESSIONS.MOUTHCRN_R_LIP_DIST] = `PEDEXPRESS_MOUTHCRN_R_LIP_DIST`,
    [PED_EXPRESSIONS.FACE_WIDTH]          = `PEDEXPRESS_FACE_WIDTH`,
    [PED_EXPRESSIONS.CHEEKS_FULLNESS]     = `PEDEXPRESS_CHEEKS_FULLNESS`,
    [PED_EXPRESSIONS.GLUTES]              = `PEDEXPRESS_GLUTES`,
    [PED_EXPRESSIONS.EYELID_L_POS]        = `PEDEXPRESS_EYELID_L_POS`,
    [PED_EXPRESSIONS.EYELID_R_POS]        = `PEDEXPRESS_EYELID_R_POS`,
    [PED_EXPRESSIONS.CHEST_SAG]           = `PEDEXPRESS_CHEST_SAG`,
})

PED_EXPRESSION:AddAttribute("Reversed", {
    [PED_EXPRESSIONS.BROW_HEIGHT]         = true,
    [PED_EXPRESSIONS.EAR_SIZE]            = true,
    [PED_EXPRESSIONS.CHEEKS_HEIGHT]       = true,
    [PED_EXPRESSIONS.JAW_HEIGHT]          = true,
    [PED_EXPRESSIONS.CHIN_TILT]           = true,
    [PED_EXPRESSIONS.EYE_HEIGHT]          = true,
    [PED_EXPRESSIONS.EYE_V_POS]           = true,
    [PED_EXPRESSIONS.NOSE_LENGTH]         = true,
    [PED_EXPRESSIONS.NOSE_TILT]           = true,
    [PED_EXPRESSIONS.MOUTH_DEPTH]         = true,
    [PED_EXPRESSIONS.UPPER_LIP_THICKNESS] = true,
    [PED_EXPRESSIONS.CHEST_SAG]           = true,
})

PED_EXPRESSION:AddModeAttribute("Randomized", {
    [CREATOR_MODE.DEFAULT] = {
        -- Default mode only randomizes the presets
    },
    [CREATOR_MODE.ADVANCED] = {
        [PED_EXPRESSIONS.SHOULDERS_WIDTH]  = true,
        [PED_EXPRESSIONS.SHOULDERS_DEPTH]  = true,
        [PED_EXPRESSIONS.SHOULDERS_HEIGHT] = true,
        [PED_EXPRESSIONS.CHEST_WIDTH]      = true,
        [PED_EXPRESSIONS.CHEST_DEPTH]      = true,
        [PED_EXPRESSIONS.BELLY_WIDTH]      = true,
        [PED_EXPRESSIONS.BELLY_DEPTH]      = true,
        [PED_EXPRESSIONS.LATS]             = true,
        [PED_EXPRESSIONS.TRAPS]            = true,
        [PED_EXPRESSIONS.UPPER_ARMS]       = true,
        [PED_EXPRESSIONS.FOREARMS]         = true,
        [PED_EXPRESSIONS.UPPER_LEGS]       = true,
        [PED_EXPRESSIONS.LOWER_LEGS]       = true,
        [PED_EXPRESSIONS.NECK_WIDTH]       = true,
        [PED_EXPRESSIONS.NECK_DEPTH]       = true,
        [PED_EXPRESSIONS.FACE_WIDTH]       = true,
        [PED_EXPRESSIONS.CHEEKS_FULLNESS]  = true,
        [PED_EXPRESSIONS.GLUTES]           = true,
        [PED_EXPRESSIONS.CHEST_SAG]        = true,
    }
})
