scope Test initializer init
	
	private function action takes nothing returns nothing
		local effect particle
		local unit hero = udg_hero[1]
    
    
    	//call BJDebugMsg("usual: " + GetUnitName( randomtarget( hero, 400, "ally", 0, 0, 0 ) ) )
    	
    	/*call BJDebugMsg("RT_ORGANIC: " + GetUnitName( randomtarget( hero, 400, "ally", RT_ORGANIC, 0, 0 ) ) )
    	call BJDebugMsg("RT_NOT_CASTER: " + GetUnitName( randomtarget( hero, 400, "ally", RT_NOT_CASTER, 0, 0 ) ) )
    	call BJDebugMsg("RT_MINION: " + GetUnitName( randomtarget( hero, 400, "ally", RT_MINION, 0, 0 ) ) )
    	call BJDebugMsg("RT_HERO: " + GetUnitName( randomtarget( hero, 400, "ally", RT_HERO, 0, 0 ) ) )
    	call BJDebugMsg("RT_NOT_FULL_HEALTH: " + GetUnitName( randomtarget( hero, 400, "ally", RT_NOT_FULL_HEALTH, 0, 0 ) ) )
    	call BJDebugMsg("RT_VULNERABLE: " + GetUnitName( randomtarget( hero, 400, "ally", RT_VULNERABLE, 0, 0 ) ) )
    	call BJDebugMsg("RT_CAN_MOVE: " + GetUnitName( randomtarget( hero, 400, "ally", RT_CAN_MOVE, 0, 0 ) ) )
    	call BJDebugMsg("RT_NOT_PROVOKED: " + GetUnitName( randomtarget( hero, 400, "ally", RT_NOT_PROVOKED, 0, 0 ) ) )*/
    	
    	call BJDebugMsg("Seed change")
    	call SetRandomSeed(1234)
    	
    	
        //set particle = AddSpecialEffectTarget( "war3mapImported\\Guading_teamsign_blue.mdx", c, "overhead" )
        //call BlzSetSpecialEffectZ( particle, 700 )
        
        /*call IndicatorSystem_Create( INDICATOR_AIM, GetUnitX(hero), GetUnitY(hero), 200, 3 )
        call IndicatorSystem_Create( INDICATOR_AIM, GetUnitX(hero), GetUnitY(hero), 100, 3 )
        call IndicatorSystem_Create( INDICATOR_AIM, GetUnitX(hero), GetUnitY(hero), 300, 3 )*/
        
        //call SetRaritySpawn(33, 33)
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope