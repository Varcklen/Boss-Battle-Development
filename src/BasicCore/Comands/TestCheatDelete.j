/*scope TestShieldC initializer init

	private function action takes nothing returns nothing
		call UnitAddItemById(udg_hero[1], 'I0GO')
		call UnitAddItemById(udg_hero[1], 'I0HP')
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local integer i = 0
	    local trigger trig = CreateTrigger()
	    loop
	        exitwhen i > 3
	        call TriggerRegisterPlayerChatEvent( trig, Player(i), "-testshield", true )
	        set i = i + 1
	    endloop
	    call TriggerAddAction( trig, function action )
	    
	    set trig = null
	endfunction

endscope*/