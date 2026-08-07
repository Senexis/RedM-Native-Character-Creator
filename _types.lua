---@meta

--- @class ShopApi
ShopApi = {}

--- Registers a static menu structure.
--- @param menuData table The menu configuration and items.
--- @param dataSources table? Optional data providers for the menu items.
--- @param ... any Additional passthrough arguments.
--- @return string objectId The registered menu ID.
function ShopApi.Register(menuData, dataSources, ...) end

--- Registers a dynamic menu item generator.
--- @param rootId string The starting point ID for this generator.
--- @param generator function The function called to build items.
--- @param dataSources table? Optional data providers.
--- @param ... any Additional passthrough arguments.
--- @return string objectId The registered generator ID.
function ShopApi.RegisterDynamic(rootId, generator, dataSources, ...) end

--- Overrides items in an existing menu.
--- @param objectId string The ID of the menu to modify.
--- @param newItems table The new items to inject.
--- @param ... any Additional passthrough arguments.
function ShopApi.OverrideMenuItems(objectId, newItems, ...) end

--- Removes a registration for the current resource.
--- @param ... any Optional: resourceName string.
function ShopApi.Unregister(...) end

--- Clears any active item overrides for a specific menu.
--- @param ... any Required: menuId string.
function ShopApi.ClearMenuOverride(...) end

--- Sets whether a specific menu is visible in the navigator.
--- @param ... any Required: menuId string, isVisible boolean.
function ShopApi.SetMenuVisibility(...) end

--- Returns the ID of the initial root menu.
--- @param ... any
--- @return string|nil
function ShopApi.GetInitialRootId(...) end

--- Restores the navigator to its default state.
--- @param ... any
function ShopApi.Restore(...) end

--- Forces the navigator to enter a specific menu.
--- @param ... any Required: menuId string.
function ShopApi.NavigateInto(...) end

--- Goes back to the previous menu in the history stack.
--- @param ... any
function ShopApi.NavigateBack(...) end

--- Returns to the root of the current navigation tree.
--- @param ... any
function ShopApi.NavigateRoot(...) end

--- Navigates specifically via Tab index.
--- @param ... any Required: tabIndex number.
function ShopApi.NavigateTabs(...) end

--- Returns information about the currently active tab.
--- @param ... any
--- @return table
function ShopApi.GetTabInfo(...) end

--- Returns the number of items in a menu.
--- @param ... any Optional: menuId string.
--- @return number
function ShopApi.GetItemCount(...) end

--- Returns a list of all items in the current active menu.
--- @param ... any
--- @return table[]
function ShopApi.GetCurrentItems(...) end

--- Returns an item from a menu by its index.
--- @param ... any Required: index number, Optional: menuId string.
--- @return table|nil
function ShopApi.GetItemByIndex(...) end

--- Returns an item from a menu by its unique ID.
--- @param ... any Required: itemId string, Optional: menuId string.
--- @return table|nil
function ShopApi.GetItemById(...) end

--- Returns the full menu object currently active.
--- @param ... any
--- @return table|nil
function ShopApi.GetCurrentMenu(...) end

--- Returns the ID of the current active menu.
--- @param ... any
--- @return string|nil
function ShopApi.GetCurrentMenuId(...) end

--- Returns the root menu object for the current level.
--- @param ... any
--- @return table|nil
function ShopApi.GetRootMenu(...) end

--- Returns the ID of the root menu.
--- @param ... any
--- @return string|nil
function ShopApi.GetRootMenuId(...) end

--- Finds the root ID associated with a specific menu.
--- @param ... any Required: menuId string.
--- @return string|nil
function ShopApi.GetRootIdForMenu(...) end

--- Finds the parent ID for a specific menu.
--- @param ... any Required: menuId string.
--- @return string|nil
function ShopApi.GetParentIdForMenu(...) end

--- Returns the menu ID that linked to the current menu.
--- @param ... any
--- @return string|nil
function ShopApi.GetLinkedFromMenuId(...) end

--- Returns the text entry for the current title.
--- @param ... any
--- @return string
function ShopApi.GetCurrentTitleEntry(...) end

--- Returns the text entry for the current subtitle.
--- @param ... any
--- @return string
function ShopApi.GetCurrentSubtitleEntry(...) end

--- Opens the Shop UI.
--- @param ... any
function ShopApi.Open(...) end

--- Hides the Shop UI (maintains state).
--- @param ... any
function ShopApi.Hide(...) end

--- Closes and exits the Shop UI.
--- @param ... any
function ShopApi.Close(...) end

--- Disables a specific item.
--- @param ... any Required: itemId string.
function ShopApi.DisableItem(...) end

--- Enables a previously disabled item.
--- @param ... any Required: itemId string.
function ShopApi.EnableItem(...) end

--- Refreshes the display of the current menu.
--- @param ... any
function ShopApi.RefreshMenu(...) end

--- Refreshes the navigator from the root.
--- @param ... any
function ShopApi.RefreshRoot(...) end

--- Invalidates cache and pulls fresh data from sources.
--- @param ... any
function ShopApi.RefreshData(...) end

--- Sets a custom footer text for the menu.
--- @param ... any Required: text string.
function ShopApi.SetMenuFooter(...) end

--- Clears the custom footer override for the menu.
--- @param ... any
function ShopApi.ClearMenuFooter(...) end

--- Sets a custom footer for a specific item.
--- @param ... any Required: itemId string, text string.
function ShopApi.SetItemFooter(...) end

--- Clears custom footer for a specific item.
--- @param ... any Required: itemId string.
function ShopApi.ClearItemFooter(...) end
