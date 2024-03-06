scope ExchangerData initializer init

	globals
		unit array ExchangerUnit[PLAYERS_LIMIT]
	endglobals
	
	private function setData takes nothing returns nothing
		set ExchangerUnit[0] = udg_UNIT_EXCHANGER_RED
        set ExchangerUnit[1] = udg_UNIT_EXCHANGER_BLUE
        set ExchangerUnit[2] = udg_UNIT_EXCHANGER_TEAL
        set ExchangerUnit[3] = udg_UNIT_EXCHANGER_PURPLE
	endfunction

	private function init takes nothing returns nothing
        local trigger trig = CreateTrigger(  )
	    call TriggerRegisterTimerExpireEvent( trig, udg_StartTimer )
	    call TriggerAddAction( trig, function setData )
    endfunction

endscope