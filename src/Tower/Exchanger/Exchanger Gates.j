scope ExchangerGates initializer init

	globals
		private destructable array Gates[4]
	endglobals

	private function action takes nothing returns nothing
		local integer i = 0
		
		loop
			exitwhen i >= 4
			//call BJDebugMsg("Gate: " + GetDestructableName(Gates[i]) )
			if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING then
				//call BJDebugMsg("open")
				call KillDestructable(Gates[i])
        		call SetDestructableAnimation(Gates[i], "death alternate")
			endif
			set i = i + 1
		endloop
	endfunction
	
	//===========================================================================
    private function init takes nothing returns nothing
    	local trigger trig = CreateTrigger()
	    call TriggerRegisterTimerEvent( trig, 1, false)
	    call TriggerAddAction( trig, function action )
	    
	    set Gates[0] = udg_EXCHANGE_GATE_RED
	    set Gates[1] = udg_EXCHANGE_GATE_BLUE
	    set Gates[2] = udg_EXCHANGE_GATE_TEAL
	    set Gates[3] = udg_EXCHANGE_GATE_PURPLE
	endfunction

endscope