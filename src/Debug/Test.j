scope Test initializer init
	
	private function action takes nothing returns nothing
		call BJDebugMsg("udg_rollbase[1]:" + I2S(udg_rollbase[1]))
		
		call AddRewardSelectionOption(Player(i), AMOUNT_OF_REWARD_SELECTIONS_PER_ROUND)
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope