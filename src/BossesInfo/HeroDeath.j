scope HeroDeath initializer init

    function Trig_HeroDeath_Conditions takes nothing returns boolean
        return udg_fightmod[1] and DeathIf(GetDyingUnit())
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
                call Defeat_Cast()
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
