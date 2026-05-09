scope HuckterChangeItem initializer init

	globals
		private integer UsedSlot = 0
		
		private constant integer GOLD_COST = 200
		private constant string PARTICLE = "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl"
	endglobals

	private function condition takes nothing returns boolean
		local integer itemTypeCheck = GetItemTypeId(GetManipulatedItem())
	    local integer i = 1
	    
	    loop
	        exitwhen i > 6
	        if itemTypeCheck == udg_Database_Score_Item[i] then
	        	set UsedSlot = i
	            return true
	        endif
	        set i = i + 1
	    endloop
	    return false
	endfunction
	
	private function IsItemInvalid takes unit caster, item itemCheck returns boolean
		local integer itemType = GetItemTypeId(itemCheck)
		if UnitHasItem(caster, itemCheck ) == false then
			return true
		elseif GetItemType(itemCheck) == ITEM_TYPE_POWERUP then
			return true
		elseif GetItemType(itemCheck) == ITEM_TYPE_PURCHASABLE then
			return true
		elseif itemType == 'I05J' then
			return true
		elseif itemType == 'I0B5' then
			return true
		endif
		return false
	endfunction
	
	private function action takes nothing returns nothing
	    local item itemCheck = null
	    local item newItem = null
	    local unit caster = GetManipulatingUnit()
	    local player user = GetOwningPlayer(caster)
	    local integer itemType
	    
        set itemCheck = UnitItemInSlot(caster, UsedSlot- 1 )
        set itemType = GetItemTypeId(itemCheck)
        if IsItemInvalid(caster, itemCheck) then
        	call ErrorMessage(user, "You cannot change this item.")
            call SetPlayerState(user, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(user, PLAYER_STATE_RESOURCE_GOLD) + GOLD_COST )
        else
            call RemoveItem( itemCheck )
            call DestroyEffect(AddSpecialEffectTarget( PARTICLE, caster, "origin") )
            set newItem = ItemRandomizerAll( caster, itemType )
            if GetItemTypeId(newItem) == itemType then
	            call SetPlayerState(user, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(user, PLAYER_STATE_RESOURCE_GOLD) + GOLD_COST )
	        endif
        endif
        
        set user = null
	    set caster = null
	    set itemCheck = null
	    set newItem = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope