scope Chupa initializer init

	globals
		private constant integer ITEM_TYPE = 'IV01'
		private constant integer HEALTH_GAIN = 25
		
		private constant integer HASH_KEY = StringHash( "chupa_bonus" )
		private string ICON_FRAME = "war3mapImported\\BTNAbility_Mage_NetherWindPresence_result.blp"
		private constant string DESCRIPTION = "When these players split the artifact, they will receive 25 Health: "
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local player usedPlayer = GetOwningPlayer(GetManipulatingUnit())
		local integer index = GetPlayerId(usedPlayer) + 1
		local integer id = GetHandleId(usedPlayer)
		local string characters = LoadStr(udg_hash, id, HASH_KEY)
		
		if characters != null then
			set characters = characters + ", "
		endif
		set characters = characters + udg_Player_Color[index] + GetPlayerName(usedPlayer) + "|r"
		call SaveStr(udg_hash, id, HASH_KEY, characters)

		call SaveBoolean(udg_hash, id, HASH_KEY, true)
		call IconFrame( "Chupa", ICON_FRAME, GetItemName(GetManipulatedItem()), DESCRIPTION + characters )
		
		set usedPlayer = null
	endfunction

	private function OnSplit_Condition takes nothing returns boolean
		return LoadBoolean(udg_hash, GetHandleId( GetOwningPlayer(Event_ItemSplit_Hero) ), HASH_KEY) and GetItemType(Event_ItemSplit_Item) != ITEM_TYPE_POWERUP
	endfunction

	private function OnSplit takes nothing returns nothing
		local unit hero = Event_ItemSplit_Hero
		
		call BlzSetUnitMaxHP( hero, BlzGetUnitMaxHP(hero) + HEALTH_GAIN )

		set hero = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	    
	    call CreateEventTrigger( "Event_ItemSplit_Real", function OnSplit, function OnSplit_Condition )
	endfunction

endscope