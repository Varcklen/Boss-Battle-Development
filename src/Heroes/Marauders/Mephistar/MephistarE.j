scope MephistarE initializer init

	globals
		trigger trig_MephistarE = null
	
		private constant integer ABILITY_ID = 'A1EM'
		
		private constant integer SPAWN_DEVIATION_RANGE = 200
		
		private constant real STAT_SETTING_INITIAL = 0.45 
		private constant real STAT_SETTING_PER_LEVEL = 0.15 
		
		private constant string ANIMATION = "Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl"
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster
	    local unit target
	    local integer level
	    local real statPercentage
	    local unit newUnit
	    local integer extraHP
	    local integer extraAT
	    
	    if CastLogic() then
	        set caster = udg_Caster
	        set target = udg_Target
	        set level = udg_Level
	    elseif RandomLogic() then
	        set caster = udg_Caster
	        set target = randomtarget( caster, 900, "ally", RT_MINION, 0, 0 )
	        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
	        if target == null then
	            set caster = null
	            return
	        endif
	        set level = udg_Level
	    else
	        set caster = GetSpellAbilityUnit()
	        set target = GetSpellTargetUnit()
	        set level = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId() )
	    endif
	
		set statPercentage = STAT_SETTING_INITIAL + (STAT_SETTING_PER_LEVEL * level)
	
	    call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( target ), GetUnitY( target ) ) )
	    
        if IsUnitType( target, UNIT_TYPE_HERO) == false and IsUnitType( target, UNIT_TYPE_ANCIENT) == false then
            set newUnit = CreateUnitCopy( target, Math_GetUnitRandomX(target, SPAWN_DEVIATION_RANGE), Math_GetUnitRandomY(target, SPAWN_DEVIATION_RANGE), GetRandomDirectionDeg() )
            
            set extraHP = R2I( statPercentage * BlzGetUnitMaxHP(target) ) + 1
			set extraAT = R2I( statPercentage * BlzGetUnitBaseDamage(target, 0) )
            
            call BlzSetUnitMaxHP( newUnit,  extraHP )
		    call BlzSetUnitBaseDamage( newUnit,  extraAT, 0 )
		    call SetUnitState( newUnit, UNIT_STATE_LIFE, GetUnitState( newUnit, UNIT_STATE_LIFE) + extraHP )
		    
		    call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( newUnit ), GetUnitY( newUnit ) ) )
        endif
	    
	    set caster = null
	    set target = null
	    set newUnit = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set trig_MephistarE = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig_MephistarE, EVENT_PLAYER_UNIT_SPELL_EFFECT )
	    call TriggerAddCondition( trig_MephistarE, Condition( function condition ) )
	    call TriggerAddAction( trig_MephistarE, function action )
	endfunction

endscope