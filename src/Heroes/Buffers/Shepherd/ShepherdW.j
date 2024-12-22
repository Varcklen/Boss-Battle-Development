scope ShepherdW initializer init

    globals
        private constant integer ID_ABILITY = 'A1DS'
        private constant integer AREA_BASE = 200
        private constant integer AREA_PER_LVL = 50
        private constant string AREA_EFFECT = "Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl"
        private constant string FIZZLE_EFFECT = "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe"
        private group g = CreateGroup()
        
		trigger trg_ShepherdW = null
    endglobals

    function Trig_ShepherdW_Conditions takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY //and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
    endfunction

    private function target_is_ally takes nothing returns boolean
        local unit filtered
        local unit caster
        local boolean b
        set filtered = GetFilterUnit()
        set caster = udg_Caster
        if caster == null then
            set caster = GetSpellAbilityUnit()
        endif
        set b = unitst( filtered, caster, "ally" ) and not( IsUnitType( filtered, UNIT_TYPE_STRUCTURE ) )
        set filtered = null
        set caster = null
        return b
    endfunction
    private function target_is_enemy takes nothing returns boolean
        local unit filtered
        local unit caster
        local boolean b
        set filtered = GetFilterUnit()
        set caster = udg_Caster
        if caster == null then
            set caster = GetSpellAbilityUnit()
        endif
        set b = unitst( filtered, caster, "enemy" ) and GetUnitAbilityLevel( filtered, 'Avul' ) == 0 
        set filtered = null
        set caster = null
        return b
    endfunction
    private function target_is_enemy_nonmech takes nothing returns boolean
        local unit filtered
        local unit caster
        local boolean b
        set filtered = GetFilterUnit()
        set caster = udg_Caster
        if caster == null then
            set caster = GetSpellAbilityUnit()
        endif
        set b = unitst( filtered, caster, "enemy" ) and GetUnitAbilityLevel( filtered, 'Avul' ) == 0 and not( IsUnitType( filtered, UNIT_TYPE_MECHANICAL ) )
        set filtered = null
        set caster = null
        return b
    endfunction
    private function target_is_ally_or_enemy takes nothing returns boolean
        local unit filtered
        local unit caster
        local boolean b
        set filtered = GetFilterUnit()
        set caster = udg_Caster
        if caster == null then
            set caster = GetSpellAbilityUnit()
        endif
        set b = ( unitst( filtered, caster, "ally" ) and not( IsUnitType( filtered, UNIT_TYPE_STRUCTURE ) ) ) or ( unitst( filtered, caster, "enemy" ) and GetUnitAbilityLevel( filtered, 'Avul' ) == 0 )
        set filtered = null
        set caster = null
        return b
    endfunction
    private function target_is_allied_summon takes nothing returns boolean
        local unit filtered
        local unit caster
        local boolean b
        
        set filtered = GetFilterUnit()
        set caster = udg_Caster
        set caster = udg_Caster
        if caster == null then
            set caster = GetSpellAbilityUnit()
        endif
        set b = unitst( filtered, caster, "ally" ) and not( IsUnitType( filtered, UNIT_TYPE_HERO ) ) and not( IsUnitType( filtered, UNIT_TYPE_ANCIENT ) ) and  GetUnitAbilityLevel( filtered, 'Avul' ) == 0
        set filtered = null
        set caster = null
        return b
    endfunction

    function Trig_ShepherdW_Actions takes nothing returns nothing
        local unit caster
        local unit u
        local real target_x
        local real target_y
        local integer lvl
        local real range
        local integer i = 0
        local integer cyclA
        local integer cyclAEnd
        
        if CastLogic() then
            set caster = udg_Caster
            //set target = udg_Target
            set target_x = GetUnitX( caster )
            set target_y = GetUnitY( caster )
            set lvl = udg_Level
        elseif RandomLogic() then
            set caster = udg_Caster
            //set target = randomtarget( caster, 600, "enemy", 0, 0, 0 )
            set target_x = GetUnitX( caster )
            set target_y = GetUnitY( caster )
            set lvl = udg_Level
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
            /*if target == null then
                set caster = null
                return
            endif*/
        else
            set caster = GetSpellAbilityUnit()
            //set target = GetSpellTargetUnit()
            set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
            set target_x = GetLocationX( GetSpellTargetLoc() )
            set target_y = GetLocationY( GetSpellTargetLoc() )
        endif
        
        set range = I2R(AREA_BASE+(AREA_PER_LVL*lvl))
        set cyclA = 1
        set cyclAEnd = udg_Database_NumberItems[24]
        loop
            exitwhen cyclA > cyclAEnd
            if GetUnitAbilityLevel( caster, udg_DB_Hero_SpecAbAkt[cyclA] ) > 0 or GetUnitAbilityLevel( caster, udg_DB_Hero_SpecAbAktPlus[cyclA] ) > 0 then
                set i = cyclA
                set cyclA = cyclAEnd
            endif
            set cyclA = cyclA + 1
        endloop
        // not untargeted
        if i != 0 and i != 7 and i != 9 and i != 10 and i != 11 and i != 13 and i != 14 and i != 15 then 
            // targets allies
            if i == 1 or i == 5  then
                call GroupEnumUnitsInRange( g, target_x, target_y, range, Condition(function target_is_ally) )
            // targets allied summons
            elseif i == 8 then
                call GroupEnumUnitsInRange( g, target_x, target_y, range, Condition(function target_is_allied_summon) )
            // targets enemy nonmech
            elseif i == 2 then
                call GroupEnumUnitsInRange( g, target_x, target_y, range, Condition(function target_is_enemy_nonmech) )
            // targets enemy 
            elseif i == 3 or i == 6 then
                call GroupEnumUnitsInRange( g, target_x, target_y, range, Condition(function target_is_enemy) )
            // targets both
            elseif i == 4 or i == 12 then
                call GroupEnumUnitsInRange( g, target_x, target_y, range, Condition(function target_is_ally_or_enemy) )
            else //undefined
                /*loop
                    set u = FirstOfGroup(g)
                    exitwhen u == null
                    call GroupRemoveUnit(g,u)
                    set u = FirstOfGroup(g)
                endloop*/
                call textst( "Fizzled!", caster, 64, 90, 10, 1.5 )
                call DestroyEffect( AddSpecialEffectTarget(FIZZLE_EFFECT, caster, "overhead" ) )       
                call BJDebugMsg("Error: Undefined Unique for 'Shepherd: Care'")
            endif            
            loop
                set u = FirstOfGroup(g)
                exitwhen u == null
                //
                    set udg_Target = u
                    set udg_Caster = caster
                    set udg_CastLogic = true
                    set udg_CareLogic = true
                    call TriggerExecute( udg_DB_Trigger_Spec[i] )
                    set udg_CareLogic = false
                    set udg_CastLogic = false
                //
                call GroupRemoveUnit(g,u)
            endloop
            call DestroyEffect( AddSpecialEffect( AREA_EFFECT, target_x, target_y ) )
        else
            call textst( "Fizzled!", caster, 64, 90, 10, 1.5 )
            call DestroyEffect( AddSpecialEffectTarget(FIZZLE_EFFECT, caster, "overhead" ) )       
        endif
        set caster = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set trg_ShepherdW = CreateTrigger(  )
        call TriggerRegisterAnyUnitEventBJ( trg_ShepherdW, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trg_ShepherdW, Condition( function Trig_ShepherdW_Conditions ) )
        call TriggerAddAction( trg_ShepherdW, function Trig_ShepherdW_Actions )
    endfunction
    
endscope