scope HeroDeath initializer init

    function Trig_HeroDeath_Conditions takes nothing returns boolean
        return udg_fightmod[1] and DeathIf(GetDyingUnit())
    endfunction

    private function Del takes nothing returns nothing
        if not( IsUnitType(GetEnumUnit(), UNIT_TYPE_HERO) ) then
            call RemoveUnit( GetEnumUnit() )
        endif
    endfunction
    
    private function SecondChance takes nothing returns nothing
        local boolean l
        local integer j
        local integer i
        local group g = udg_Bosses
        local unit u
    
        set udg_Heroes_Chanse = udg_Heroes_Chanse - 1
        call MultiSetValue( udg_multi, 2, 1, I2S( udg_Heroes_Chanse ) )
        call DisplayTextToForce( bj_FORCE_ALL_PLAYERS, "You have another try!" )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if DB_Boss_id[udg_Boss_LvL - 1][udg_Boss_Random] == GetUnitTypeId( u ) then
                set i = 1
                set l = false
                loop
                    exitwhen l
                    set j = i + ( ( udg_Boss_Random - 1 ) * 10 )
                    if DB_Trigger_Boss[udg_Boss_LvL][j] != null and i <= 10 then
                        call DisableTrigger( DB_Trigger_Boss[udg_Boss_LvL][j] )
                        set i = i + 1
                    else
                        set l = true
                    endif
                endloop
            endif
            call GroupRemoveUnit(g,u)
        endloop
        call Between( "res_boss" )
        
        set g = null
        set u = null
    endfunction
    
    private function Defeat takes nothing returns nothing
        local player pl
        local integer i
    
        set udg_logic[1] = true
        set udg_logic[36] = false
        set udg_fightmod[0] = false
        call SaveLoadStart()
        
        set Event_MatchEnd = 1
    	set Event_MatchEnd = 0
        call StopMusic(false)
        call ClearMapMusic()
        call PlayMusicBJ( gg_snd_DarkAgents01 )
        call PauseTimer( LoadTimerHandle( udg_hash, GetHandleId( udg_UNIT_DUMMY_BUFF ), StringHash( "bssdtimer" ) ) )
        call TimerDialogDisplay( udg_timerdialog[0], false )
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

    function Trig_HeroDeath_Actions takes nothing returns nothing
        local unit diedHero = GetDyingUnit()
        
        set udg_logic[35] = true
        call GroupAddUnit( udg_DeadHero, diedHero)
        call GroupRemoveUnit( udg_otryad, diedHero)
        set udg_Heroes_Deaths = udg_Heroes_Deaths + 1
        if udg_Heroes_Deaths == udg_Heroes_Amount then
            call DisableTrigger( GetTriggeringTrigger() )
            if udg_Heroes_Chanse > 0 then
                call SecondChance()
            else
                call Defeat()
            endif
        endif
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set gg_trg_HeroDeath = CreateTrigger(  )
        call DisableTrigger( gg_trg_HeroDeath )
        call TriggerRegisterAnyUnitEventBJ( gg_trg_HeroDeath, EVENT_PLAYER_UNIT_DEATH )
        call TriggerAddCondition( gg_trg_HeroDeath, Condition( function Trig_HeroDeath_Conditions ) )
        call TriggerAddAction( gg_trg_HeroDeath, function Trig_HeroDeath_Actions )
    endfunction

endscope
