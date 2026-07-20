scope BagOfCandies initializer init

	globals
		private integer ITEM_TYPE = 'IV08'
		
		private constant integer HASH_KEY = StringHash( "free_exchange_bonus" )
		private constant string ICON_FRAME = "war3mapImported\\BTNStartingBonus_9.blp"
		private constant string DESCRIPTION = "Exchanging with these players will give heroes 2 random stats: "
		private constant integer STATS_TO_GAIN = 2
		private constant integer PIECE_TO_GAIN = 1
		
		private string array COLOR
		private string array STAT_NAME
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
		call IconFrame( "BagOfCandies", ICON_FRAME, GetItemName(GetManipulatedItem()), DESCRIPTION + characters )
		
		set usedPlayer = null
	endfunction

	private function GiveStats takes unit hero returns nothing
		local integer i = 1
		local integer array toAdd
		local integer rand
		
		loop
			exitwhen i > STATS_TO_GAIN
			set rand = GetRandomInt( 1, 3 )
			if rand == 1 then
				call statst( hero, PIECE_TO_GAIN, 0, 0, 0, true )
				set toAdd[0] = toAdd[0] + PIECE_TO_GAIN
			elseif rand == 2 then
				call statst( hero, 0, PIECE_TO_GAIN, 0, 0, true )
				set toAdd[1] = toAdd[1] + PIECE_TO_GAIN
			elseif rand == 3 then
				call statst( hero, 0, 0, PIECE_TO_GAIN, 0, true )
				set toAdd[2] = toAdd[2] + PIECE_TO_GAIN
			endif
			set i = i + 1
		endloop
		
		set i = 0
        loop
            exitwhen i > 2
            if toAdd[i] > 0 then
            	call textst( COLOR[i] + "+" + I2S(toAdd[i]) + " " + STAT_NAME[i], hero, 64, 30 + i * 120, 8, 2.5 )
        	endif
        	set i = i + 1
        endloop
	endfunction
	
	//===========================================================================
	private function OnExchange_Condition takes nothing returns boolean
		return LoadBoolean(udg_hash, GetHandleId( GetOwningPlayer(Event_ItemExchange_Hero) ), HASH_KEY)
	endfunction

	private function OnExchange takes nothing returns nothing
		call GiveStats(Event_ItemExchange_Hero)
		call GiveStats(Event_ItemExchange_Friend)
	endfunction

	//===========================================================================
	private function Creation takes nothing returns nothing
		set COLOR[0] = "|c00FF2020"
		set COLOR[1] = "|c0020FF20"
		set COLOR[2] = "|c002020FF"
		
		set STAT_NAME[0] = "strength"
		set STAT_NAME[1] = "agility"
		set STAT_NAME[2] = "intelligence"
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger()
	    call TriggerRegisterTimerEvent( trig, 0.04, false)
	    call TriggerAddAction( trig, function Creation )
	
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	    
	    call CreateEventTrigger( "Event_ItemExchange_Real", function OnExchange, function OnExchange_Condition )
	endfunction

endscope