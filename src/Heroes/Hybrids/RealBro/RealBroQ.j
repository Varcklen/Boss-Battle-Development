scope RealBroQ initializer init

	globals
		private constant integer ABILITY_ID = 'A1B7'
		
		private constant integer MAX_MANA_STEAL_INITIAL = 45
		private constant integer MAX_MANA_STEAL_PER_LEVEL = 15
		
		private constant integer MANA_RESTORE_INITIAL = 25
		private constant integer MANA_RESTORE_PER_LEVEL = 5
		
		private constant integer STEAL_RANGE = 600
		private constant integer MANA_RESTORE_DELAY = 5
		
		private constant string ANIMATION = "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl"
		
		trigger trig_RealBroQ = null
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
	endfunction
	
	private function EndDelay takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local unit target = LoadUnitHandle( udg_hash, id, StringHash( "real_bro_q_delay" ) )
		local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "real_bro_q_delay_caster" ) )
        local integer manaToRestore = LoadInteger( udg_hash, id, StringHash( "real_bro_q_delay_mana" ) )
        
        call manast(caster, target, manaToRestore)
        call DestroyEffect( AddSpecialEffectTarget( ANIMATION, target, "origin" ) )
        call FlushChildHashtable( udg_hash, id )
        
        set caster = null
        set target = null
	endfunction
	
	private function AddDelay takes unit caster, unit target, integer level returns nothing
		local integer id
		local integer manaToRestore = MANA_RESTORE_INITIAL + (MANA_RESTORE_PER_LEVEL * level)
		
		set id = InvokeTimerWithUnit(target, "real_bro_q_delay", MANA_RESTORE_DELAY, false, function EndDelay )
		call SaveUnitHandle( udg_hash, id, StringHash("real_bro_q_delay_caster"), caster )
		call SaveInteger( udg_hash, id, StringHash("real_bro_q_delay_mana"), manaToRestore )
	endfunction
	
	private function Use takes unit caster, integer level returns nothing
		local group heroesAffected = CreateGroup()
		local group heroesToSteal = CreateGroup()
		local group g = CreateGroup()
    	local unit u
    	local integer manaToSteal = MAX_MANA_STEAL_INITIAL + ( MAX_MANA_STEAL_PER_LEVEL * level )
    	local integer manaToStealSum = 0
    	local integer mana
    	
    	call GroupAddGroup( udg_otryad, heroesAffected )
    	call GroupRemoveUnit( heroesAffected, caster)
    	
    	call GroupEnumUnitsInRange( g, GetUnitX( caster ), GetUnitY( caster ), STEAL_RANGE, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if IsUnitInGroup( u, heroesAffected ) then
	        	call GroupRemoveUnit( heroesAffected, u)
	        	call GroupAddUnit( heroesToSteal, u)
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    set manaToSteal = manaToSteal / IMaxBJ(1, CountUnitsInGroup(heroesToSteal) )
	    
	    loop
	        set u = FirstOfGroup(heroesToSteal)
	        exitwhen u == null
	        set mana = IMinBJ( R2I( GetUnitState( u, UNIT_STATE_MANA ) ), manaToSteal)
	        call SetUnitState( u, UNIT_STATE_MANA, GetUnitState( u, UNIT_STATE_MANA ) - mana )
	        set manaToStealSum = manaToStealSum + mana
	        call DestroyEffect( AddSpecialEffectTarget( ANIMATION, u, "origin" ) )
	        call GroupRemoveUnit(heroesToSteal,u)
	    endloop
	    
	    call manast(caster, null, manaToStealSum)
	    call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "origin" ) )
	    
	    loop
	        set u = FirstOfGroup(heroesAffected)
	        exitwhen u == null
        	call AddDelay(caster, u, level)
	        call GroupRemoveUnit(heroesAffected,u)
	    endloop
	        
	    call DestroyGroup( g )
	    call DestroyGroup( heroesAffected )
	    call DestroyGroup( heroesToSteal )
	    set u = null
	    set g = null
	    set heroesAffected = null
	    set heroesToSteal = null
	endfunction
	
	private function action takes nothing returns nothing
		local integer lvl
	    local unit caster
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set lvl = udg_Level
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set lvl = udg_Level
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	    else
	        set caster = GetSpellAbilityUnit()
	        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())
	    endif
	    
	    call Use(caster, lvl)
	    
	    set caster = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    set trig_RealBroQ = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig_RealBroQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( trig_RealBroQ, Condition( function condition ) )
	    call TriggerAddAction( trig_RealBroQ, function action )
	endfunction

endscope