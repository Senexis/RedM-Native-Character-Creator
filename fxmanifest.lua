fx_version "cerulean"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."
game "rdr3"

name "Native Character Creator"
author "Senexis <https://github.com/Senexis>"
description "A full implementation of the truly Native Character Creator UI"
version "1.0.0"
repository "https://github.com/Senexis/RedM-Native-Character-Creator"
license "GNU GPL v3"

ui_page 'html/index.html'

files {
    'html/index.html'
}

client_scripts {
    "@native-shop/client/api.lua",

    "client/utils.lua",
    "client/signals.lua",
    "client/dataview.lua",
    "client/alerts.lua",
    "client/enums.lua",
    "client/constants/*.lua",
    "client/constants/super/*.lua",

    -- Config files
    "client/creator/config.lua",
    "client/intro/config.lua",

    -- Character files
    "client/character/character.lua",
    "client/character/blend.lua",
    "client/character/blends.lua",
    "client/character/overlay.lua",

    -- Creator files
    "client/creator/presets.lua",
    "client/creator/xml.lua",
    "client/creator/databinding.lua",
    "client/creator/events.lua",
    "client/creator/renderer.lua",
    "client/creator/menu.lua",
    "client/creator/creator.lua",

    -- Intro files
    "client/intro/xml.lua",
    "client/intro/animations.lua",
    "client/intro/intro.lua",

    -- Debug files
    "client/debug.lua",
}

dependencies {
    "native-shop"
}
