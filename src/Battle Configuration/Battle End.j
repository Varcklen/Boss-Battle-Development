library BattleEnd requires Inventory, TextLib, UniquesLib, ItemRandomizerLib, SpecialLib
	
	globals
		real Event_FightEnd_Delay = 0
		
		real Event_FightEnd_DelayUnit = 0
		unit Event_FightEnd_DelayUnit_Hero
		integer Event_FightEnd_DelayUnit_Index 
		player Event_FightEnd_DelayUnit_Player
	endglobals
	
	function FightEnd_Delay takes nothing returns nothing
		local integer i = 1
		local player playerCheck
		
		set i = 1
	    loop
	        exitwhen i > 4
	        set playerCheck = Player( i - 1 )
	        if GetPlayerSlotState( playerCheck ) == PLAYER_SLOT_STATE_PLAYING then
				set Event_FightEnd_DelayUnit_Hero = udg_hero[i]
				set Event_FightEnd_DelayUnit_Index = i
				set Event_FightEnd_DelayUnit_Player = playerCheck
				set Event_FightEnd_DelayUnit = 1
				set Event_FightEnd_DelayUnit = 0
	        endif
	        set i = i + 1
	    endloop
	    
	    set Event_FightEnd_Delay = 1
	    set Event_FightEnd_Delay = 0
	    
	    set playerCheck = null
	endfunction
	
	private function IsWin takes integer battleType, integer state returns boolean
		if battleType == BATTLE_TYPE_MAIN then
			return true
		endif
		return false
	endfunction
	
	private function PlayerAction takes unit hero, player owner, integer index, boolean isWin returns nothing
		local integer cyclB
	    local integer cyclBEnd

		call SaveBoolean( udg_hash, GetHandleId( hero ), StringHash( "kill" ), false )
        call BlzSetUnitRealFieldBJ( hero, UNIT_RF_ACQUISITION_RANGE, 600 )
        call SelectUnitForPlayerSingle( hero, owner )
        
        if not(IsVictory) then
            call BlzFrameSetVisible( faceframe[index],true)
        endif
        set udg_combatlogic[index] = false
        set cyclB = 1
        set cyclBEnd = deadminionlim[index]
        loop
            exitwhen cyclB > cyclBEnd
            set deadminion[index][cyclB] = 0
            set cyclB = cyclB + 1
        endloop
        set deadminionnum[index] = 0
        set deadminionlim[index] = 0

        set udg_FightEnd_Unit = hero
        set udg_FightEnd_Real = 0
        set udg_FightEnd_Real = 1
        set udg_FightEnd_Real = 0
        
        call BattleEnd.SetDataUnit("caster", hero)
        call BattleEnd.SetDataPlayer("owner", owner)
        call BattleEnd.SetDataInteger("index", index)
        call BattleEnd.SetDataBoolean("is_win", isWin )
        call BattleEnd.Invoke() 
	endfunction
	
	function FightEnd takes integer battleType, integer state returns nothing
	    local boolean isWin = IsWin(battleType, state)
	    local integer i
	    
	    set udg_fightmod[0] = false

		set udg_FightEndGlobal_Real = 0.00
	    set udg_FightEndGlobal_Real = 1.00
	    set udg_FightEndGlobal_Real = 0.00
	    
	    call BattleEndGlobal.SetDataBoolean("is_win", isWin )
	    call BattleEndGlobal.Invoke()
	
	    set i = 1
	    loop
	        exitwhen i > 4
	        call BlzFrameSetVisible( iconframe[i], true)
	        if GetPlayerSlotState( Player( i - 1 ) ) == PLAYER_SLOT_STATE_PLAYING then
	            call PlayerAction(udg_hero[i], Player( i - 1 ), i, isWin )
	        endif
	        set i = i + 1
	    endloop
	
	    call TimerStart(CreateTimer(), 0.1, false, function FightEnd_Delay )
	endfunction
	
endlibrary