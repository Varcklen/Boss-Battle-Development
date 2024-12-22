scope GamblerR initializer init

    globals
        private constant integer ID_ABILITY = 'A11J'
        
        private constant integer LUCK_BONUS = 100
        private constant integer DURATION_FIRST_LEVEL = 8
        private constant integer DURATION_LEVEL_BONUS = 2
        
        private constant integer EFFECT = 'A11Q'
        private constant integer BUFF = 'B06S'
        
        private constant integer ALT_LUCK_BONUS = 200
        private constant integer ALT_LUCK_SHARED = 25
        private constant integer ALT_LUCK_BONUS_MODF = 50
        private constant integer ALT_CHANCE = 50
        private constant real ALT_DURATION_MULT = 0.5
        
        private constant string ANIMATION = "Abilities\\Spells\\Human\\Slow\\SlowCaster.mdl"
        
		trigger trg_GamblerR = null
    endglobals

    function Trig_GamblerR_Conditions takes nothing returns boolean
        return GetSpellAbilityId() == ID_ABILITY and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() ) and not( udg_fightmod[3] )
    endfunction
    
    	function GamblerRCast takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer( ) )
        local unit u = LoadUnitHandle( udg_hash, id, StringHash( "gmbr" ) )
        local integer luckBonus = LoadInteger( udg_hash, GetHandleId( u ), StringHash( "gmbr" ) )
        
        call luckyst( u, -luckBonus )
        call UnitRemoveAbility( u, EFFECT )
        call UnitRemoveAbility( u, BUFF )
        
        call RemoveSavedInteger( udg_hash, GetHandleId( u ), StringHash( "gmbr" ) )
        call FlushChildHashtable( udg_hash, id )

        set u = null
    endfunction
    
	function GamblerRCast_ALT takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer( ) )
        local unit u = LoadUnitHandle( udg_hash, id, StringHash( "gmbr" ) )
        local integer luckBonus 
        
	    //Checks, if unit is active player hero
        if IsUnitInGroup(u, udg_heroinfo) then
        	set luckBonus= LoadInteger( udg_hash, GetHandleId( u ), StringHash( "gmbr" ) )
        	call luckyst( u, -luckBonus )
        endif
        
        call UnitRemoveAbility( u, EFFECT )
        call UnitRemoveAbility( u, BUFF )
        
        call RemoveSavedInteger( udg_hash, GetHandleId( u ), StringHash( "gmbr" ) )
        call FlushChildHashtable( udg_hash, id )

        set u = null
    endfunction
    
    private function Alternative_01 takes unit caster, real t returns nothing // All In
        local integer isum
        if IsUnitType( caster, UNIT_TYPE_HERO) then
            call luckyst( caster, ALT_LUCK_BONUS )
            set isum = LoadInteger( udg_hash, GetHandleId( caster ), StringHash( "gmbr" ) ) + ALT_LUCK_BONUS
            
            call UnitAddAbility( caster, EFFECT)
            call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "overhead") )
            
            call InvokeTimerWithUnit(caster, "gmbr", (t * ALT_DURATION_MULT), false, function GamblerRCast)
            call SaveInteger( udg_hash, GetHandleId( caster ), StringHash( "gmbr" ), isum )
        endif
        set caster = null
    endfunction 	// All In ends
    
    private function Alternative_02 takes unit caster, real t returns nothing // Odd Odds
        local integer isum
    	local integer luckbonus
        if IsUnitType( caster, UNIT_TYPE_HERO) then
        	if LuckChance( caster, ALT_CHANCE ) then
        		set luckbonus = LUCK_BONUS + ALT_LUCK_BONUS_MODF
        	else
        		set luckbonus = LUCK_BONUS - ALT_LUCK_BONUS_MODF
        	endif
            call luckyst( caster, luckbonus )
            	
            set isum = LoadInteger( udg_hash, GetHandleId( caster ), StringHash( "gmbr" ) ) + luckbonus
            
            call UnitAddAbility( caster, EFFECT)
            call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "overhead") )
            
            call InvokeTimerWithUnit(caster, "gmbr", t, false, function GamblerRCast)
            call SaveInteger( udg_hash, GetHandleId( caster ), StringHash( "gmbr" ), isum )
        endif
        set caster = null
    endfunction 	// Odd Odds ends
    
    private function Alternative_03 takes unit caster, real t returns nothing // House Loss
        local integer isum
        local unit hero
        local integer i = 1
	    loop
	        exitwhen i > 4
	        set hero = udg_hero[i]
	    	if IsUnitAlive(hero) and IsUnitAlly(hero, GetOwningPlayer(caster)) and udg_fightmod[3] == false then
	            call luckyst( hero, ALT_LUCK_SHARED )
	            set isum = LoadInteger( udg_hash, GetHandleId( hero ), StringHash( "gmbr" ) ) + ALT_LUCK_SHARED
	            
	            call UnitAddAbility( caster, EFFECT)
            	call DestroyEffect( AddSpecialEffectTarget( ANIMATION, hero, "overhead") )
	            
	            call InvokeTimerWithUnit( hero, "gmbr", t, false, function GamblerRCast_ALT )
	            call SaveInteger( udg_hash, GetHandleId( hero ), StringHash( "gmbr" ), isum )
	        endif
	        set i = i + 1
	        set hero = null
	    endloop
        set caster = null
    endfunction 	// House Loss ends
    
    private function Main takes unit caster, real t returns nothing
        local integer isum 
        if IsUnitType( caster, UNIT_TYPE_HERO) then
            call luckyst( caster, LUCK_BONUS )
            set isum = LoadInteger( udg_hash, GetHandleId( caster ), StringHash( "gmbr" ) ) + LUCK_BONUS
            
            call UnitAddAbility( caster, EFFECT)
            call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "overhead") )
            
            call InvokeTimerWithUnit(caster, "gmbr", t, false, function GamblerRCast)
            call SaveInteger( udg_hash, GetHandleId( caster ), StringHash( "gmbr" ), isum )
        endif
        set caster = null
    endfunction

    function Trig_GamblerR_Actions takes nothing returns nothing
        local unit caster
        local real t
        local integer lvl
        
        if CastLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
            set t = udg_Time
        elseif RandomLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
            set t = DURATION_FIRST_LEVEL + (DURATION_LEVEL_BONUS*lvl)
        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId() )
            set t = DURATION_FIRST_LEVEL + (DURATION_LEVEL_BONUS*lvl)
        endif
        set t = timebonus(caster, t)
        
        if Aspects_IsHeroAspectActive( caster, ASPECT_01 ) then
            call Alternative_01( caster, t )
        elseif Aspects_IsHeroAspectActive( caster, ASPECT_02 ) then
            call Alternative_02( caster, t )
        elseif Aspects_IsHeroAspectActive( caster, ASPECT_03 ) then
            call Alternative_03( caster, t )
        else
            call Main( caster, t )
        endif

        set caster = null
    endfunction

/*	function Trig_GamblerR_Actions takes nothing returns nothing
        local integer isum
        local unit caster
        local real t
        local integer lvl
        
        if CastLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
            set t = udg_Time
        elseif RandomLogic() then
            set caster = udg_Caster
            set lvl = udg_Level
            call textst( udg_string[0] + GetObjectName(ID_ABILITY), caster, 64, 90, 10, 1.5 )
            set t = DURATION_FIRST_LEVEL + (DURATION_LEVEL_BONUS*lvl)
        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId() )
            set t = DURATION_FIRST_LEVEL + (DURATION_LEVEL_BONUS*lvl)
        endif
        set t = timebonus(caster, t)

        if IsUnitType( caster, UNIT_TYPE_HERO) then
            call luckyst( caster, LUCK_BONUS )
            set isum = LoadInteger( udg_hash, GetHandleId( caster ), StringHash( "gmbr" ) ) + LUCK_BONUS
            
            call UnitAddAbility( caster, EFFECT)
            call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "overhead") )
            
            call InvokeTimerWithUnit(caster, "gmbr", t, false, function GamblerRCast)
            call SaveInteger( udg_hash, GetHandleId( caster ), StringHash( "gmbr" ), isum )
        endif
        
        set caster = null
    endfunction		*/
    
    private function DeleteBuff_Conditions takes nothing returns boolean
        return GetUnitAbilityLevel( Event_DeleteBuff_Unit, EFFECT) > 0
    endfunction
    
    private function DeleteBuff takes nothing returns nothing
        local unit hero = Event_DeleteBuff_Unit
        local integer luckBonus = LoadInteger( udg_hash, GetHandleId( hero ), StringHash( "gmbr" ) )

        call luckyst( hero, -luckBonus )
        call UnitRemoveAbility( hero, EFFECT )
        call UnitRemoveAbility( hero, BUFF )
        call RemoveSavedInteger( udg_hash, GetHandleId( hero ), StringHash( "gmbr" ) )
        
        set hero = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set trg_GamblerR = CreateTrigger(  )
        call TriggerRegisterAnyUnitEventBJ( trg_GamblerR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trg_GamblerR, Condition( function Trig_GamblerR_Conditions ) )
        call TriggerAddAction( trg_GamblerR, function Trig_GamblerR_Actions )
        
        call CreateEventTrigger( "Event_DeleteBuff_Real", function DeleteBuff, function DeleteBuff_Conditions )
    endfunction

endscope

