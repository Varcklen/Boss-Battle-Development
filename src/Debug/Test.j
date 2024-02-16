scope Test initializer init
	
	private function action takes nothing returns nothing
		if udg_logic[0] == false then
			return
		endif
	
	    call BJDebugMsg("Test")
	    //call CreateItem('I0H9', GetUnitX( udg_UNIT_JULE ), GetUnitY( udg_UNIT_JULE ) )
	    //call CreateItem('I007', GetUnitX( udg_UNIT_JULE ), GetUnitY( udg_UNIT_JULE ) )
	    call KillUni
	endfunction
	Z
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope