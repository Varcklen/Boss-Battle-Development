scope TimerExpireWarning initializer init

	private function action takes nothing returns nothing
	    call DisplayTimedTextToForce( GetPlayersAll(), 10, "|cffffcc00Warning!|r 20 seconds left before the battle starts!" )
	    call StartSound(gg_snd_Warning)
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterTimerExpireEvent( trig, OutOfCombatTimer_TimerWarning )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope