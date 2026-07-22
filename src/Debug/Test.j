scope Test initializer init
	
	private function action takes nothing returns nothing
		call BJDebugMsg("Test Enable")
		call IndicatorSystem_Create( INDICATOR_SAFE, GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]), 100, 5, null )
		call IndicatorSystem_Create( INDICATOR_AIM, GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]), 100, 5, null )
		
		//call AddSpecialEffect( "war3mapImported\\Magic_Aura_02.mdx", GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]) )
		//call AddSpecialEffect( "Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl", GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]) )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-t", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope