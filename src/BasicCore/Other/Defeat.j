scope Defeat

	private function Del takes nothing returns nothing
        if IsUnitType(GetEnumUnit(), UNIT_TYPE_HERO) then
        	return
        endif
        call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", GetUnitX( GetEnumUnit() ), GetUnitY( GetEnumUnit() ) ) )
        call RemoveUnit( GetEnumUnit() )
    endfunction

	public function Cast takes nothing returns nothing
        local player pl
        local integer i
    
        set IsDefeat = true
        set udg_fightmod[0] = false
        if udg_Endgame == 1 then
	        call SaveLoadStart()
	    endif
        
        set Event_MatchEnd = 1
    	set Event_MatchEnd = 0
    	
        call GameMusic_PlayTrack( gg_snd_DarkAgents01, false )
        //call PauseTimer( LoadTimerHandle( udg_hash, GetHandleId( udg_UNIT_DUMMY_BUFF ), StringHash( "bssdtimer" ) ) )
        set i = 0
        loop
            exitwhen i > 3
            set pl = Player( i )
            /*if GetPlayerSlotState( pl ) == PLAYER_SLOT_STATE_PLAYING then
                call MMD_FlagPlayer(pl, MMD_FLAG_LOSER)
            endif*/
            call ForGroupBJ( GetUnitsInRectOfPlayer(gg_rct_ArenaBoss, pl ), function Del )
            set i = i + 1
        endloop
        call TriggerExecute( gg_trg_Caption )
        
        set pl = null
    endfunction

endscope