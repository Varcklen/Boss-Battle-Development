scope Test initializer init
	
	private function action takes nothing returns nothing
		set DB_SetItems[3][1] = 'I0EE'
	    set DB_SetItems[3][2] = 'IZ08'
	    set udg_DB_SetItems_Num[3] = 2
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope