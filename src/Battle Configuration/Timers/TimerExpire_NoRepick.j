scope TimerExpireNoRepick initializer init

	private function action takes nothing returns nothing
	    set udg_logic[9] = true
	    call BlzFrameSetVisible( rpkmod,false)
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterTimerExpireEvent( trig, OutOfCombatTimer_RepickDisableTimer )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope