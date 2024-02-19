scope Test initializer init
	
	private function action takes nothing returns nothing
		call NewSpecial( udg_hero[1], 'A0Z4' )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope