library BattleStart requires DeathSystem, ResLib, Inventory, TimebonusLib, TimePlayLib
	
	globals
		integer Event_FightStart_Index
	
		real Event_FightStart_DelayUnit = 0
		unit Event_FightStart_DelayUnit_Hero
		integer Event_FightStart_DelayUnit_Index 
		player Event_FightStart_DelayUnit_Player
	endglobals
	
	function FightStart_Delay takes nothing returns nothing
		local integer i = 1
		local player playerCheck
		
		set i = 1
	    loop
	        exitwhen i > 4
	        set playerCheck = Player( i - 1 )
	        if GetPlayerSlotState( playerCheck ) == PLAYER_SLOT_STATE_PLAYING then
				set Event_FightStart_DelayUnit_Hero = udg_hero[i]
				set Event_FightStart_DelayUnit_Index = i
				set Event_FightStart_DelayUnit_Player = playerCheck
				set Event_FightStart_DelayUnit = 1
				set Event_FightStart_DelayUnit = 0
	        endif
	        set i = i + 1
	    endloop
	    
	    set playerCheck = null
	endfunction
	
	private function PlayerAction takes unit hero, player owner, integer index returns nothing
        call BlzSetUnitRealFieldBJ( hero, UNIT_RF_ACQUISITION_RANGE, 900 )
        call SelectUnitForPlayerSingle( hero, owner )

        set udg_combatlogic[index] = true
        
        set udg_FightStart_Unit = hero
        set Event_FightStart_Index = index
        set udg_FightStart_Real = 1
        set udg_FightStart_Real = 0
        
        call BattleStart.SetDataUnit("caster", hero)
        call BattleStart.SetDataInteger("index", index)
        call BattleStart.SetDataPlayer("owner", owner )
        call BattleStart.Invoke()
	endfunction
	
	function FightStart takes nothing returns nothing
		local integer i
	
	    set udg_fightmod[0] = true
	
		set udg_FightStartGlobal_Real = 0.00
	    set udg_FightStartGlobal_Real = 1.00
	    set udg_FightStartGlobal_Real = 0.00
	    
	    call BattleStartGlobal.Invoke()
	
	    set i = 1
	    loop
	        exitwhen i > 4
	        call BlzFrameSetVisible( iconframe[i], false)
	        if GetPlayerSlotState( Player( i - 1 ) ) == PLAYER_SLOT_STATE_PLAYING then
	        	call PlayerAction(udg_hero[i], Player( i - 1 ), i )
	        endif
	        set i = i + 1
	    endloop

		call TimerStart(CreateTimer(), 0.1, false, function FightStart_Delay )
	endfunction
	
endlibrary