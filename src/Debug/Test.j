scope Test initializer init
	
	private function action takes nothing returns nothing
		local effect particle
		local unit hero = udg_hero[1]
    
        //set particle = AddSpecialEffectTarget( "war3mapImported\\Guading_teamsign_blue.mdx", c, "overhead" )
        //call BlzSetSpecialEffectZ( particle, 700 )
        
        /*call IndicatorSystem_Create( INDICATOR_AIM, GetUnitX(hero), GetUnitY(hero), 200, 3 )
        call IndicatorSystem_Create( INDICATOR_AIM, GetUnitX(hero), GetUnitY(hero), 100, 3 )
        call IndicatorSystem_Create( INDICATOR_AIM, GetUnitX(hero), GetUnitY(hero), 300, 3 )*/
        
        call SetRaritySpawn(33, 33)
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope