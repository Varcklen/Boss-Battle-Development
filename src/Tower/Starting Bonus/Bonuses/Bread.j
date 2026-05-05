scope Bread initializer init

	globals
		private integer ITEM_TYPE = 'IV01'
		private integer GOLD_GAIN = 350
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		call moneyst(GetManipulatingUnit(), GOLD_GAIN)
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope