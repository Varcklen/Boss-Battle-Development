scope CurseDebt initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function action takes nothing returns nothing
		local integer i = 0
		local player user = null
		local integer debtAdded = 15 * (udg_Boss_LvL - 1)
		local integer currentDebt
		
		loop
			exitwhen i >= 4
			set user = Player(i)
			if GetPlayerSlotState(user) == PLAYER_SLOT_STATE_PLAYING then
				set currentDebt = Money_AddDebt( user, debtAdded )
				call DisplayTimedTextToPlayer( user, 0, 0, 10, "|cffffcc00Debt Curse|r: Debt added: " + I2S(debtAdded) + ". Current Debt: " + I2S(currentDebt) + "." )
			endif
			set i = i + 1
		endloop
		
		set user = null
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "Event_MainBattleWin", function action, null )
		call DisableTrigger( Trigger )
	endfunction

endscope