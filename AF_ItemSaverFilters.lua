--[[
    This function handles the actual filtering. Use whatever parameters for "GetFilterCallback..."
    and whatever logic you need to in "function( slot )". A return value of true means the item in
    question will be shown while the filter is active.
  ]]
local function GetFilterCallbackForSaved()
	return function(slot)
		return ItemSaver_IsItemSaved(slot.bagId, slot.slotIndex)
	end
end

--[[
    This table is processed within Advanced Filters and its contents are added to Advanced Filters'
    callback table. The string value for name is the relevant key for the language table.
  ]]
local ItemSaverDropdownCallback = {
	[1] = { name = "Saved", filterCallback = GetFilterCallbackForSaved() }
}

--[[
    There are four potential tables for this section each covering either english, german, french,
    or russian. Only english is required. If other language tables are not included, the english
    table will automatically be used for those languages. All languages must share common keys.
  ]]
local strings = {
	["Saved"] = "Saved Items",
}

--[[
    This section packages the data for Advanced Filters to use.
    All keys are required except for deStrings, frStrings, and ruStrings, as they correspond to
        optional languages. Al language keys are assigned the same table here only to demonstrate
        the key names. You do not need to do this.
    The filterType key expects an ITEMFILTERTYPE constant provided by the game.
    The values for key/value pairs in subfilters can be any of the string keys from lines 127 - 218
        of AdvancedFiltersData.lua (AF_Callbacks table) such as "All", "OneHanded", "Body", or
        "Blacksmithing".
    If your filterType is ITEMFILTERTYPE_ALL then subfilters must only contain the value "All".
  ]]
local filterInformation = {
  callbackTable = ItemSaverDropdownCallback,
  filterType = ITEMFILTERTYPE_ALL,
  subfilters = {
    [1] = "All",
  },
  enStrings = strings,
}

--[[
    Register your filters by passing your filter information to this function.
  ]]
AdvancedFilters_RegisterFilter(filterInformation)
