library ItemManipulation requires DeathLib
	//ItemManipulation_IsInventoryFull()
	public function IsInventoryFull takes unit hero returns boolean
		return UnitInventoryCount(hero) >= UnitInventorySize(hero)
	endfunction

	public function AddItemToHeroOrRestroom takes unit hero, integer itemType returns item
		local item newItem
		local integer playerId = GetPlayerId(GetOwningPlayer(hero))
		
		set newItem = CreateItem(itemType, GetUnitX(hero), GetUnitY(hero))
		if IsInventoryFull(hero) or IsUnitDead(hero) then
			call SetItemPositionLoc( newItem, udg_point[22 + playerId] )
    	else
    		call UnitAddItem(hero, newItem)
    	endif
        
        return newItem
	endfunction
	
	public function PutItemToHeroOrRestroom takes unit hero, item itemUsed returns nothing
		local integer playerId = GetPlayerId(GetOwningPlayer(hero))

		if IsInventoryFull(hero) or IsUnitDead(hero) then
			call SetItemPositionLoc( itemUsed, udg_point[22 + playerId] )
    	else
    		call UnitAddItem(hero, itemUsed)
    	endif
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
	
	//ItemManipulation_IsLockable()
	public function IsLockable takes item itemToCheck returns boolean
		return BlzGetItemAbility( itemToCheck, 'A1JS' ) != null
	endfunction

endlibrary