scope CheatCreate initializer init

	globals
		trigger trig_CheatCreate	
	endglobals

	private function action takes nothing returns nothing
		local unit temp
		local integer i
		
	    set temp = CreateUnitAtLoc( Player(1), 'N00N', OffsetLocation(GetRectCenter(gg_rct_HeroTp), -120.00, 120.00), bj_UNIT_FACING )
		//set udg_hero[2] = temp
		call HeroesChoise_SetHero(temp, Player(1), 11, 2)

	    set temp = CreateUnitAtLoc( Player(2), 'N04H', OffsetLocation(GetRectCenter(gg_rct_HeroTp), 0.00, 120.00), bj_UNIT_FACING )
	    //set udg_hero[3] = temp
	    call HeroesChoise_SetHero(temp, Player(2), 52, 6)
        
	    set temp = CreateUnitAtLoc( Player(3), 'N01M', OffsetLocation(GetRectCenter(gg_rct_HeroTp), 120.00, 120.00), bj_UNIT_FACING )
	    //set udg_hero[4] = temp
	    call HeroesChoise_SetHero(temp, Player(3), 6, 7)
	    
	    /*set udg_Ability_Uniq[2] = 'A0AG'
	    set udg_Ability_Uniq[3] = 'A0GC'
	    set udg_Ability_Uniq[4] = 'A0AG'
	    call SetUnitUserData(udg_hero[2], 2)
	    call SetUnitUserData(udg_hero[3], 3)
	    call SetUnitUserData(udg_hero[4], 4)
	    call SaveReal(udg_hash, GetHandleId(udg_hero[2]), StringHash("spd"), 1 )
	    call SaveReal(udg_hash, GetHandleId(udg_hero[3]), StringHash("spd"), 1 )
	    call SaveReal(udg_hash, GetHandleId(udg_hero[4]), StringHash("spd"), 1 )
	    set i = 1
	    loop
	        exitwhen i > 4
	        if udg_hero[i] != null then
	            set udg_combatlogic[i] = true
	            call DeathSystem_DEBUG(udg_hero[i])
	            call GroupAddUnitSimple( udg_hero[i], udg_heroinfo )
	        endif
	        set i = i + 1
	    endloop*/
	    set temp = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set trig_CheatCreate = CreateTrigger(  )
	    call DisableTrigger( trig_CheatCreate )
	    call TriggerRegisterPlayerChatEvent( trig_CheatCreate, Player(0), "-create", true )
	    call TriggerAddAction( trig_CheatCreate, function action )
	endfunction

endscope