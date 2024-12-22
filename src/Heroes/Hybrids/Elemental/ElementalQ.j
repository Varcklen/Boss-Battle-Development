scope ElementalQ initializer init

    globals
        private constant integer ID_ABILITY = 'A0J6'
        
        private constant integer DURATION = 15
        private constant integer TICK = 1
        private constant integer AREA = 325
        private constant integer DAMAGE_FIRST_LEVEL = 12
        private constant integer DAMAGE_LEVEL_BONUS = 4
        private constant real VENOM_BONUS_FIRST_LEVEL = 0.25
        private constant real VENOM_BONUS_LEVEL_BONUS = 0.15
        
        private constant real VENOS_EXTRA_BONUS_ALTERNATIVE = 2.5
        
        private constant integer EFFECT = 'A0K8'
        private constant integer BUFF = 'B07Q'
        
        private constant string ANIMATION = "Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl"
        
		trigger trg_ElementalQ = null
    endglobals

    function Trig_ElementalQ_Conditions takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY
    endfunction

    function ElementalQCast takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer( ) )
        local real damage = LoadReal( udg_hash, id, StringHash( "eleq" ) )
        local unit target = LoadUnitHandle( udg_hash, id, StringHash( "eleq" ) )
        local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "eleqc" ) )
        
        if IsUnitAlive(target) and IsUnitHasAbility( target, EFFECT) then
            if IsUnitHasAbility(target, 'B07R') and Aspects_IsHeroAspectActive( caster, ASPECT_03 ) == false then
                call healst(caster, target, damage)
            else
                set IsDisableSpellPower = true
                call UnitTakeDamage(caster, target, damage, DAMAGE_TYPE_MAGIC)
            endif
        else
            call FlushChildHashtable( udg_hash, id )
            call DestroyTimer( GetExpiredTimer() )
        endif
        
        set caster = null
        set target = null
    endfunction
    
    private function Alternative takes unit caster, real x, real y, real venomBonus, real duration returns nothing 
        local group g = CreateGroup()
        local unit u

        set venomBonus = venomBonus * VENOS_EXTRA_BONUS_ALTERNATIVE
        call GroupEnumUnitsInRange( g, x, y, AREA, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, TARGET_ALL ) then
                call PlaySpecialEffect(ANIMATION, u) 
                call SaveReal( udg_hash, GetHandleId( u ), StringHash( "eleqv" ), venomBonus )
                call bufst( caster, u, EFFECT, BUFF, "eleq1", duration )
            endif
            call GroupRemoveUnit(g,u)
        endloop

        call DestroyGroup( g )
        set u = null
        set g = null
        set caster = null
    endfunction
    
    private function Main takes unit caster, real x, real y, real damage, real venomBonus, real duration returns nothing 
        local group g = CreateGroup()
        local unit u
        local integer id
    
        call GroupEnumUnitsInRange( g, x, y, AREA, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, TARGET_ALL ) then
                call PlaySpecialEffect(ANIMATION, u) 
                if GetUnitAbilityLevel( u, EFFECT) == 0 then
                    set id = InvokeTimerWithUnit( u, "eleq", TICK, true, function ElementalQCast )
                    call SaveUnitHandle( udg_hash, id, StringHash( "eleqc" ), caster )
                    call SaveReal( udg_hash, id, StringHash( "eleq" ), damage )
                endif
                call SaveReal( udg_hash, GetHandleId( u ), StringHash( "eleqv" ), venomBonus )
                call bufst( caster, u, EFFECT, BUFF, "eleq1", duration )
            endif
            call GroupRemoveUnit(g,u)
        endloop
        
        call DestroyGroup( g )
        set u = null
        set g = null
        set caster = null
    endfunction

    function Trig_ElementalQ_Actions takes nothing returns nothing
        local unit caster
        local integer lvl
        local real x
        local real y
    	local real dist 
    	local real angle 
        local real t
        local real dmg
        local real venomBonus
        
        if CastLogic() then
            set caster = udg_Target
            set lvl = udg_Level
        	set x = GetSpellTargetX()
        	set y = GetSpellTargetY()
            set t = udg_Time
        elseif RandomLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
        	set dist = GetRandomReal( 0, 730 )
        	set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
        	set x = GetUnitX( caster ) + dist * Cos( angle )
        	set y = GetUnitY( caster ) + dist * Sin( angle )
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
            set t = DURATION
        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
        	set x = GetSpellTargetX()
        	set y = GetSpellTargetY()
            set t = DURATION
        endif
        
        set t = timebonus(caster, t)
        set dmg = ( DAMAGE_FIRST_LEVEL + ( DAMAGE_LEVEL_BONUS * lvl ) ) * GetUnitSpellPower(caster)
        set venomBonus = VENOM_BONUS_FIRST_LEVEL + ( VENOM_BONUS_LEVEL_BONUS * lvl )

        if Aspects_IsHeroAspectActive( caster, ASPECT_01 ) then
            call Alternative( caster, x, y, venomBonus, t )
        else
            call Main( caster, x, y, dmg, venomBonus, t )
        endif
        
        set caster = null
    endfunction
    
    private function DeleteBuff_Conditions takes nothing returns boolean
        return IsUnitHasAbility( Event_DeleteBuff_Unit, EFFECT)
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        local unit hero = Event_DeleteBuff_Unit

        call UnitRemoveAbility( hero, EFFECT )
        call UnitRemoveAbility( hero, BUFF )
        
        set hero = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set trg_ElementalQ = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg_ElementalQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trg_ElementalQ, Condition( function Trig_ElementalQ_Conditions ) )
        call TriggerAddAction( trg_ElementalQ, function Trig_ElementalQ_Actions )
        
        call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
    endfunction

endscope 

