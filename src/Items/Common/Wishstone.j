scope Wishstone initializer init

	globals
		private constant integer ITEM_ID = 'I061'
	endglobals
	
	private function condition takes nothing returns boolean
		return inv(Event_ItemRewardCreate_Hero, ITEM_ID) > 0 and ItemCreate_ItemPosition(Event_ItemRewardCreate_Position, 2)
	endfunction
	
	private function action takes nothing returns nothing
		set Event_ItemRewardCreate_ItemReward = udg_DB_Item_Destroyed[GetRandomInt(1,udg_Database_NumberItems[29])]
	endfunction
	
	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_ItemRewardCreate_Real", function action, function condition )
	endfunction

endscope