scope StartingBonusAnimation initializer init

	private function condition takes nothing returns boolean
		return GetItemType(GetManipulatedItem()) == ITEM_TYPE_CHARGED
	endfunction

	private function action takes nothing returns nothing
		call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl", GetUnitX(GetManipulatingUnit()), GetUnitY(GetManipulatingUnit()) ) )
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope