scope BloomingWeed initializer init

	globals
		private constant integer ITEM_ID = 'I0FT'
	endglobals
	
	//=================================================================================
	private function ItemRewardCreate_Condition takes nothing returns boolean
		return inv(Event_ItemRewardCreate_Hero, ITEM_ID) > 0
	endfunction

	private function OnItemRewardCreate takes nothing returns nothing
        call ItemRandomizerLib_OfferItemLater( Event_ItemRewardCreate_Hero, DB_SetItems[7][GetRandomInt( 1, udg_DB_SetItems_Num[7] ) ] )
	endfunction
	
	//=================================================================================
	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_ItemRewardCreate_Real", function OnItemRewardCreate, function ItemRewardCreate_Condition )
	endfunction

endscope