scope ShepherdW initializer init

    globals
        private constant integer ID_ABILITY = 'A1DS'
        private constant integer AREA_BASE = 200
        private constant integer AREA_PER_LVL = 50
        private constant string AREA_EFFECT = "Abilities\\Spells\\Human\\Feedback\\SpellBreakerAttack.mdl"
        private constant string FIZZLE_EFFECT = "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe"
        
		trigger trg_ShepherdW = null
    endglobals

    function Trig_ShepherdW_Conditions takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY //and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
    endfunction
    
    private function FindUnique takes unit caster returns integer
    	local integer i
    	local integer iMax
    	
    	set i = 1
        set iMax = udg_Database_NumberItems[24]
        loop
            exitwhen i > iMax
            if GetUnitAbilityLevel( caster, udg_DB_Hero_SpecAbAkt[i] ) > 0 or GetUnitAbilityLevel( caster, udg_DB_Hero_SpecAbAktPlus[i] ) > 0 then
                return i
            endif
            set i = i + 1
        endloop
        return -1
    endfunction
    
    private function Cast takes unit caster, integer uniqueIndex, integer range, real x, real y returns nothing
    	local unit u
    	local group g = CreateGroup()
    
    	call GroupEnumUnitsInRange( g, x, y, range, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            //
                set udg_CareLogic = true
                call CastLib_CastAbility( caster, u, udg_DB_Trigger_Spec[uniqueIndex], 1, 20 )
                set udg_CareLogic = false
            //
            call GroupRemoveUnit(g,u)
        endloop
        
        call DestroyGroup(g)
        set g = null
        set u = null
    endfunction

    function Trig_ShepherdW_Actions takes nothing returns nothing
        local unit caster
        local real target_x
        local real target_y
        local integer lvl
        local integer range
        local integer i = 0
        local integer uniqueIndex
        
        if CastLogic() then
            set caster = udg_Caster
            set target_x = GetUnitX( caster )
            set target_y = GetUnitY( caster )
            set lvl = udg_Level
        elseif RandomLogic() then
            set caster = udg_Caster
            set target_x = GetUnitX( caster )
            set target_y = GetUnitY( caster )
            set lvl = udg_Level
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )

        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
            set target_x = GetLocationX( GetSpellTargetLoc() )
            set target_y = GetLocationY( GetSpellTargetLoc() )
        endif
        
        set range = AREA_BASE + ( AREA_PER_LVL * lvl)
        set uniqueIndex = FindUnique( caster )
        
        // not untargeted
        if i != -1 /*i != 0 and i != 7 and i != 9 and i != 10 and i != 11 and i != 13 and i != 14 and i != 15*/ then 
            /*// targets allies
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
                 )
            else 
                call textst( "Fizzled!", caster, 64, 90, 10, 1.5 )
                call DestroyEffect( AddSpecialEffectTarget(FIZZLE_EFFECT, caster, "overhead" ) )       
                call BJDebugMsg("Error: Undefined Unique for 'Shepherd: Care'")
            endif 
            */
            call Cast(caster, uniqueIndex, range, target_x, target_y )
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