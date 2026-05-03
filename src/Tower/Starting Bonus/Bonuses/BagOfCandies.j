scope BagOfCandies initializer init

	globals
		private integer ITEM_TYPE = 'IV00'
		
		private integer HASH_KEY = StringHash( "free_exchange_bonus" )
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local player usedPlayer = GetOwningPlayer(GetManipulatingUnit())
		local integer id = GetHandleId(usedPlayer)

		call SaveBoolean(udg_hash, id, HASH_KEY, true)
		
		set usedPlayer = null
	endfunction
	
	private function OnExchange_Condition takes nothing returns boolean
		return Event_ItemExchange_Initiator == Event_ItemExchange_Hero and LoadBoolean(udg_hash, GetHandleId( GetOwningPlayer(Event_ItemExchange_Hero) ), HASH_KEY)
	endfunction

	private function OnExchange takes nothing returns nothing
		local player mainPlayer = GetOwningPlayer(Event_ItemExchange_Hero)
		local player friendPlayer = GetOwningPlayer(Event_ItemExchange_Friend)
		
		call SetPlayerState( mainPlayer, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState( mainPlayer, PLAYER_STATE_RESOURCE_GOLD) + ExchangeCost)
		call SetPlayerState( friendPlayer, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState( friendPlayer, PLAYER_STATE_RESOURCE_GOLD) + ExchangeCost)

		set mainPlayer = null
		set friendPlayer = null
	endfunction
	
	/*real Event_ItemExchange_Real = 0
	    item Event_ItemExchange_Item
	    item Event_ItemExchange_OldItem
	    unit Event_ItemExchange_Hero
	    unit Event_ItemExchange_Friend*/

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	    
	    call CreateEventTrigger( "Event_ItemExchange_Real", function OnExchange, function OnExchange_Condition )
	endfunction

endscope