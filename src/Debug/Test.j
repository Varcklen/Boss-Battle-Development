scope Test initializer init
	
	private function action takes nothing returns nothing
		local group g = DeathSystem_GetAliveHeroGroupCopy()
		local unit u
		local integer i = 1
		
		call BJDebugMsg("TEST START " + I2S(GetRandomInt(1000,9999)))
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
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope