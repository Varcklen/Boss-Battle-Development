scope CheatKill initializer init

	globals
		trigger CheatKill = null
	endglobals

	private function action takes nothing returns nothing
		local integer i = 1
	    call BJDebugMsg("All heroes died.")
	    
	    loop
	    	exitwhen i > 4
	    	if udg_hero[i] != null then
	    		call KillUnit(udg_hero[i])
	    	endif
	    	set i = i + 1
    	endloop
	endfunction

	private function init takes nothing returns nothing
	    set CheatKill = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( CheatKill, Player(0), "-kill", false )
	    call TriggerAddAction( CheatKill, function action )
	endfunction

endscope