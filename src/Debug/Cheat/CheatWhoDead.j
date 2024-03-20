scope CheatWhoDead initializer init

	globals
		trigger trig_CheatWhoDead = null
	endglobals

	private function action takes nothing returns nothing
	    local group g = DeathSystem_GetAliveHeroGroupCopy()
		local unit u
		local integer i = 1
		
		call BJDebugMsg("|cffffcc00=====================================|r")
		call BJDebugMsg("ALIVE" )
		loop
        	set u = FirstOfGroup(g)
        	exitwhen u == null
	        call BJDebugMsg("Unit #" + I2S(i) + ": " + GetUnitName(u))
	        set i = i + 1
	        call GroupRemoveUnit(g,u)
	    endloop
	    
		call BJDebugMsg("------------------------------------------------")
		call BJDebugMsg("DEAD" )
		set g = DeathSystem_GetDeadHeroGroupCopy()
		loop
        	set u = FirstOfGroup(g)
        	exitwhen u == null
	        call BJDebugMsg("Unit #" + I2S(i) + ": " + GetUnitName(u))
	        set i = i + 1
	        call GroupRemoveUnit(g,u)
	    endloop
		
		call DestroyGroup(g)
	endfunction

	private function init takes nothing returns nothing
	    set trig_CheatWhoDead = CreateTrigger()
	    call DisableTrigger( trig_CheatWhoDead )
	    call TriggerRegisterPlayerChatEvent( trig_CheatWhoDead, Player(0), "-who", false )
	    call TriggerAddAction( trig_CheatWhoDead, function action )
	endfunction

endscope