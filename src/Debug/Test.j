scope Test initializer init
	
	private function action takes nothing returns nothing
		local effect particle
		local unit c = udg_hero[1]
    
        set particle = AddSpecialEffectTarget( "war3mapImported\\Guading_teamsign_red.mdx", c, "overhead" )
        call BlzSetSpecialEffectZ( particle, 700 )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope