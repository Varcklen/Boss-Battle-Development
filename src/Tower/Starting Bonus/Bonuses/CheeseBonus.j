scope CheeseBonus initializer init

	globals
		private integer ITEM_TYPE = 'IV09'
		private real MESSAGE_DURATION = 10
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local player user = GetOwningPlayer(GetManipulatingUnit())
		local integer index = GetPlayerId(user) + 1
		local Mode mode = ModeSystem_GetRandomBless(false)
		local string modeName

		if mode == 0 then
			set user = null
			return
		endif
		
		set modeName = BlzGetAbilityTooltip(mode.Info, 0)
		set modeName = SubStringBJ(modeName, 23, StringLength(modeName))
		
		call ModeSystem_Enable(mode)
		call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, MESSAGE_DURATION, udg_Player_Color[index] + GetPlayerName(user) + "|r has enabled the \"|cffffcc00" + modeName + "|r\" blessing." )

		set user = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope