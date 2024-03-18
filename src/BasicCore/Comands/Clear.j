scope Clear initializer init

	private function action takes nothing returns nothing
		if GetLocalPlayer() == GetTriggerPlayer() then
	    	call ClearTextMessages()
    	endif
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local integer i = 0
	    local trigger trig = CreateTrigger()
	    loop
	        exitwhen i > 3
	        call TriggerRegisterPlayerChatEvent( trig, Player(i), "-clear", true )
	        set i = i + 1
	    endloop
	    call TriggerAddAction( trig, function action )
	    
	    set trig = null
	endfunction

endscope