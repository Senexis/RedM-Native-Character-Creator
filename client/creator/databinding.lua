CreatorDatabinding = {
    initialized = false,
    datastore = {},
}

-- Initialize main creator UI databinding
function CreatorDatabinding:Initialize()
    local id = DATABINDING_ID
    self.initialized = false

    self.datastore[id.ROOT] = DatabindingAddDataContainerFromPath("", "CharacterCreationRoot")
    self.datastore[id.ROOT__HEAD] = DatabindingAddDataContainer(self.datastore[id.ROOT], "head_main")
    self.datastore[id.ROOT__FACE] = DatabindingAddDataContainer(self.datastore[id.ROOT], "face_main")
    self.datastore[id.ROOT__FACE__FACIAL_HAIR_HIDDEN] = DatabindingAddDataBool(self.datastore[id.ROOT__FACE], "facial_hair_hidden", false)
    self.datastore[id.ROOT__FACE__FACIAL_HAIR_WORN] = DatabindingAddDataBool(self.datastore[id.ROOT__FACE], "facial_hair_worn", false)
    self.datastore[id.ROOT__HAIR] = DatabindingAddDataContainer(self.datastore[id.ROOT], "hair_main")
    self.datastore[id.ROOT__BEARD] = DatabindingAddDataContainer(self.datastore[id.ROOT], "beard_main")
    self.datastore[id.ROOT__BEARD__VISIBLE] = DatabindingAddDataBool(self.datastore[id.ROOT__BEARD], "visible", false)
    self.datastore[id.ROOT__HEADER] = DatabindingAddDataContainer(self.datastore[id.ROOT], "header")
    self.datastore[id.ROOT__HEADER__TITLE] = DatabindingAddDataHash(self.datastore[id.ROOT__HEADER], "label", 0x512BEE55)
    self.datastore[id.ROOT__HEADER__SUBTITLE] = DatabindingAddDataHash(self.datastore[id.ROOT__HEADER], "sublabel", 0x5DD86BB9)
    self.datastore[id.ROOT__FOOTER] = DatabindingAddDataContainer(self.datastore[id.ROOT], "footer")
    self.datastore[id.ROOT__FOOTER__LABEL] = DatabindingAddDataString(self.datastore[id.ROOT__FOOTER], "label", "")
    self.datastore[id.ROOT__FOOTER__COLOR] = DatabindingAddDataHash(self.datastore[id.ROOT__FOOTER], "color", `COLOR_WHITE`)
    self.datastore[id.ROOT__DETAILS_IMAGE] = DatabindingAddDataContainer(self.datastore[id.ROOT], "DetailsImage")
    self.datastore[id.ROOT__DETAILS_IMAGE__ENABLED] = DatabindingAddDataBool(self.datastore[id.ROOT__DETAILS_IMAGE], "Enabled", true)
    self.datastore[id.ROOT__DETAILS_IMAGE__TEXTURE] = DatabindingAddDataHash(self.datastore[id.ROOT__DETAILS_IMAGE], "Texture", 0)
    self.datastore[id.ROOT__HAIR_MATCH] = DatabindingAddDataContainer(self.datastore[id.ROOT], "hair_colors_match")
    self.datastore[id.ROOT__HAIR_MATCH__ENABLED] = DatabindingAddDataBool(self.datastore[id.ROOT__HAIR_MATCH], "enabled", false)
    self.datastore[id.ROOT__HAIR_MATCH__VALUE] = DatabindingAddDataBool(self.datastore[id.ROOT__HAIR_MATCH], "value", false)
    self.datastore[id.ROOT__ZOOM_ENABLED] = DatabindingAddDataBool(self.datastore[id.ROOT], "zoom_enabled", true)
    self.datastore[id.ROOT__COLOR_SWATCH] = DatabindingAddDataContainer(self.datastore[id.ROOT], "appearance_page_color_swatch")
    self.datastore[id.ROOT__COLOR_SWATCH__VISIBLE] = DatabindingAddDataBool(self.datastore[id.ROOT__COLOR_SWATCH], "Visible", false)
    self.datastore[id.ROOT__COLOR_SWATCH__TITLE] = DatabindingAddDataString(self.datastore[id.ROOT__COLOR_SWATCH], "Title", "")
    self.datastore[id.ROOT__COLOR_SWATCH__ARRAY] = DatabindingAddUiItemList(self.datastore[id.ROOT__COLOR_SWATCH], "ItemList")
    self.datastore[id.ROOT__COLOR_SWATCH__FOCUSED_INDEX] = DatabindingAddDataInt(self.datastore[id.ROOT__COLOR_SWATCH], "FocusedIndex", 0)
    self.datastore[id.ROOT__COLOR_SWATCH__ITEMS_CONTAINER] = DatabindingAddDataContainer(self.datastore[id.ROOT__COLOR_SWATCH], "Items")
    self.datastore[id.ROOT__GRID] = DatabindingAddDataContainer(self.datastore[id.ROOT], "grid")
    self.datastore[id.ROOT__GRID__X_VISIBLE] = DatabindingAddDataBool(self.datastore[id.ROOT__GRID], "grid_x_visible", false)
    self.datastore[id.ROOT__GRID__XY_VISIBLE] = DatabindingAddDataBool(self.datastore[id.ROOT__GRID], "grid_xy_visible", false)
    self.datastore[id.ROOT__GRID__X_VALUE] = DatabindingAddDataFloat(self.datastore[id.ROOT__GRID], "XAxis", 0)
    self.datastore[id.ROOT__GRID__Y_VALUE] = DatabindingAddDataFloat(self.datastore[id.ROOT__GRID], "YAxis", 0)
    self.datastore[id.ROOT__GRID__LEFT_LABEL] = DatabindingAddDataString(self.datastore[id.ROOT__GRID], "leftLabel", "")
    self.datastore[id.ROOT__GRID__RIGHT_LABEL] = DatabindingAddDataString(self.datastore[id.ROOT__GRID], "rightLabel", "")
    self.datastore[id.ROOT__GRID__TOP_LABEL] = DatabindingAddDataString(self.datastore[id.ROOT__GRID], "topLabel", "")
    self.datastore[id.ROOT__GRID__BOTTOM_LABEL] = DatabindingAddDataString(self.datastore[id.ROOT__GRID], "bottomLabel", "")
    self.datastore[id.MAIN__NAME] = DatabindingAddDataContainer(self.datastore[id.ROOT], "save_game_name")
    self.datastore[id.MAIN__NAME__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAIN__NAME], "enabled", false)
    self.datastore[id.MAIN__NAME__VALUE] = DatabindingAddDataString(self.datastore[id.MAIN__NAME], "value", "")
    self.datastore[id.MAIN__APPEARANCE] = DatabindingAddDataContainer(self.datastore[id.ROOT], "appearance_option")
    self.datastore[id.MAIN__APPEARANCE__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAIN__APPEARANCE], "enabled", true)
    self.datastore[id.MAIN__WHISTLE] = DatabindingAddDataContainer(self.datastore[id.ROOT], "whistle_option")
    self.datastore[id.MAIN__WHISTLE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MAIN__WHISTLE], "visible", CreatorConfig.SkipWhistle ~= true)
    self.datastore[id.MAIN__WHISTLE__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAIN__WHISTLE], "enabled", CreatorConfig.SkipWhistle ~= true)
    self.datastore[id.MAIN__ATTRIBUTES] = DatabindingAddDataContainer(self.datastore[id.ROOT], "attributes_option")
    self.datastore[id.MAIN__ATTRIBUTES__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MAIN__ATTRIBUTES], "visible", CreatorConfig.SkipAttributePoints ~= true)
    self.datastore[id.MAIN__ATTRIBUTES__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAIN__ATTRIBUTES], "enabled", CreatorConfig.SkipAttributePoints ~= true)
    self.datastore[id.MAIN__CONFIRM] = DatabindingAddDataContainer(self.datastore[id.ROOT], "confirm_option")
    self.datastore[id.MAIN__CONFIRM__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAIN__CONFIRM], "enabled", true)
    self.datastore[id.APPEARANCE__RANDOMIZE] = DatabindingAddDataContainer(self.datastore[id.ROOT], "randomize")
    self.datastore[id.APPEARANCE__RANDOMIZE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__RANDOMIZE], "visible", true)
    self.datastore[id.APPEARANCE__HERITAGE] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "heritage")
    self.datastore[id.APPEARANCE__HERITAGE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__HERITAGE], "visible", true)
    self.datastore[id.APPEARANCE__HERITAGE__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__HERITAGE], "enabled", true)
    self.datastore[id.APPEARANCE__HERITAGE__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__HERITAGE], "value", 0)
    self.datastore[id.APPEARANCE__HERITAGE__ARRAY] = DatabindingAddHashArray(self.datastore[id.APPEARANCE__HERITAGE], "options")
    self.datastore[id.APPEARANCE__SKIN_TONE] = DatabindingAddDataContainer(self.datastore[id.ROOT], "skin_tone")
    self.datastore[id.APPEARANCE__SKIN_TONE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__SKIN_TONE], "visible", true)
    self.datastore[id.APPEARANCE__SKIN_TONE__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__SKIN_TONE], "enabled", true)
    self.datastore[id.APPEARANCE__SKIN_TONE__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__SKIN_TONE], "value", 0)
    self.datastore[id.APPEARANCE__SKIN_TONE__ARRAY] = Citizen.InvokeNative(0xD48993A61938C64D, self.datastore[id.APPEARANCE__SKIN_TONE], "options")
    self.datastore[id.APPEARANCE__SKIN_TONE__TXD] = DatabindingAddDataString(self.datastore[id.APPEARANCE__SKIN_TONE], "texture_dictionary", "")
    self.datastore[id.APPEARANCE__SKIN_TONE__TEXTURE] = DatabindingAddDataString(self.datastore[id.APPEARANCE__SKIN_TONE], "texture", "")
    self.datastore[id.APPEARANCE__SKIN_TONE__COLOR] = DatabindingAddDataHash(self.datastore[id.APPEARANCE__SKIN_TONE], "color", `COLOR_WHITE`)
    self.datastore[id.APPEARANCE__AGE] = DatabindingAddDataContainer(self.datastore[id.ROOT], "age_option")
    self.datastore[id.APPEARANCE__AGE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__AGE], "visible", true)
    self.datastore[id.APPEARANCE__AGE__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__AGE], "enabled", true)
    self.datastore[id.APPEARANCE__AGE__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__AGE], "value", CreatorConfig.MinAge)
    self.datastore[id.APPEARANCE__AGE__MINIMUM] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__AGE], "minimum", CreatorConfig.MinAge)
    self.datastore[id.APPEARANCE__AGE__MAXIMUM] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__AGE], "maximum", CreatorConfig.MaxAge)
    self.datastore[id.APPEARANCE__BODY_BUILD] = DatabindingAddDataContainer(self.datastore[id.ROOT], "body_build")
    self.datastore[id.APPEARANCE__BODY_BUILD__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__BODY_BUILD], "visible", true)
    self.datastore[id.APPEARANCE__BODY_BUILD__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__BODY_BUILD], "enabled", true)
    self.datastore[id.APPEARANCE__BODY_BUILD__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__BODY_BUILD], "value", 0)
    self.datastore[id.APPEARANCE__BODY_BUILD__ARRAY] = DatabindingAddHashArray(self.datastore[id.APPEARANCE__BODY_BUILD], "options")
    self.datastore[id.APPEARANCE__EYE_COLOR] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "eye_color")
    self.datastore[id.APPEARANCE__EYE_COLOR__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__EYE_COLOR], "visible", true)
    self.datastore[id.APPEARANCE__EYE_COLOR__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__EYE_COLOR], "enabled", true)
    self.datastore[id.APPEARANCE__EYE_COLOR__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__EYE_COLOR], "value", 0)
    self.datastore[id.APPEARANCE__EYE_COLOR__ARRAY] = Citizen.InvokeNative(0xD48993A61938C64D, self.datastore[id.APPEARANCE__EYE_COLOR], "options")
    self.datastore[id.APPEARANCE__EYE_COLOR__TXD] = DatabindingAddDataString(self.datastore[id.APPEARANCE__EYE_COLOR], "texture_dictionary", "")
    self.datastore[id.APPEARANCE__EYE_COLOR__TEXTURE] = DatabindingAddDataString(self.datastore[id.APPEARANCE__EYE_COLOR], "texture", "")
    self.datastore[id.APPEARANCE__EYE_COLOR__COLOR] = DatabindingAddDataHash(self.datastore[id.APPEARANCE__EYE_COLOR], "color", `COLOR_WHITE`)
    self.datastore[id.APPEARANCE__EYEBROWS] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "eyebrows")
    self.datastore[id.APPEARANCE__EYEBROWS__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__EYEBROWS], "visible", true)
    self.datastore[id.APPEARANCE__EYEBROWS__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__EYEBROWS], "enabled", true)
    self.datastore[id.APPEARANCE__EYEBROWS__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__EYEBROWS], "value", 0)
    self.datastore[id.APPEARANCE__EYEBROWS__ARRAY] = DatabindingAddHashArray(self.datastore[id.APPEARANCE__EYEBROWS], "options")
    self.datastore[id.APPEARANCE__EYES_PRESET] = DatabindingAddDataContainer(self.datastore[id.ROOT], "eyes_and_brows")
    self.datastore[id.APPEARANCE__EYES_PRESET__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__EYES_PRESET], "visible", true)
    self.datastore[id.APPEARANCE__EYES_PRESET__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__EYES_PRESET], "enabled", true)
    self.datastore[id.APPEARANCE__EYES_PRESET__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__EYES_PRESET], "value", 0)
    self.datastore[id.APPEARANCE__EYES_PRESET__ARRAY] = DatabindingAddHashArray(self.datastore[id.APPEARANCE__EYES_PRESET], "options")
    self.datastore[id.APPEARANCE__EYES_PRESET__CUSTOMIZABLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__EYES_PRESET], "customizable", true)
    self.datastore[id.APPEARANCE__NOSE_PRESET] = DatabindingAddDataContainer(self.datastore[id.ROOT], "nose")
    self.datastore[id.APPEARANCE__NOSE_PRESET__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__NOSE_PRESET], "visible", true)
    self.datastore[id.APPEARANCE__NOSE_PRESET__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__NOSE_PRESET], "enabled", true)
    self.datastore[id.APPEARANCE__NOSE_PRESET__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__NOSE_PRESET], "value", 0)
    self.datastore[id.APPEARANCE__NOSE_PRESET__ARRAY] = DatabindingAddHashArray(self.datastore[id.APPEARANCE__NOSE_PRESET], "options")
    self.datastore[id.APPEARANCE__NOSE_PRESET__CUSTOMIZABLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__NOSE_PRESET], "customizable", true)
    self.datastore[id.APPEARANCE__MOUTH_PRESET] = DatabindingAddDataContainer(self.datastore[id.ROOT], "mouth_and_lips")
    self.datastore[id.APPEARANCE__MOUTH_PRESET__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__MOUTH_PRESET], "visible", true)
    self.datastore[id.APPEARANCE__MOUTH_PRESET__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__MOUTH_PRESET], "enabled", true)
    self.datastore[id.APPEARANCE__MOUTH_PRESET__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__MOUTH_PRESET], "value", 0)
    self.datastore[id.APPEARANCE__MOUTH_PRESET__ARRAY] = DatabindingAddHashArray(self.datastore[id.APPEARANCE__MOUTH_PRESET], "options")
    self.datastore[id.APPEARANCE__MOUTH_PRESET__CUSTOMIZABLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__MOUTH_PRESET], "customizable", true)
    self.datastore[id.APPEARANCE__JAW_PRESET] = DatabindingAddDataContainer(self.datastore[id.ROOT], "jaw_and_chin")
    self.datastore[id.APPEARANCE__JAW_PRESET__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__JAW_PRESET], "visible", true)
    self.datastore[id.APPEARANCE__JAW_PRESET__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__JAW_PRESET], "enabled", true)
    self.datastore[id.APPEARANCE__JAW_PRESET__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__JAW_PRESET], "value", 0)
    self.datastore[id.APPEARANCE__JAW_PRESET__ARRAY] = DatabindingAddHashArray(self.datastore[id.APPEARANCE__JAW_PRESET], "options")
    self.datastore[id.APPEARANCE__JAW_PRESET__CUSTOMIZABLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__JAW_PRESET], "customizable", true)
    self.datastore[id.APPEARANCE__EARS_PRESET] = DatabindingAddDataContainer(self.datastore[id.ROOT], "ears")
    self.datastore[id.APPEARANCE__EARS_PRESET__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__EARS_PRESET], "visible", true)
    self.datastore[id.APPEARANCE__EARS_PRESET__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__EARS_PRESET], "enabled", true)
    self.datastore[id.APPEARANCE__EARS_PRESET__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__EARS_PRESET], "value", 0)
    self.datastore[id.APPEARANCE__EARS_PRESET__ARRAY] = DatabindingAddHashArray(self.datastore[id.APPEARANCE__EARS_PRESET], "options")
    self.datastore[id.APPEARANCE__EARS_PRESET__CUSTOMIZABLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__EARS_PRESET], "customizable", true)
    self.datastore[id.APPEARANCE__CHEEKS_PRESET] = DatabindingAddDataContainer(self.datastore[id.ROOT], "cheeks")
    self.datastore[id.APPEARANCE__CHEEKS_PRESET__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__CHEEKS_PRESET], "visible", true)
    self.datastore[id.APPEARANCE__CHEEKS_PRESET__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__CHEEKS_PRESET], "enabled", true)
    self.datastore[id.APPEARANCE__CHEEKS_PRESET__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__CHEEKS_PRESET], "value", 0)
    self.datastore[id.APPEARANCE__CHEEKS_PRESET__ARRAY] = DatabindingAddHashArray(self.datastore[id.APPEARANCE__CHEEKS_PRESET], "options")
    self.datastore[id.APPEARANCE__CHEEKS_PRESET__CUSTOMIZABLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__CHEEKS_PRESET], "customizable", true)
    self.datastore[id.APPEARANCE__TEETH] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "teeth")
    self.datastore[id.APPEARANCE__TEETH__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__TEETH], "visible", true)
    self.datastore[id.APPEARANCE__TEETH__ENABLED] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__TEETH], "enabled", true)
    self.datastore[id.APPEARANCE__TEETH__VALUE] = DatabindingAddDataInt(self.datastore[id.APPEARANCE__TEETH], "value", 0)
    self.datastore[id.APPEARANCE__TEETH__ARRAY] = DatabindingAddHashArray(self.datastore[id.APPEARANCE__TEETH], "options")
    self.datastore[id.APPEARANCE__HAIR] = self.datastore[id.ROOT__HAIR] -- Shares datastore with hair_main
    self.datastore[id.APPEARANCE__HAIR__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__HAIR], "visible", true)
    self.datastore[id.APPEARANCE__HAIR__VALUE] = DatabindingAddDataHash(self.datastore[id.APPEARANCE__HAIR], "SelectedOption", 0)
    self.datastore[id.APPEARANCE__LIFESTYLE] = DatabindingAddDataContainer(self.datastore[id.ROOT], "lifestyle")
    self.datastore[id.APPEARANCE__LIFESTYLE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__LIFESTYLE], "visible", true)
    self.datastore[id.APPEARANCE__LIFESTYLE__VALUE] = DatabindingAddDataHash(self.datastore[id.ROOT__HEAD], "SelectedOption", 0) -- ROOT__HEAD intentional
    self.datastore[id.APPEARANCE__MAKEUP] = DatabindingAddDataContainer(self.datastore[id.ROOT], "makeup")
    self.datastore[id.APPEARANCE__MAKEUP__VISIBLE] = DatabindingAddDataBool(self.datastore[id.APPEARANCE__MAKEUP], "visible", true)
    self.datastore[id.APPEARANCE__MAKEUP__VALUE] = DatabindingAddDataHash(self.datastore[id.APPEARANCE__MAKEUP], "SelectedOption", 0)
    self.datastore[id.EYES__BROW_SHAPE] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "brow_shape")
    self.datastore[id.EYES__BROW_SHAPE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.EYES__BROW_SHAPE], "visible", true)
    self.datastore[id.EYES__BROW_SHAPE__ENABLED] = DatabindingAddDataBool(self.datastore[id.EYES__BROW_SHAPE], "enabled", true)
    self.datastore[id.EYES__BROW_SHAPE__VALUE] = DatabindingAddDataInt(self.datastore[id.EYES__BROW_SHAPE], "value", 0)
    self.datastore[id.EYES__BROW_SHAPE__ARRAY] = DatabindingAddHashArray(self.datastore[id.EYES__BROW_SHAPE], "options")
    self.datastore[id.EYES__BROW_SHAPE__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.EYES__BROW_SHAPE], "fine_tune_enabled", true)
    self.datastore[id.EYES__BROW_DEPTH] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "pedexpress_brow_depth")
    self.datastore[id.EYES__BROW_DEPTH__VISIBLE] = DatabindingAddDataBool(self.datastore[id.EYES__BROW_DEPTH], "visible", true)
    self.datastore[id.EYES__BROW_DEPTH__ENABLED] = DatabindingAddDataBool(self.datastore[id.EYES__BROW_DEPTH], "enabled", true)
    self.datastore[id.EYES__BROW_DEPTH__VALUE] = DatabindingAddDataInt(self.datastore[id.EYES__BROW_DEPTH], "value", 0)
    self.datastore[id.EYES__BROW_DEPTH__ARRAY] = DatabindingAddHashArray(self.datastore[id.EYES__BROW_DEPTH], "options")
    self.datastore[id.EYES__BROW_DEPTH__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.EYES__BROW_DEPTH], "fine_tune_enabled", true)
    self.datastore[id.EYES__EYE_SIZE] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "eye_size")
    self.datastore[id.EYES__EYE_SIZE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.EYES__EYE_SIZE], "visible", true)
    self.datastore[id.EYES__EYE_SIZE__ENABLED] = DatabindingAddDataBool(self.datastore[id.EYES__EYE_SIZE], "enabled", true)
    self.datastore[id.EYES__EYE_SIZE__VALUE] = DatabindingAddDataInt(self.datastore[id.EYES__EYE_SIZE], "value", 0)
    self.datastore[id.EYES__EYE_SIZE__ARRAY] = DatabindingAddHashArray(self.datastore[id.EYES__EYE_SIZE], "options")
    self.datastore[id.EYES__EYE_SIZE__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.EYES__EYE_SIZE], "fine_tune_enabled", true)
    self.datastore[id.EYES__EYE_DEPTH] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "eye_depth")
    self.datastore[id.EYES__EYE_DEPTH__VISIBLE] = DatabindingAddDataBool(self.datastore[id.EYES__EYE_DEPTH], "visible", true)
    self.datastore[id.EYES__EYE_DEPTH__ENABLED] = DatabindingAddDataBool(self.datastore[id.EYES__EYE_DEPTH], "enabled", true)
    self.datastore[id.EYES__EYE_DEPTH__VALUE] = DatabindingAddDataInt(self.datastore[id.EYES__EYE_DEPTH], "value", 0)
    self.datastore[id.EYES__EYE_DEPTH__ARRAY] = DatabindingAddHashArray(self.datastore[id.EYES__EYE_DEPTH], "options")
    self.datastore[id.EYES__EYE_DEPTH__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.EYES__EYE_DEPTH], "fine_tune_enabled", true)
    self.datastore[id.EYES__EYE_POSITION] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "eye_position")
    self.datastore[id.EYES__EYE_POSITION__VISIBLE] = DatabindingAddDataBool(self.datastore[id.EYES__EYE_POSITION], "visible", true)
    self.datastore[id.EYES__EYE_POSITION__ENABLED] = DatabindingAddDataBool(self.datastore[id.EYES__EYE_POSITION], "enabled", true)
    self.datastore[id.EYES__EYE_POSITION__VALUE] = DatabindingAddDataInt(self.datastore[id.EYES__EYE_POSITION], "value", 0)
    self.datastore[id.EYES__EYE_POSITION__ARRAY] = DatabindingAddHashArray(self.datastore[id.EYES__EYE_POSITION], "options")
    self.datastore[id.EYES__EYE_POSITION__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.EYES__EYE_POSITION], "fine_tune_enabled", true)
    self.datastore[id.NOSE__NOSE_SIZE] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "nose_option")
    self.datastore[id.NOSE__NOSE_SIZE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.NOSE__NOSE_SIZE], "visible", true)
    self.datastore[id.NOSE__NOSE_SIZE__ENABLED] = DatabindingAddDataBool(self.datastore[id.NOSE__NOSE_SIZE], "enabled", true)
    self.datastore[id.NOSE__NOSE_SIZE__VALUE] = DatabindingAddDataInt(self.datastore[id.NOSE__NOSE_SIZE], "value", 0)
    self.datastore[id.NOSE__NOSE_SIZE__ARRAY] = DatabindingAddHashArray(self.datastore[id.NOSE__NOSE_SIZE], "options")
    self.datastore[id.NOSE__NOSE_SIZE__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.NOSE__NOSE_SIZE], "fine_tune_enabled", true)
    self.datastore[id.NOSE__NOSE_SHAPE] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "nose_shape")
    self.datastore[id.NOSE__NOSE_SHAPE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.NOSE__NOSE_SHAPE], "visible", true)
    self.datastore[id.NOSE__NOSE_SHAPE__ENABLED] = DatabindingAddDataBool(self.datastore[id.NOSE__NOSE_SHAPE], "enabled", true)
    self.datastore[id.NOSE__NOSE_SHAPE__VALUE] = DatabindingAddDataInt(self.datastore[id.NOSE__NOSE_SHAPE], "value", 0)
    self.datastore[id.NOSE__NOSE_SHAPE__ARRAY] = DatabindingAddHashArray(self.datastore[id.NOSE__NOSE_SHAPE], "options")
    self.datastore[id.NOSE__NOSE_SHAPE__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.NOSE__NOSE_SHAPE], "fine_tune_enabled", true)
    self.datastore[id.NOSE__NOSE_TIP] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "nose_tip")
    self.datastore[id.NOSE__NOSE_TIP__VISIBLE] = DatabindingAddDataBool(self.datastore[id.NOSE__NOSE_TIP], "visible", true)
    self.datastore[id.NOSE__NOSE_TIP__ENABLED] = DatabindingAddDataBool(self.datastore[id.NOSE__NOSE_TIP], "enabled", true)
    self.datastore[id.NOSE__NOSE_TIP__VALUE] = DatabindingAddDataInt(self.datastore[id.NOSE__NOSE_TIP], "value", 0)
    self.datastore[id.NOSE__NOSE_TIP__ARRAY] = DatabindingAddHashArray(self.datastore[id.NOSE__NOSE_TIP], "options")
    self.datastore[id.NOSE__NOSE_TIP__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.NOSE__NOSE_TIP], "fine_tune_enabled", true)
    self.datastore[id.MOUTH__MOUTH] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "mouth")
    self.datastore[id.MOUTH__MOUTH__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MOUTH__MOUTH], "visible", true)
    self.datastore[id.MOUTH__MOUTH__ENABLED] = DatabindingAddDataBool(self.datastore[id.MOUTH__MOUTH], "enabled", true)
    self.datastore[id.MOUTH__MOUTH__VALUE] = DatabindingAddDataInt(self.datastore[id.MOUTH__MOUTH], "value", 0)
    self.datastore[id.MOUTH__MOUTH__ARRAY] = DatabindingAddHashArray(self.datastore[id.MOUTH__MOUTH], "options")
    self.datastore[id.MOUTH__MOUTH__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.MOUTH__MOUTH], "fine_tune_enabled", true)
    self.datastore[id.MOUTH__MOUTH_POSITION] = DatabindingAddDataContainer(self.datastore[id.MOUTH__MOUTH], "mouth_position")
    self.datastore[id.MOUTH__MOUTH_POSITION__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MOUTH__MOUTH_POSITION], "visible", true)
    self.datastore[id.MOUTH__MOUTH_POSITION__ENABLED] = DatabindingAddDataBool(self.datastore[id.MOUTH__MOUTH_POSITION], "enabled", true)
    self.datastore[id.MOUTH__MOUTH_POSITION__VALUE] = DatabindingAddDataInt(self.datastore[id.MOUTH__MOUTH_POSITION], "value", 0)
    self.datastore[id.MOUTH__MOUTH_POSITION__ARRAY] = DatabindingAddHashArray(self.datastore[id.MOUTH__MOUTH_POSITION], "options")
    self.datastore[id.MOUTH__MOUTH_POSITION__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.MOUTH__MOUTH_POSITION], "fine_tune_enabled", true)
    self.datastore[id.MOUTH__UPPER_LIP_SHAPE] = DatabindingAddDataContainer(self.datastore[id.MOUTH__MOUTH], "upper_lip_shape")
    self.datastore[id.MOUTH__UPPER_LIP_SHAPE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MOUTH__UPPER_LIP_SHAPE], "visible", true)
    self.datastore[id.MOUTH__UPPER_LIP_SHAPE__ENABLED] = DatabindingAddDataBool(self.datastore[id.MOUTH__UPPER_LIP_SHAPE], "enabled", true)
    self.datastore[id.MOUTH__UPPER_LIP_SHAPE__VALUE] = DatabindingAddDataInt(self.datastore[id.MOUTH__UPPER_LIP_SHAPE], "value", 0)
    self.datastore[id.MOUTH__UPPER_LIP_SHAPE__ARRAY] = DatabindingAddHashArray(self.datastore[id.MOUTH__UPPER_LIP_SHAPE], "options")
    self.datastore[id.MOUTH__UPPER_LIP_SHAPE__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.MOUTH__UPPER_LIP_SHAPE], "fine_tune_enabled", true)
    self.datastore[id.MOUTH__LOWER_LIP_SHAPE] = DatabindingAddDataContainer(self.datastore[id.MOUTH__MOUTH], "lower_lip_shape")
    self.datastore[id.MOUTH__LOWER_LIP_SHAPE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MOUTH__LOWER_LIP_SHAPE], "visible", true)
    self.datastore[id.MOUTH__LOWER_LIP_SHAPE__ENABLED] = DatabindingAddDataBool(self.datastore[id.MOUTH__LOWER_LIP_SHAPE], "enabled", true)
    self.datastore[id.MOUTH__LOWER_LIP_SHAPE__VALUE] = DatabindingAddDataInt(self.datastore[id.MOUTH__LOWER_LIP_SHAPE], "value", 0)
    self.datastore[id.MOUTH__LOWER_LIP_SHAPE__ARRAY] = DatabindingAddHashArray(self.datastore[id.MOUTH__LOWER_LIP_SHAPE], "options")
    self.datastore[id.MOUTH__LOWER_LIP_SHAPE__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.MOUTH__LOWER_LIP_SHAPE], "fine_tune_enabled", true)
    self.datastore[id.MOUTH__LIPS_DEPTH] = DatabindingAddDataContainer(self.datastore[id.MOUTH__MOUTH], "pedexpress_lips_depth")
    self.datastore[id.MOUTH__LIPS_DEPTH__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MOUTH__LIPS_DEPTH], "visible", true)
    self.datastore[id.MOUTH__LIPS_DEPTH__ENABLED] = DatabindingAddDataBool(self.datastore[id.MOUTH__LIPS_DEPTH], "enabled", true)
    self.datastore[id.MOUTH__LIPS_DEPTH__VALUE] = DatabindingAddDataInt(self.datastore[id.MOUTH__LIPS_DEPTH], "value", 0)
    self.datastore[id.MOUTH__LIPS_DEPTH__ARRAY] = DatabindingAddHashArray(self.datastore[id.MOUTH__LIPS_DEPTH], "options")
    self.datastore[id.MOUTH__LIPS_DEPTH__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.MOUTH__LIPS_DEPTH], "fine_tune_enabled", true)
    self.datastore[id.JAW__JAW_SHAPE] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "jaw_shape")
    self.datastore[id.JAW__JAW_SHAPE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.JAW__JAW_SHAPE], "visible", true)
    self.datastore[id.JAW__JAW_SHAPE__ENABLED] = DatabindingAddDataBool(self.datastore[id.JAW__JAW_SHAPE], "enabled", true)
    self.datastore[id.JAW__JAW_SHAPE__VALUE] = DatabindingAddDataInt(self.datastore[id.JAW__JAW_SHAPE], "value", 0)
    self.datastore[id.JAW__JAW_SHAPE__ARRAY] = DatabindingAddHashArray(self.datastore[id.JAW__JAW_SHAPE], "options")
    self.datastore[id.JAW__JAW_SHAPE__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.JAW__JAW_SHAPE], "fine_tune_enabled", true)
    self.datastore[id.JAW__JAW_DEPTH] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "pedexpress_jaw_depth")
    self.datastore[id.JAW__JAW_DEPTH__VISIBLE] = DatabindingAddDataBool(self.datastore[id.JAW__JAW_DEPTH], "visible", true)
    self.datastore[id.JAW__JAW_DEPTH__ENABLED] = DatabindingAddDataBool(self.datastore[id.JAW__JAW_DEPTH], "enabled", true)
    self.datastore[id.JAW__JAW_DEPTH__VALUE] = DatabindingAddDataInt(self.datastore[id.JAW__JAW_DEPTH], "value", 0)
    self.datastore[id.JAW__JAW_DEPTH__ARRAY] = DatabindingAddHashArray(self.datastore[id.JAW__JAW_DEPTH], "options")
    self.datastore[id.JAW__JAW_DEPTH__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.JAW__JAW_DEPTH], "fine_tune_enabled", true)
    self.datastore[id.JAW__CHIN_SHAPE] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "pedexpress_chin_shape")
    self.datastore[id.JAW__CHIN_SHAPE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.JAW__CHIN_SHAPE], "visible", true)
    self.datastore[id.JAW__CHIN_SHAPE__ENABLED] = DatabindingAddDataBool(self.datastore[id.JAW__CHIN_SHAPE], "enabled", true)
    self.datastore[id.JAW__CHIN_SHAPE__VALUE] = DatabindingAddDataInt(self.datastore[id.JAW__CHIN_SHAPE], "value", 0)
    self.datastore[id.JAW__CHIN_SHAPE__ARRAY] = DatabindingAddHashArray(self.datastore[id.JAW__CHIN_SHAPE], "options")
    self.datastore[id.JAW__CHIN_SHAPE__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.JAW__CHIN_SHAPE], "fine_tune_enabled", true)
    self.datastore[id.JAW__CHIN_DEPTH] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "pedexpress_chin_depth")
    self.datastore[id.JAW__CHIN_DEPTH__VISIBLE] = DatabindingAddDataBool(self.datastore[id.JAW__CHIN_DEPTH], "visible", true)
    self.datastore[id.JAW__CHIN_DEPTH__ENABLED] = DatabindingAddDataBool(self.datastore[id.JAW__CHIN_DEPTH], "enabled", true)
    self.datastore[id.JAW__CHIN_DEPTH__VALUE] = DatabindingAddDataInt(self.datastore[id.JAW__CHIN_DEPTH], "value", 0)
    self.datastore[id.JAW__CHIN_DEPTH__ARRAY] = DatabindingAddHashArray(self.datastore[id.JAW__CHIN_DEPTH], "options")
    self.datastore[id.JAW__CHIN_DEPTH__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.JAW__CHIN_DEPTH], "fine_tune_enabled", true)
    self.datastore[id.EARS__EAR_SHAPE] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "ear_shape")
    self.datastore[id.EARS__EAR_SHAPE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.EARS__EAR_SHAPE], "visible", true)
    self.datastore[id.EARS__EAR_SHAPE__ENABLED] = DatabindingAddDataBool(self.datastore[id.EARS__EAR_SHAPE], "enabled", true)
    self.datastore[id.EARS__EAR_SHAPE__VALUE] = DatabindingAddDataInt(self.datastore[id.EARS__EAR_SHAPE], "value", 0)
    self.datastore[id.EARS__EAR_SHAPE__ARRAY] = DatabindingAddHashArray(self.datastore[id.EARS__EAR_SHAPE], "options")
    self.datastore[id.EARS__EAR_SHAPE__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.EARS__EAR_SHAPE], "fine_tune_enabled", true)
    self.datastore[id.EARS__EAR_SIZE] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "ear_size")
    self.datastore[id.EARS__EAR_SIZE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.EARS__EAR_SIZE], "visible", true)
    self.datastore[id.EARS__EAR_SIZE__ENABLED] = DatabindingAddDataBool(self.datastore[id.EARS__EAR_SIZE], "enabled", true)
    self.datastore[id.EARS__EAR_SIZE__VALUE] = DatabindingAddDataInt(self.datastore[id.EARS__EAR_SIZE], "value", 0)
    self.datastore[id.EARS__EAR_SIZE__ARRAY] = DatabindingAddHashArray(self.datastore[id.EARS__EAR_SIZE], "options")
    self.datastore[id.EARS__EAR_SIZE__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.EARS__EAR_SIZE], "fine_tune_enabled", true)
    self.datastore[id.CHEEKS__CHEEK_SHAPE] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "cheek_shape")
    self.datastore[id.CHEEKS__CHEEK_SHAPE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.CHEEKS__CHEEK_SHAPE], "visible", true)
    self.datastore[id.CHEEKS__CHEEK_SHAPE__ENABLED] = DatabindingAddDataBool(self.datastore[id.CHEEKS__CHEEK_SHAPE], "enabled", true)
    self.datastore[id.CHEEKS__CHEEK_SHAPE__VALUE] = DatabindingAddDataInt(self.datastore[id.CHEEKS__CHEEK_SHAPE], "value", 0)
    self.datastore[id.CHEEKS__CHEEK_SHAPE__ARRAY] = DatabindingAddHashArray(self.datastore[id.CHEEKS__CHEEK_SHAPE], "options")
    self.datastore[id.CHEEKS__CHEEK_SHAPE__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.CHEEKS__CHEEK_SHAPE], "fine_tune_enabled", true)
    self.datastore[id.CHEEKS__CHEEKS_DEPTH] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "pedexpress_cheeks_depth")
    self.datastore[id.CHEEKS__CHEEKS_DEPTH__VISIBLE] = DatabindingAddDataBool(self.datastore[id.CHEEKS__CHEEKS_DEPTH], "visible", true)
    self.datastore[id.CHEEKS__CHEEKS_DEPTH__ENABLED] = DatabindingAddDataBool(self.datastore[id.CHEEKS__CHEEKS_DEPTH], "enabled", true)
    self.datastore[id.CHEEKS__CHEEKS_DEPTH__VALUE] = DatabindingAddDataInt(self.datastore[id.CHEEKS__CHEEKS_DEPTH], "value", 0)
    self.datastore[id.CHEEKS__CHEEKS_DEPTH__ARRAY] = DatabindingAddHashArray(self.datastore[id.CHEEKS__CHEEKS_DEPTH], "options")
    self.datastore[id.CHEEKS__CHEEKS_DEPTH__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.CHEEKS__CHEEKS_DEPTH], "fine_tune_enabled", true)
    self.datastore[id.HAIR__HAIR_STYLE] = DatabindingAddDataContainer(self.datastore[id.APPEARANCE__HAIR], "hair_style")
    self.datastore[id.HAIR__HAIR_STYLE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.HAIR__HAIR_STYLE], "visible", true)
    self.datastore[id.HAIR__HAIR_STYLE__ENABLED] = DatabindingAddDataBool(self.datastore[id.HAIR__HAIR_STYLE], "enabled", true)
    self.datastore[id.HAIR__HAIR_STYLE__VALUE] = DatabindingAddDataInt(self.datastore[id.HAIR__HAIR_STYLE], "value", 0)
    self.datastore[id.HAIR__HAIR_STYLE__ARRAY] = DatabindingAddHashArray(self.datastore[id.HAIR__HAIR_STYLE], "options")
    self.datastore[id.HAIR__HAIR_COLOR] = DatabindingAddDataContainer(self.datastore[id.APPEARANCE__HAIR], "hair_color")
    self.datastore[id.HAIR__HAIR_COLOR__VISIBLE] = DatabindingAddDataBool(self.datastore[id.HAIR__HAIR_COLOR], "visible", true)
    self.datastore[id.HAIR__HAIR_COLOR__ENABLED] = DatabindingAddDataBool(self.datastore[id.HAIR__HAIR_COLOR], "enabled", true)
    self.datastore[id.HAIR__HAIR_COLOR__VALUE] = DatabindingAddDataInt(self.datastore[id.HAIR__HAIR_COLOR], "value", 0)
    self.datastore[id.HAIR__HAIR_COLOR__ARRAY] = Citizen.InvokeNative(0xD48993A61938C64D, self.datastore[id.HAIR__HAIR_COLOR], "options")
    self.datastore[id.HAIR__HAIR_COLOR__TXD] = DatabindingAddDataString(self.datastore[id.HAIR__HAIR_COLOR], "texture_dictionary", "")
    self.datastore[id.HAIR__HAIR_COLOR__TEXTURE] = DatabindingAddDataString(self.datastore[id.HAIR__HAIR_COLOR], "texture", "")
    self.datastore[id.HAIR__HAIR_COLOR__COLOR] = DatabindingAddDataHash(self.datastore[id.HAIR__HAIR_COLOR], "color", `COLOR_WHITE`)
    self.datastore[id.HAIR__BEARD_STYLE] = DatabindingAddDataContainer(self.datastore[id.ROOT__BEARD], "beard_style")
    self.datastore[id.HAIR__BEARD_STYLE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.HAIR__BEARD_STYLE], "visible", true)
    self.datastore[id.HAIR__BEARD_STYLE__ENABLED] = DatabindingAddDataBool(self.datastore[id.HAIR__BEARD_STYLE], "enabled", true)
    self.datastore[id.HAIR__BEARD_STYLE__VALUE] = DatabindingAddDataInt(self.datastore[id.HAIR__BEARD_STYLE], "value", 0)
    self.datastore[id.HAIR__BEARD_STYLE__ARRAY] = DatabindingAddHashArray(self.datastore[id.HAIR__BEARD_STYLE], "options")
    self.datastore[id.HAIR__BEARD_COLOR] = DatabindingAddDataContainer(self.datastore[id.ROOT__BEARD], "beard_color")
    self.datastore[id.HAIR__BEARD_COLOR__VISIBLE] = DatabindingAddDataBool(self.datastore[id.HAIR__BEARD_COLOR], "visible", true)
    self.datastore[id.HAIR__BEARD_COLOR__ENABLED] = DatabindingAddDataBool(self.datastore[id.HAIR__BEARD_COLOR], "enabled", true)
    self.datastore[id.HAIR__BEARD_COLOR__VALUE] = DatabindingAddDataInt(self.datastore[id.HAIR__BEARD_COLOR], "value", 0)
    self.datastore[id.HAIR__BEARD_COLOR__ARRAY] = DatabindingAddHashArray(self.datastore[id.HAIR__BEARD_COLOR], "options")
    self.datastore[id.HAIR__BEARD_COLOR__TXD] = DatabindingAddDataString(self.datastore[id.HAIR__BEARD_COLOR], "texture_dictionary", "")
    self.datastore[id.HAIR__BEARD_COLOR__TEXTURE] = DatabindingAddDataString(self.datastore[id.HAIR__BEARD_COLOR], "texture", "")
    self.datastore[id.HAIR__BEARD_COLOR__COLOR] = DatabindingAddDataHash(self.datastore[id.HAIR__BEARD_COLOR], "color", `COLOR_WHITE`)
    self.datastore[id.HAIR__BEARD_STUBBLE] = DatabindingAddDataContainer(self.datastore[id.ROOT__BEARD], "beard_stubble")
    self.datastore[id.HAIR__BEARD_STUBBLE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.HAIR__BEARD_STUBBLE], "visible", true)
    self.datastore[id.HAIR__BEARD_STUBBLE__ENABLED] = DatabindingAddDataBool(self.datastore[id.HAIR__BEARD_STUBBLE], "enabled", true)
    self.datastore[id.HAIR__BEARD_STUBBLE__VALUE] = DatabindingAddDataInt(self.datastore[id.HAIR__BEARD_STUBBLE], "value", 0)
    self.datastore[id.HAIR__BEARD_STUBBLE__ARRAY] = DatabindingAddHashArray(self.datastore[id.HAIR__BEARD_STUBBLE], "options")
    self.datastore[id.LIFESTYLE__MOTTLING] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_mottling")
    self.datastore[id.LIFESTYLE__MOTTLING__VISIBLE] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__MOTTLING], "visible", true)
    self.datastore[id.LIFESTYLE__MOTTLING__ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__MOTTLING], "enabled", true)
    self.datastore[id.LIFESTYLE__MOTTLING__VALUE] = DatabindingAddDataInt(self.datastore[id.LIFESTYLE__MOTTLING], "value", 0)
    self.datastore[id.LIFESTYLE__MOTTLING__ARRAY] = DatabindingAddHashArray(self.datastore[id.LIFESTYLE__MOTTLING], "options")
    self.datastore[id.LIFESTYLE__MOTTLING__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__MOTTLING], "fine_tune_enabled", true)
    self.datastore[id.LIFESTYLE__COMPLEXION] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_complexion")
    self.datastore[id.LIFESTYLE__COMPLEXION__VISIBLE] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__COMPLEXION], "visible", true)
    self.datastore[id.LIFESTYLE__COMPLEXION__ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__COMPLEXION], "enabled", true)
    self.datastore[id.LIFESTYLE__COMPLEXION__VALUE] = DatabindingAddDataInt(self.datastore[id.LIFESTYLE__COMPLEXION], "value", 0)
    self.datastore[id.LIFESTYLE__COMPLEXION__ARRAY] = DatabindingAddHashArray(self.datastore[id.LIFESTYLE__COMPLEXION], "options")
    self.datastore[id.LIFESTYLE__COMPLEXION__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__COMPLEXION], "fine_tune_enabled", true)
    self.datastore[id.LIFESTYLE__COMPLEXION_2] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_complexion_2")
    self.datastore[id.LIFESTYLE__COMPLEXION_2__VISIBLE] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__COMPLEXION_2], "visible", true)
    self.datastore[id.LIFESTYLE__COMPLEXION_2__ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__COMPLEXION_2], "enabled", true)
    self.datastore[id.LIFESTYLE__COMPLEXION_2__VALUE] = DatabindingAddDataInt(self.datastore[id.LIFESTYLE__COMPLEXION_2], "value", 0)
    self.datastore[id.LIFESTYLE__COMPLEXION_2__ARRAY] = DatabindingAddHashArray(self.datastore[id.LIFESTYLE__COMPLEXION_2], "options")
    self.datastore[id.LIFESTYLE__COMPLEXION_2__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__COMPLEXION_2], "fine_tune_enabled", true)
    self.datastore[id.LIFESTYLE__FRECKLES] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_freckles")
    self.datastore[id.LIFESTYLE__FRECKLES__VISIBLE] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__FRECKLES], "visible", true)
    self.datastore[id.LIFESTYLE__FRECKLES__ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__FRECKLES], "enabled", true)
    self.datastore[id.LIFESTYLE__FRECKLES__VALUE] = DatabindingAddDataInt(self.datastore[id.LIFESTYLE__FRECKLES], "value", 0)
    self.datastore[id.LIFESTYLE__FRECKLES__ARRAY] = DatabindingAddHashArray(self.datastore[id.LIFESTYLE__FRECKLES], "options")
    self.datastore[id.LIFESTYLE__FRECKLES__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__FRECKLES], "fine_tune_enabled", true)
    self.datastore[id.LIFESTYLE__MOLES] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_moles")
    self.datastore[id.LIFESTYLE__MOLES__VISIBLE] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__MOLES], "visible", true)
    self.datastore[id.LIFESTYLE__MOLES__ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__MOLES], "enabled", true)
    self.datastore[id.LIFESTYLE__MOLES__VALUE] = DatabindingAddDataInt(self.datastore[id.LIFESTYLE__MOLES], "value", 0)
    self.datastore[id.LIFESTYLE__MOLES__ARRAY] = DatabindingAddHashArray(self.datastore[id.LIFESTYLE__MOLES], "options")
    self.datastore[id.LIFESTYLE__MOLES__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__MOLES], "fine_tune_enabled", true)
    self.datastore[id.LIFESTYLE__SPOTS] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_spots")
    self.datastore[id.LIFESTYLE__SPOTS__VISIBLE] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__SPOTS], "visible", true)
    self.datastore[id.LIFESTYLE__SPOTS__ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__SPOTS], "enabled", true)
    self.datastore[id.LIFESTYLE__SPOTS__VALUE] = DatabindingAddDataInt(self.datastore[id.LIFESTYLE__SPOTS], "value", 0)
    self.datastore[id.LIFESTYLE__SPOTS__ARRAY] = DatabindingAddHashArray(self.datastore[id.LIFESTYLE__SPOTS], "options")
    self.datastore[id.LIFESTYLE__SPOTS__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__SPOTS], "fine_tune_enabled", true)
    self.datastore[id.LIFESTYLE__SCAR] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_scar")
    self.datastore[id.LIFESTYLE__SCAR__VISIBLE] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__SCAR], "visible", true)
    self.datastore[id.LIFESTYLE__SCAR__ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__SCAR], "enabled", true)
    self.datastore[id.LIFESTYLE__SCAR__VALUE] = DatabindingAddDataInt(self.datastore[id.LIFESTYLE__SCAR], "value", 0)
    self.datastore[id.LIFESTYLE__SCAR__ARRAY] = DatabindingAddHashArray(self.datastore[id.LIFESTYLE__SCAR], "options")
    self.datastore[id.LIFESTYLE__SCAR__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__SCAR], "fine_tune_enabled", true)
    self.datastore[id.LIFESTYLE__EYE_REDNESS] = DatabindingAddDataContainer(self.datastore[id.ROOT__HEAD], "eye_redness")
    self.datastore[id.LIFESTYLE__EYE_REDNESS__VISIBLE] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__EYE_REDNESS], "visible", true)
    self.datastore[id.LIFESTYLE__EYE_REDNESS__ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__EYE_REDNESS], "enabled", true)
    self.datastore[id.LIFESTYLE__EYE_REDNESS__VALUE] = DatabindingAddDataInt(self.datastore[id.LIFESTYLE__EYE_REDNESS], "value", 0)
    self.datastore[id.LIFESTYLE__EYE_REDNESS__ARRAY] = DatabindingAddHashArray(self.datastore[id.LIFESTYLE__EYE_REDNESS], "options")
    self.datastore[id.LIFESTYLE__EYE_REDNESS__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.LIFESTYLE__EYE_REDNESS], "fine_tune_enabled", true)
    self.datastore[id.MAKEUP__FOUNDATION] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_foundation")
    self.datastore[id.MAKEUP__FOUNDATION__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MAKEUP__FOUNDATION], "visible", true)
    self.datastore[id.MAKEUP__FOUNDATION__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__FOUNDATION], "enabled", true)
    self.datastore[id.MAKEUP__FOUNDATION__VALUE] = DatabindingAddDataInt(self.datastore[id.MAKEUP__FOUNDATION], "value", 0)
    self.datastore[id.MAKEUP__FOUNDATION__ARRAY] = DatabindingAddHashArray(self.datastore[id.MAKEUP__FOUNDATION], "options")
    self.datastore[id.MAKEUP__FOUNDATION__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__FOUNDATION], "fine_tune_enabled", true)
    self.datastore[id.MAKEUP__BLUSHER] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_blusher")
    self.datastore[id.MAKEUP__BLUSHER__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MAKEUP__BLUSHER], "visible", true)
    self.datastore[id.MAKEUP__BLUSHER__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__BLUSHER], "enabled", true)
    self.datastore[id.MAKEUP__BLUSHER__VALUE] = DatabindingAddDataInt(self.datastore[id.MAKEUP__BLUSHER], "value", 0)
    self.datastore[id.MAKEUP__BLUSHER__ARRAY] = DatabindingAddHashArray(self.datastore[id.MAKEUP__BLUSHER], "options")
    self.datastore[id.MAKEUP__BLUSHER__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__BLUSHER], "fine_tune_enabled", true)
    self.datastore[id.MAKEUP__EYESHADOW] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_eyeshadow")
    self.datastore[id.MAKEUP__EYESHADOW__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MAKEUP__EYESHADOW], "visible", true)
    self.datastore[id.MAKEUP__EYESHADOW__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__EYESHADOW], "enabled", true)
    self.datastore[id.MAKEUP__EYESHADOW__VALUE] = DatabindingAddDataInt(self.datastore[id.MAKEUP__EYESHADOW], "value", 0)
    self.datastore[id.MAKEUP__EYESHADOW__ARRAY] = DatabindingAddHashArray(self.datastore[id.MAKEUP__EYESHADOW], "options")
    self.datastore[id.MAKEUP__EYESHADOW__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__EYESHADOW], "fine_tune_enabled", true)
    self.datastore[id.MAKEUP__EYESHADOW_COLOR] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_eyeshadow_color")
    self.datastore[id.MAKEUP__EYESHADOW_COLOR__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MAKEUP__EYESHADOW_COLOR], "visible", true)
    self.datastore[id.MAKEUP__EYESHADOW_COLOR__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__EYESHADOW_COLOR], "enabled", true)
    self.datastore[id.MAKEUP__EYESHADOW_COLOR__VALUE] = DatabindingAddDataInt(self.datastore[id.MAKEUP__EYESHADOW_COLOR], "value", 0)
    self.datastore[id.MAKEUP__EYESHADOW_COLOR__ARRAY] = Citizen.InvokeNative(0xD48993A61938C64D, self.datastore[id.MAKEUP__EYESHADOW_COLOR], "options")
    self.datastore[id.MAKEUP__EYESHADOW_COLOR__TXD] = DatabindingAddDataString(self.datastore[id.MAKEUP__EYESHADOW_COLOR], "texture_dictionary", "")
    self.datastore[id.MAKEUP__EYESHADOW_COLOR__TEXTURE] = DatabindingAddDataString(self.datastore[id.MAKEUP__EYESHADOW_COLOR], "texture", "")
    self.datastore[id.MAKEUP__EYESHADOW_COLOR__COLOR] = DatabindingAddDataHash(self.datastore[id.MAKEUP__EYESHADOW_COLOR], "color", `COLOR_WHITE`)
    self.datastore[id.MAKEUP__EYELINER] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_eyeliner")
    self.datastore[id.MAKEUP__EYELINER__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MAKEUP__EYELINER], "visible", true)
    self.datastore[id.MAKEUP__EYELINER__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__EYELINER], "enabled", true)
    self.datastore[id.MAKEUP__EYELINER__VALUE] = DatabindingAddDataInt(self.datastore[id.MAKEUP__EYELINER], "value", 0)
    self.datastore[id.MAKEUP__EYELINER__ARRAY] = DatabindingAddHashArray(self.datastore[id.MAKEUP__EYELINER], "options")
    self.datastore[id.MAKEUP__EYELINER__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__EYELINER], "fine_tune_enabled", true)
    self.datastore[id.MAKEUP__LIPSTICK] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_lipstick")
    self.datastore[id.MAKEUP__LIPSTICK__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MAKEUP__LIPSTICK], "visible", true)
    self.datastore[id.MAKEUP__LIPSTICK__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__LIPSTICK], "enabled", true)
    self.datastore[id.MAKEUP__LIPSTICK__VALUE] = DatabindingAddDataInt(self.datastore[id.MAKEUP__LIPSTICK], "value", 0)
    self.datastore[id.MAKEUP__LIPSTICK__ARRAY] = DatabindingAddHashArray(self.datastore[id.MAKEUP__LIPSTICK], "options")
    self.datastore[id.MAKEUP__LIPSTICK__FINE_TUNE_ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__LIPSTICK], "fine_tune_enabled", true)
    self.datastore[id.MAKEUP__LIPSTICK_COLOR] = DatabindingAddDataContainer(self.datastore[id.ROOT__FACE], "skin_lipstick_color")
    self.datastore[id.MAKEUP__LIPSTICK_COLOR__VISIBLE] = DatabindingAddDataBool(self.datastore[id.MAKEUP__LIPSTICK_COLOR], "visible", true)
    self.datastore[id.MAKEUP__LIPSTICK_COLOR__ENABLED] = DatabindingAddDataBool(self.datastore[id.MAKEUP__LIPSTICK_COLOR], "enabled", true)
    self.datastore[id.MAKEUP__LIPSTICK_COLOR__VALUE] = DatabindingAddDataInt(self.datastore[id.MAKEUP__LIPSTICK_COLOR], "value", 0)
    self.datastore[id.MAKEUP__LIPSTICK_COLOR__ARRAY] = Citizen.InvokeNative(0xD48993A61938C64D, self.datastore[id.MAKEUP__LIPSTICK_COLOR], "options")
    self.datastore[id.MAKEUP__LIPSTICK_COLOR__TXD] = DatabindingAddDataString(self.datastore[id.MAKEUP__LIPSTICK_COLOR], "texture_dictionary", "")
    self.datastore[id.MAKEUP__LIPSTICK_COLOR__TEXTURE] = DatabindingAddDataString(self.datastore[id.MAKEUP__LIPSTICK_COLOR], "texture", "")
    self.datastore[id.MAKEUP__LIPSTICK_COLOR__COLOR] = DatabindingAddDataHash(self.datastore[id.MAKEUP__LIPSTICK_COLOR], "color", `COLOR_WHITE`)
    self.datastore[id.WHISTLE__STYLE] = DatabindingAddDataContainer(self.datastore[id.ROOT], "whistle_style")
    self.datastore[id.WHISTLE__STYLE__VISIBLE] = DatabindingAddDataBool(self.datastore[id.WHISTLE__STYLE], "visible", true)
    self.datastore[id.WHISTLE__STYLE__ENABLED] = DatabindingAddDataBool(self.datastore[id.WHISTLE__STYLE], "enabled", true)
    self.datastore[id.WHISTLE__STYLE__VALUE] = DatabindingAddDataInt(self.datastore[id.WHISTLE__STYLE], "value", 0)
    self.datastore[id.WHISTLE__STYLE__ARRAY] = DatabindingAddHashArray(self.datastore[id.WHISTLE__STYLE], "options")
    self.datastore[id.WHISTLE__PITCH] = DatabindingAddDataContainer(self.datastore[id.ROOT], "whistle_pitch")
    self.datastore[id.WHISTLE__PITCH__VISIBLE] = DatabindingAddDataBool(self.datastore[id.WHISTLE__PITCH], "visible", true)
    self.datastore[id.WHISTLE__PITCH__ENABLED] = DatabindingAddDataBool(self.datastore[id.WHISTLE__PITCH], "enabled", true)
    self.datastore[id.WHISTLE__PITCH__VALUE] = DatabindingAddDataInt(self.datastore[id.WHISTLE__PITCH], "value", 50)
    self.datastore[id.WHISTLE__PITCH__MINIMUM] = DatabindingAddDataInt(self.datastore[id.WHISTLE__PITCH], "minimum", 0)
    self.datastore[id.WHISTLE__PITCH__MAXIMUM] = DatabindingAddDataInt(self.datastore[id.WHISTLE__PITCH], "maximum", 100)
    self.datastore[id.WHISTLE__CLARITY] = DatabindingAddDataContainer(self.datastore[id.ROOT], "whistle_clarity")
    self.datastore[id.WHISTLE__CLARITY__VISIBLE] = DatabindingAddDataBool(self.datastore[id.WHISTLE__CLARITY], "visible", true)
    self.datastore[id.WHISTLE__CLARITY__ENABLED] = DatabindingAddDataBool(self.datastore[id.WHISTLE__CLARITY], "enabled", true)
    self.datastore[id.WHISTLE__CLARITY__VALUE] = DatabindingAddDataInt(self.datastore[id.WHISTLE__CLARITY], "value", 50)
    self.datastore[id.WHISTLE__CLARITY__MINIMUM] = DatabindingAddDataInt(self.datastore[id.WHISTLE__CLARITY], "minimum", 0)
    self.datastore[id.WHISTLE__CLARITY__MAXIMUM] = DatabindingAddDataInt(self.datastore[id.WHISTLE__CLARITY], "maximum", 100)
    self.datastore[id.ATTRIBUTES__HEALTH] = DatabindingAddDataContainer(self.datastore[id.ROOT], "health_attribute")
    self.datastore[id.ATTRIBUTES__HEALTH__VALUE] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__HEALTH], "value", CreatorConfig.Attributes.Health.Default or 1)
    self.datastore[id.ATTRIBUTES__HEALTH__MINIMUM] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__HEALTH], "minimum", CreatorConfig.Attributes.Health.Min or 1)
    self.datastore[id.ATTRIBUTES__HEALTH__MAXIMUM] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__HEALTH], "maximum", CreatorConfig.Attributes.Health.Max or 10)
    self.datastore[id.ATTRIBUTES__HEALTH__TOTAL_TANKS] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__HEALTH], "total_tanks", 10)
    self.datastore[id.ATTRIBUTES__STAMINA] = DatabindingAddDataContainer(self.datastore[id.ROOT], "stamina_attribute")
    self.datastore[id.ATTRIBUTES__STAMINA__VALUE] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__STAMINA], "value", CreatorConfig.Attributes.Stamina.Default or 1)
    self.datastore[id.ATTRIBUTES__STAMINA__MINIMUM] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__STAMINA], "minimum", CreatorConfig.Attributes.Stamina.Min or 1)
    self.datastore[id.ATTRIBUTES__STAMINA__MAXIMUM] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__STAMINA], "maximum", CreatorConfig.Attributes.Stamina.Max or 10)
    self.datastore[id.ATTRIBUTES__STAMINA__TOTAL_TANKS] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__STAMINA], "total_tanks", 10)
    self.datastore[id.ATTRIBUTES__DEADEYE] = DatabindingAddDataContainer(self.datastore[id.ROOT], "deadeye_attribute")
    self.datastore[id.ATTRIBUTES__DEADEYE__VALUE] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__DEADEYE], "value", CreatorConfig.Attributes.Deadeye.Default or 1)
    self.datastore[id.ATTRIBUTES__DEADEYE__MINIMUM] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__DEADEYE], "minimum", CreatorConfig.Attributes.Deadeye.Min or 1)
    self.datastore[id.ATTRIBUTES__DEADEYE__MAXIMUM] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__DEADEYE], "maximum", CreatorConfig.Attributes.Deadeye.Max or 10)
    self.datastore[id.ATTRIBUTES__DEADEYE__TOTAL_TANKS] = DatabindingAddDataInt(self.datastore[id.ATTRIBUTES__DEADEYE], "total_tanks", 10)

    self.initialized = true

    return true
end

function CreatorDatabinding:FilloutUiData()
    local id = DATABINDING_ID

    -- Determine whether the various UI elements should be visible for this mode
    local ITEM_IDS = UI_ITEM_ID:Values()
    local ATTRIBUTE_NAMES = { "Camera", "Ui", "Expressions", "OverlayLayer", "SwatchItem", "SwatchLabel", "GridLabels" }

    for _, itemId in ipairs(ITEM_IDS) do
        local databinds = UI_ITEM_ID:GetDatabinding(itemId)
        if not databinds then goto continue end

        local isUsed = false
        for _, name in pairs(ATTRIBUTE_NAMES) do
            local value = UI_ITEM_ID:GetProp(itemId, name)
            if value ~= nil then
                isUsed = true
                break
            end
        end

        if databinds.Visible then self:WriteBool(databinds.Visible, isUsed) end
        if databinds.Enabled then self:WriteBool(databinds.Enabled, isUsed) end

        ::continue::
    end

    -- The name toggle is permanently disabled due to it using profanity filters
    self:WriteBool(id.MAIN__NAME__ENABLED, false)

    -- TODO: Attributes support
    self:WriteBool(id.MAIN__ATTRIBUTES__VISIBLE, false)

    -- Fill all the stepper options
    if CreatorState:IsDefaultMode() then
        self:WriteHashArray(id.APPEARANCE__HERITAGE__ARRAY, CreatorState:GetHeritageLabels())
        self:WriteHashArray(id.APPEARANCE__BODY_BUILD__ARRAY, CreatorState:GetBodyBuildLabels())
        self:WriteHashArray(id.APPEARANCE__EYEBROWS__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.EYEBROWS))
        self:WriteHashArray(id.APPEARANCE__TEETH__ARRAY, CreatorState:GetTeethLabels())
        self:WriteHashArray(id.APPEARANCE__EYES_PRESET__ARRAY, CreatorState:GetPresetLabels(PED_EXPRESSION_ZONE.EYES))
        self:WriteHashArray(id.APPEARANCE__NOSE_PRESET__ARRAY, CreatorState:GetPresetLabels(PED_EXPRESSION_ZONE.NOSE))
        self:WriteHashArray(id.APPEARANCE__MOUTH_PRESET__ARRAY, CreatorState:GetPresetLabels(PED_EXPRESSION_ZONE.MOUTH))
        self:WriteHashArray(id.APPEARANCE__JAW_PRESET__ARRAY, CreatorState:GetPresetLabels(PED_EXPRESSION_ZONE.JAW))
        self:WriteHashArray(id.APPEARANCE__EARS_PRESET__ARRAY, CreatorState:GetPresetLabels(PED_EXPRESSION_ZONE.EARS))
        self:WriteHashArray(id.APPEARANCE__CHEEKS_PRESET__ARRAY, CreatorState:GetPresetLabels(PED_EXPRESSION_ZONE.CHEEKS))

        self:WriteHashArray(id.LIFESTYLE__MOTTLING__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.SKIN_MOTTLING))
        self:WriteHashArray(id.LIFESTYLE__COMPLEXION__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.COMPLEXION))
        self:WriteHashArray(id.LIFESTYLE__COMPLEXION_2__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.COMPLEXION_2))
        self:WriteHashArray(id.LIFESTYLE__FRECKLES__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.FRECKLES))
        self:WriteHashArray(id.LIFESTYLE__MOLES__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.MOLES))
        self:WriteHashArray(id.LIFESTYLE__SPOTS__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.SPOTS))
        self:WriteHashArray(id.LIFESTYLE__SCAR__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.SCAR))
        self:WriteHashArray(id.LIFESTYLE__EYE_REDNESS__ARRAY, {})

        self:WriteHashArray(id.MAKEUP__FOUNDATION__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.FOUNDATION))
        self:WriteHashArray(id.MAKEUP__BLUSHER__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.BLUSHER))
        self:WriteHashArray(id.MAKEUP__EYESHADOW__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.EYESHADOW))
        self:WriteHashArray(id.MAKEUP__EYELINER__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.EYELINER))
        self:WriteHashArray(id.MAKEUP__LIPSTICK__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.LIPSTICK))

        self:WriteHashArray(id.HAIR__HAIR_STYLE__ARRAY, CreatorState:GetHairLabels())
        self:WriteHashArray(id.HAIR__BEARD_STYLE__ARRAY, CreatorState:GetBeardLabels())
        self:WriteHashArray(id.HAIR__BEARD_STUBBLE__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.FACIAL_HAIR))

        self:WriteHashArray(id.WHISTLE__STYLE__ARRAY, CreatorState:GetWhistleLabels())
    else
        self:WriteHashArray(id.APPEARANCE__HERITAGE__ARRAY, {})
        self:WriteHashArray(id.APPEARANCE__BODY_BUILD__ARRAY, CreatorState:GetHeightLabels())
        self:WriteHashArray(id.APPEARANCE__EYEBROWS__ARRAY, CreatorState:GetWeightLabels())
        self:WriteHashArray(id.APPEARANCE__TEETH__ARRAY, {})
        self:WriteHashArray(id.APPEARANCE__EYES_PRESET__ARRAY, CreatorState:GetPresetLabels(PED_EXPRESSION_ZONE.TORSO))
        self:WriteHashArray(id.APPEARANCE__NOSE_PRESET__ARRAY, CreatorState:GetPresetLabels(PED_EXPRESSION_ZONE.CORNERS))
        self:WriteHashArray(id.APPEARANCE__MOUTH_PRESET__ARRAY, CreatorState:GetPresetLabels(PED_EXPRESSION_ZONE.CRANIAL))
        self:WriteHashArray(id.APPEARANCE__JAW_PRESET__ARRAY, CreatorState:GetPresetLabels(PED_EXPRESSION_ZONE.LIMBS))
        self:WriteHashArray(id.APPEARANCE__EARS_PRESET__ARRAY, {})
        self:WriteHashArray(id.APPEARANCE__CHEEKS_PRESET__ARRAY, {})

        self:WriteHashArray(id.LIFESTYLE__MOTTLING__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.GRIME))
        self:WriteHashArray(id.LIFESTYLE__COMPLEXION__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.AGEING))
        self:WriteHashArray(id.LIFESTYLE__COMPLEXION_2__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.HEAD_HAIR))
        self:WriteHashArray(id.LIFESTYLE__FRECKLES__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.SCAR_2))
        self:WriteHashArray(id.LIFESTYLE__MOLES__ARRAY, CreatorState:GetOverlayLabels(OVERLAY_LAYER.FACIAL_HAIR))
        self:WriteHashArray(id.LIFESTYLE__SPOTS__ARRAY, {})
        self:WriteHashArray(id.LIFESTYLE__SCAR__ARRAY, {})
        self:WriteHashArray(id.LIFESTYLE__EYE_REDNESS__ARRAY, {})

        self:WriteHashArray(id.MAKEUP__FOUNDATION__ARRAY, {})
        self:WriteHashArray(id.MAKEUP__BLUSHER__ARRAY, {})
        self:WriteHashArray(id.MAKEUP__EYELINER__ARRAY, {})
        self:WriteHashArray(id.MAKEUP__EYESHADOW__ARRAY, {})
        self:WriteHashArray(id.MAKEUP__LIPSTICK__ARRAY, {})

        self:WriteHashArray(id.HAIR__HAIR_STYLE__ARRAY, {})
        self:WriteHashArray(id.HAIR__BEARD_STYLE__ARRAY, {})
        self:WriteHashArray(id.HAIR__BEARD_STUBBLE__ARRAY, {})

        self:WriteHashArray(id.WHISTLE__STYLE__ARRAY, CreatorState:GetVoiceLabels())
    end

    -- Handle gender-specific UI elements
    if CreatorState:IsDefaultMode() then
        self:WriteBool(id.APPEARANCE__MAKEUP__VISIBLE, Character:IsFemale())

        if Character:IsMale() then
            self:WriteBool(id.ROOT__BEARD__VISIBLE, true)
            self:WriteBool(id.HAIR__BEARD_STUBBLE__VISIBLE, true)
            self:WriteBool(id.HAIR__HAIR_COLOR__ENABLED, true)
            self:WriteBool(id.HAIR__BEARD_COLOR__ENABLED, Character:WearingBeard())
            self:WriteBool(id.ROOT__FACE__FACIAL_HAIR_WORN, Character:WearingBeard())
            self:WriteBool(id.ROOT__HAIR_MATCH__ENABLED, Character:WearingHair() or Character:WearingBeard())
        else
            self:WriteBool(id.ROOT__BEARD__VISIBLE, false)
            self:WriteBool(id.HAIR__BEARD_STUBBLE__VISIBLE, false)
            self:WriteBool(id.HAIR__HAIR_COLOR__ENABLED, true)
            self:WriteBool(id.HAIR__BEARD_COLOR__ENABLED, false)
            self:WriteBool(id.ROOT__FACE__FACIAL_HAIR_WORN, false)
            self:WriteBool(id.ROOT__HAIR_MATCH__ENABLED, false)
        end
    else
        self:WriteBool(id.LIFESTYLE__MOLES__VISIBLE, Character:IsMale())
    end

    CreatorDatabinding:ApplyFromCharacter()

    return true
end

function CreatorDatabinding:ApplyFromCharacter()
    local id = DATABINDING_ID

    if CreatorState:IsDefaultMode() then
        self:WriteInt(id.APPEARANCE__HERITAGE__VALUE, Character.heritage)
        self:WriteInt(id.APPEARANCE__SKIN_TONE__VALUE, Character.skintone)
        self:WriteInt(id.APPEARANCE__AGE__VALUE, Character.age)
        self:WriteInt(id.APPEARANCE__BODY_BUILD__VALUE, Character.bodyType)
        self:WriteInt(id.APPEARANCE__EYE_COLOR__VALUE, Character.eyeColor)
        self:WriteInt(id.APPEARANCE__TEETH__VALUE, Character.teeth)
        self:WriteInt(id.HAIR__HAIR_STYLE__VALUE, Character.hair)
        self:WriteInt(id.HAIR__BEARD_STYLE__VALUE, Character.beard)
        self:WriteInt(id.LIFESTYLE__EYE_REDNESS__VALUE, Character.weariness)
        self:WriteInt(id.WHISTLE__STYLE__VALUE, Character.whistleStyle)
        self:WriteInt(id.WHISTLE__PITCH__VALUE, Character.whistlePitch)
        self:WriteInt(id.WHISTLE__CLARITY__VALUE, Character.whistleClarity)

        CreatorRenderer:UpdateColorSwatch(UI_ITEM_ID.APPEARANCE__SKIN_TONE, Character.skintone)
        CreatorRenderer:UpdateColorSwatch(UI_ITEM_ID.APPEARANCE__EYE_COLOR, Character.eyeColor)
        CreatorRenderer:UpdateColorSwatch(UI_ITEM_ID.HAIR__HAIR_COLOR, Character.hairColor)
        CreatorRenderer:UpdateColorSwatch(UI_ITEM_ID.HAIR__BEARD_COLOR, Character.beardColor)
    else
        self:WriteInt(id.APPEARANCE__BODY_BUILD__VALUE, Character.height)
        self:WriteInt(id.APPEARANCE__EYEBROWS__VALUE, Character.weight)
        self:WriteInt(id.WHISTLE__STYLE__VALUE, Character.voice)
    end

    for expressionZone, databinding in pairs(PED_EXPRESSION_ZONE:Pluck("Databinding", "Id")) do
        self:WriteInt(databinding.Value, Character.presets[expressionZone] or 0)
    end

    for overlayLayer, databinding in pairs(OVERLAY_LAYER:Pluck("Databinding", "Id")) do
        local overlay = Character:GetOverlay(overlayLayer)
        self:WriteInt(databinding.Value, overlay.id)

        if OVERLAY_LAYER:GetSupportsTint(overlayLayer) then
            local itemId = UI_ITEM_ID:GetIdFromOverlayLayer(overlayLayer)
            if not itemId then goto continue end

            local swatchItemId = UI_ITEM_ID:GetSwatchItem(itemId)
            if not swatchItemId then goto continue end

            local swatchDatabinding = UI_ITEM_ID:GetDatabinding(swatchItemId)
            if not swatchDatabinding then goto continue end

            CreatorRenderer:UpdateColorSwatch(swatchItemId, Character:GetOverlayColor(overlayLayer))

            local blend = CharacterOverlay:GetLayerBlend(overlayLayer, overlay.id + 1)
            self:WriteBool(swatchDatabinding.Visible, blend ~= "BLEND_NONE")

            ::continue::
        end
    end
end

function CreatorDatabinding:UpdateBlockedOverlays()
    local layers = CharacterOverlay:GetBlockedLayers()
    for _, layer in ipairs(OVERLAY_LAYER:Values()) do
        local databinding = OVERLAY_LAYER:GetDatabinding(layer)
        if not databinding then goto continue end

        if not databinding.Enabled then
            Utils:Debug(string.format("Skipping overlay layer %s because it has no enabled databinding", OVERLAY_LAYER:ToString(layer)))
            goto continue
        end

        local blocked = layers[layer] or false
        self:WriteBool(databinding.Enabled, blocked ~= true)

        ::continue::
    end
end

function CreatorDatabinding:IsValid(bind)
    if not bind or bind <= 0 then return false end
    return DatabindingIsEntryValid(bind) == 1
end

function CreatorDatabinding:Destroy()
    if not self.initialized then return end

    if self:IsValid(self.datastore[DATABINDING_ID.ROOT]) then
        DatabindingRemoveDataEntry(self.datastore[DATABINDING_ID.ROOT])
    end

    self.datastore = {}
    self.initialized = false
end

function CreatorDatabinding:WriteBool(index, value)
    local binding = self.datastore[index] or 0
    if not self:IsValid(binding) then error("Invalid databinding entry", 2) end
    DatabindingWriteDataBool(binding, value)
end

function CreatorDatabinding:ReadBool(index)
    local binding = self.datastore[index] or 0
    if not self:IsValid(binding) then error("Invalid databinding entry", 2) end
    return Citizen.InvokeNative(0x5EEFBD4B6D7CD6EB, binding, Citizen.ResultAsInteger()) == 1
end

function CreatorDatabinding:WriteInt(index, value)
    local binding = self.datastore[index] or 0
    if not self:IsValid(binding) then error("Invalid databinding entry", 2) end
    DatabindingWriteDataInt(binding, value)
end

function CreatorDatabinding:ReadInt(index)
    local binding = self.datastore[index] or 0
    if not self:IsValid(binding) then error("Invalid databinding entry", 2) end
    return Citizen.InvokeNative(0x570784D782597512, binding, Citizen.ResultAsInteger())
end

function CreatorDatabinding:WriteFloat(index, value)
    local binding = self.datastore[index] or 0
    if not self:IsValid(binding) then error("Invalid databinding entry", 2) end
    DatabindingWriteDataFloat(binding, value)
end

function CreatorDatabinding:ReadFloat(index)
    local binding = self.datastore[index] or 0
    if not self:IsValid(binding) then error("Invalid databinding entry", 2) end
    return Citizen.InvokeNative(0x5FE444EB67C70AD4, binding, Citizen.ResultAsFloat())
end

function CreatorDatabinding:WriteHash(index, value)
    local binding = self.datastore[index] or 0
    if not self:IsValid(binding) then error("Invalid databinding entry", 2) end
    DatabindingWriteDataHashString(binding, value)
end

function CreatorDatabinding:ReadHash(index)
    local binding = self.datastore[index] or 0
    if not self:IsValid(binding) then error("Invalid databinding entry", 2) end
    return Citizen.InvokeNative(0x81D7183E7A8ECA72, binding, Citizen.ResultAsInteger())
end

function CreatorDatabinding:WriteString(index, value)
    local binding = self.datastore[index] or 0
    if not self:IsValid(binding) then error("Invalid databinding entry", 2) end
    DatabindingWriteDataString(binding, value)
end

function CreatorDatabinding:ReadString(index)
    local binding = self.datastore[index] or 0
    if not self:IsValid(binding) then error("Invalid databinding entry", 2) end
    return Citizen.InvokeNative(0x3D290B5FFA7C5151, binding, Citizen.ResultAsString())
end

function CreatorDatabinding:WriteHashArray(index, options)
    local binding = self.datastore[index] or 0
    if not self:IsValid(binding) then error("Invalid databinding entry", 2) end

    -- Clears hash arrays
    Citizen.InvokeNative(0x3BF0767CF33FCC88, binding)

    -- Create new hash array options
    for _, option in ipairs(options) do
        Citizen.InvokeNative(0x7FC60C94C83C5CD7, binding, joaat(option), -1)
    end
end

function CreatorDatabinding:WriteColorSwatches(options)
    local parent = self.datastore[DATABINDING_ID.ROOT__COLOR_SWATCH] or 0
    if not self:IsValid(parent) then error("Invalid databinding entry", 2) end

    local array = self.datastore[DATABINDING_ID.ROOT__COLOR_SWATCH__ARRAY] or 0
    if not self:IsValid(array) then error("Invalid databinding entry", 2) end

    local container = self.datastore[DATABINDING_ID.ROOT__COLOR_SWATCH__ITEMS_CONTAINER] or 0
    if not self:IsValid(container) then error("Invalid databinding entry", 2) end

    -- Clears hash arrays
    Citizen.InvokeNative(0x3BF0767CF33FCC88, array)

    -- Destroy and recreate the items container
    DatabindingRemoveDataEntry(container)
    container = DatabindingAddDataContainer(parent, "Items")

    -- Create new swatch options
    for index, option in ipairs(options) do
        local swatch = DatabindingAddDataContainer(container, "Item" .. index)
        DatabindingAddDataString(swatch, "TextureDictionary", option.dict)
        DatabindingAddDataString(swatch, "Texture", option.texture)
        DatabindingInsertUiItemToListFromContextStringAlias(array, index, "color_palette_entry", swatch)
    end

    self.datastore[DATABINDING_ID.ROOT__COLOR_SWATCH__ITEMS_CONTAINER] = container
end
