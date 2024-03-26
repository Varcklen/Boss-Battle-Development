scope ArenaLordsEnd initializer init

    globals
        public trigger LastBossKilled = null
    endglobals

    private function EndBattle takes nothing returns nothing
        local group g = CreateGroup()
        local unit u
    
        call DisableTrigger( LastBossKilled )
        call DisableTrigger( gg_trg_AL_End )
    
        set bj_livingPlayerUnitsTypeId = 'h00J'
        call GroupEnumUnitsOfPlayer(g, Player( 10 ), filterLivingPlayerUnitsOfTypeId)
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call RemoveUnit( u )
            call GroupRemoveUnit(g,u)
        endloop
        
        call Between( "end_AL" )
        
        call GroupClear( g )
        call DestroyGroup( g )
        set u = null
        set g = null
    endfunction
    
    function Trig_AL_End_Conditions takes nothing returns boolean
        return udg_fightmod[4] and DeathIf(GetDyingUnit())
    endfunction

    function Trig_AL_End_Actions takes nothing returns nothing
        local unit died = GetDyingUnit()
        local integer m = GetPlayerId(GetOwningPlayer(died)) + 1

        if udg_LvL[m] <= 5 then
            call DisplayTimedTextToPlayer( Player(m-1), 0, 0, 20, "|cffff0000Warning!|r |cffffcc00Death in this arena will not bring defeat.|r" )
        endif
        
        call GroupRemoveUnit( udg_otryad, died )
        call GroupAddUnit( udg_DeadHero, died)
        set udg_Heroes_Deaths = udg_Heroes_Deaths + 1
        if udg_Heroes_Deaths == udg_Heroes_Amount then
            call EndBattle()
        endif
        
        set died = null
    endfunction
    
    private function IsLastBossKilled takes nothing returns boolean
        if udg_fightmod[4] == false then
            return false
        elseif GetUnitTypeId(GetDyingUnit()) == 'n00F' then
            return true
        elseif GetUnitTypeId(GetDyingUnit()) == 'o006' then
            return true
        endif
        return false
    endfunction
    
    private function BossKilled takes nothing returns nothing
        call EndBattle()
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set gg_trg_AL_End = CreateTrigger(  )
        call DisableTrigger( gg_trg_AL_End )
        call TriggerRegisterAnyUnitEventBJ( gg_trg_AL_End, EVENT_PLAYER_UNIT_DEATH )
        call TriggerAddCondition( gg_trg_AL_End, Condition( function Trig_AL_End_Conditions ) )
        call TriggerAddAction( gg_trg_AL_End, function Trig_AL_End_Actions )
        
        set LastBossKilled = CreateTrigger()
        call DisableTrigger( LastBossKilled )
        call TriggerRegisterAnyUnitEventBJ( LastBossKilled, EVENT_PLAYER_UNIT_DEATH )
        call TriggerAddCondition( LastBossKilled, Condition( function IsLastBossKilled ) )
        call TriggerAddAction( LastBossKilled, function BossKilled )
    endfunction

endscope