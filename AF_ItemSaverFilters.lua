--See AdvancedFilters/extrafilters/LevelFilters.lua for basic information.
local IS_NAME
local prefix = "AF_ISF_"

local function getFilterCallbackForSet(setName)
    return function(slot)
        local bagId = slot.bagId
        local slotIndex = slot.slotIndex

        if not bagId or not slotIndex then return false end

        local _, savedSet = ItemSaver_IsItemSaved(bagId, slotIndex)

        return setName == savedSet
    end
end

--[[----------------------------------------------------------------------------
    This is an example of an callback information generator function which can
    be supplied to Advanced Filters' registration function instead of separate
    callback and strings tables.
    This case should be used when filter options need to be updated during
    runtime, after the addon loaded event.
    This function will be called every time a subfilter button is activated
    (inventory open/close, filter switched, subfilter switched).
    This function is expected to return two tables - an array of callback
    entries and a table of strings.
    This function does not accept any arguments.
--]]----------------------------------------------------------------------------
local function generator()
    local dropdownCallbacks = {
        {name = prefix.."NoSet", filterCallback = getFilterCallbackForSet(nil)},
    }
    local strings = {
        --remember to provide a string for your submenu label if using one.
        [prefix..IS_NAME] = IS_NAME,
        [prefix.."NoSet"] = "Not Saved",
    }

    local setNames = ItemSaver_GetSaveSets()

    for _, setName in ipairs(setNames) do
        local dropdownCallback = {
            name = prefix..setName,
            filterCallback = getFilterCallbackForSet(setName)
        }

        table.insert(dropdownCallbacks, dropdownCallback)
        strings[prefix..setName] = setName
    end

    return dropdownCallbacks, strings
end

--[[----------------------------------------------------------------------------
    When using a generator function, the filterInformation package should not
    include the callbackTable key or any of the xxStrings keys.
--]]----------------------------------------------------------------------------
local function onLoaded(eventCode, addonName)
    if addonName ~= "AF_ItemSaverFilters" then return end

    IS_NAME = GetString(SI_ITEMSAVER_ADDON_NAME)

    filterInformation = {
        submenuName = prefix..IS_NAME,
        filterType = ITEMFILTERTYPE_ALL,
        subfilters = {"All"},
        generator = generator,
    }

    AdvancedFilters_RegisterFilter(filterInformation)
end
EVENT_MANAGER:RegisterForEvent("AF_ISF_OnLoaded", EVENT_ADD_ON_LOADED, onLoaded)