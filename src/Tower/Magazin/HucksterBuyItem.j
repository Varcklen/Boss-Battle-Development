scope HucksterBuyItem initializer init

	globals
		private constant integer GOLD_COST = 275
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitTypeId(GetSoldUnit()) == 'n029'
	endfunction
	
	private function action takes nothing returns nothing
		local unit buyingUnit = GetBuyingUnit()
		local player user  = GetOwningPlayer(buyingUnit)
		local integer ItemType
		local item itemCreated
		
	    call RemoveUnit( GetSoldUnit() )
	    if ItemManipulation_IsInventoryFull(buyingUnit) then
	    	call ErrorMessage(user, "The inventory is full.")
	        call SetPlayerState(user, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(user, PLAYER_STATE_RESOURCE_GOLD) + GOLD_COST )
	    else
	        call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", buyingUnit, "origin") )
	        set ItemType = ItemRandomizerLib_GetRandomExileItemType()
	        set itemCreated = CreateItem(ItemType, GetUnitX(buyingUnit), GetUnitY(buyingUnit) )
            call UnitAddItem( buyingUnit, itemCreated )
        endif
	    
	    set itemCreated = null
	    set user = null
	    set buyingUnit = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SELL, function action, function condition )
	endfunction

endscope