scope FestiveCake initializer init

	globals
		private integer ITEM_TYPE = 'IV01'
	endglobals
	
	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		local player user = GetOwningPlayer(hero)

		call BlzSetUnitMaxHP( hero, BlzGetUnitMaxHP(hero) + 300 )
		call BlzSetUnitMaxMana( hero, BlzGetUnitMaxMana(hero) + 100 )
		call ItemRandomizerLib_AddRewardSelectionOption(user, -2)
		
		set hero = null
		set user = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope