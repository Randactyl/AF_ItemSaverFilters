local function GetFilterCallbackForSaved()
	return function(slot)
		return ItemSaver_IsItemSaved(slot.bagId, slot.slotIndex)
	end
end

local ItemSaverDropdownCallback = {
	[1] = { name = "Saved", filterCallback = GetFilterCallbackForSaved() }
}

local strings = {
	["Saved"] = "Saved Items",
}

local filterInformation = {
  callbackTable = ItemSaverDropdownCallback,
  filterType = ITEMFILTERTYPE_ALL,
  subfilters = {
    [1] = "All",
  },
  enStrings = strings,
}

AdvancedFilters_RegisterFilter(filterInformation)
