# Native Character Creator

> [!IMPORTANT]
> This documentation, much like the resource, is currently in a beta state and is not final. The data types, events, and triggers described in this documentation may change in future versions as the project evolves.

## Overview

Native Character Creator is a RedM resource that provides a fully native implementation of the Character Creator UI for Red Dead Redemption 2 multiplayer servers. This resource allows developers to create custom Character Creator workflows and features all the visual elements players expect from the authentic Red Dead experience.

Unlike traditional web-based or custom UI implementations, Native Character Creator leverages the game's built-in interface systems to provide seamless integration with the player's existing UI experience.

📖 **[Jump to Documentation](#triggers)**

## Feature Requests

If you're missing functionality or have ideas for new features that would improve Native Character Creator, please don't hesitate to [open an issue](https://github.com/Senexis/RedM-Native-Character-Creator/issues). Feature requests from the community are always welcome, and feedback about use cases and requirements helps shape the direction of this project!

## License & Monetization

This resource is provided free of charge and represents countless hours of development work. Like most RedM resources, it builds upon the game's existing functionality rather than being created from scratch - the underlying native functionality belongs to Rockstar Games.

While the RedM community is fantastic and there's certainly a space for paid resources, there's unfortunately a trend of knowledge being gatekept behind paywalls, making important development knowledge harder to access for the community.

**For Server Owners:** You're absolutely welcome to use Native Character Creator on your servers without any restrictions beyond the license terms.

**For Resource Developers:** If you want to use this as a base for your own projects or distribute modified versions, please pay close attention to the license requirements. As stated in the GNU GPL v3 license, any distributed modifications must be shared under the same open source license. This ensures that improvements benefit the entire community rather than being locked behind paywalls.

The goal is to foster collaboration and shared knowledge, not to enable profiteering from freely contributed work. This is simply a request for license compliance - since the code is open source and properly licensed, you are free to do with it what the license permits. Ultimately, everyone should strive to make the whole of RedM a better place for all players and developers.

Native Character Creator is licensed under the [GNU GPL v3](https://github.com/Senexis/RedM-Native-Character-Creator/blob/main/LICENSE.md).

## Triggers

Triggers are client-side events that allow you to control the character creator's behavior programmatically. These events provide the core functionality for opening or closing the character creator.

### General Triggers

```lua
-- Forces the charactor creator to open
TriggerEvent("native_cc:open_cc", mode, index)

-- Forces the charactor creator to close
TriggerEvent("native_cc:close_cc", mode)
```

## Events

Events are fired automatically by the Native Character Creator system when specific actions occur. You can listen to these events to implement custom logic, such as saving chracter changes, logging player actions, or triggering server-side operations when players interact with character settings.

### General Events

```lua
AddEventHandler("native_cc:cc_opened", function(mode)
    print("This event is fired when the player opens the character creator with mode:", mode)
end)

AddEventHandler("native_cc:cc_closed", function(mode)
    print("This event is fired when the player closes the character creator from mode:", mode)
end)
```

## Testing & Linting

This resource runs inside RedM, so many files depend on native runtime globals and RedM-specific syntax. For local automation, this repository now includes:

- **Unit tests** with [Busted](https://olivinelabs.com/busted/) for portable modules
- **Mocked RedM natives** in `spec/spec_helper.lua` (for example `AddEventHandler` and `GetCurrentResourceName`)
- **Linting** with [Luacheck](https://github.com/lunarmodules/luacheck) for files compatible with standard Lua parsing

### Local setup

Install Lua 5.4 and LuaRocks, then install tooling:

```bash
luarocks install busted
luarocks install luacheck
```

### Run tests

From the repository root:

```bash
REPO_ROOT="$(pwd)" busted --helper spec/spec_helper.lua spec
```

### Run lint

```bash
luacheck --std lua54 --no-unused-args \
  --globals SignalBus Utils AddEventHandler GetCurrentResourceName msgpack CreatorConfig \
  -- client/signals.lua client/utils.lua spec/spec_helper.lua
```

### CI workflow

GitHub Actions runs both commands automatically in:

`/home/runner/work/RedM-Native-Character-Creator/RedM-Native-Character-Creator/.github/workflows/lua-tests-and-lint.yml`

## Attribution

This project builds upon the hard work and research of many talented individuals in the RedM community. Their contributions made this Native Character Creator implementation possible:

- [alloc8or's Native DB](https://alloc8or.re/rdr3/nativedb/)
- [femga's RDR3 Discoveries](https://github.com/femga/rdr3_discoveries/)
- [gottfriedleibniz's Data View implementation](https://github.com/gottfriedleibniz)
- [MagnarRDC's Support](https://x.com/magnarrdc)

## Contributing

Thank you for considering contributing to Native Character Creator! Please note that this project is released with a [Contributor Covenant Code of Conduct](https://github.com/Senexis/RedM-Native-Character-Creator/blob/main/CODE_OF_CONDUCT.md). By participating in any way in this project, you agree to abide by its terms.

Before contributing, please take a moment to read the [Contribution Guide](https://github.com/Senexis/RedM-Native-Character-Creator/blob/main/CONTRIBUTING.md) to understand the development process and how to contribute.
