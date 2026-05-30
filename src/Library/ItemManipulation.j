library ItemManipulation

	public function IsInventoryFull takes unit hero returns boolean
		return UnitInventoryCount(hero) >= UnitInventorySize(hero)
	endfunction

	public function AddItemToHeroOrRestroom takes unit hero, integer itemType returns item
		local item newItem
		local integer playerId = GetPlayerId(GetOwningPlayer(hero))
		
		set newItem = CreateItem(itemType, GetUnitX(hero), GetUnitY(hero))
		if IsInventoryFull(hero) then
			call SetItemPositionLoc( newItem, udg_point[22 + playerId] )
    	else
    		call UnitAddItem(hero, newItem)
    	endif
        
        return newItem
	endfunction
	
	public function IsArtifact takes item itemToCheck returns boolean
		local itemtype itenType = GetItemType(itemToCheck)
		
		if itenType == ITEM_TYPE_ARTIFACT then
			return true
		elseif itenType == ITEM_TYPE_CAMPAIGN then
			return true
		elseif itenType == ITEM_TYPE_PERMANENT then
			return true
		endif
		return false
	endfunction

endlibrary