library StartTimer initializer init

	globals
		timer udg_StartTimer = CreateTimer()
	endglobals

	private function action takes nothing returns nothing
		set udg_Event_StartTimerExpire = 1
		set udg_Event_StartTimerExpire = 0
	endfunction

	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )

		set udg_StartTimer = CreateTimer()
	    call BlzChangeMinimapTerrainTex("map.blp")
	    call StartTimerBJ( udg_StartTimer, false, 0.01 )
	    
	    call TriggerRegisterTimerExpireEvent( trig, udg_StartTimer )
    	call TriggerAddAction( trig, function action )
	endfunction

endlibrary