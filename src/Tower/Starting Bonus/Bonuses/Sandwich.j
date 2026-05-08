scope Sandwich initializer init

	globals
		private integer ITEM_TYPE = 'IV14'
		private integer ADDITIONAL_REWARDS = 1
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local player user = GetOwningPlayer(GetManipulatingUnit())
		
		call ItemRandomizerLib_AddRewardSelectionOption(user, ADDITIONAL_REWARDS)
		
		set user = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope