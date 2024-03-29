scope Test initializer init
	
	private function action takes nothing returns nothing
		call DangerArea_Create(GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]), 300, 3 )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope