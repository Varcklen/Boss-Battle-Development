scope BonusCollector initializer init

	globals
		private constant integer STRING_HASH = StringHash( "bonus_collector" )
	endglobals

	private function condition takes nothing returns boolean
	    return inv(GetManipulatingUnit(), 'I01F') > 0 and GetItemTypeId(GetManipulatedItem()) != 'I01F' and RandomBonus_IsWithRandomBonus(GetManipulatedItem()) and LoadBoolean( udg_hash, GetHandleId(GetManipulatedItem()), STRING_HASH ) == false
	endfunction
	
	private function action takes nothing returns nothing
	    call RandomBonus_Add(GetManipulatedItem())
	    call RandomBonus_Add(GetManipulatedItem())
	    call SaveBoolean( udg_hash, GetHandleId(GetManipulatedItem()), STRING_HASH, true )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope