scope HoundmasterE initializer init

	globals
		private constant integer ABILITY_ID = 'A0FD'
		
		private constant real EXTRA_DAMAGE_PERC_INITIAL = 0
		private constant real EXTRA_DAMAGE_PERC_PER_LEVEL = 0.004
		
		private constant real DAMAGE_REDUCTION_PERC_INITIAL = 0
		private constant real DAMAGE_REDUCTION_PERC_PER_LEVEL = 0.1
	endglobals

	/*Offence*/
	private function condition_offence takes nothing returns boolean
	    return GetUnitTypeId(udg_DamageEventSource) == 'n02F'
	endfunction
	
	private function action_offence takes nothing returns nothing
		local unit pet = udg_DamageEventSource
	    local unit owner = LoadUnitHandle( udg_hash, GetHandleId( pet ), StringHash( "houndmaster_r_owner" ) )
	    local integer level = GetUnitAbilityLevel( owner, ABILITY_ID )
	    local real extraDamagePerc
	    
	    if level > 0 then
	    	set extraDamagePerc = EXTRA_DAMAGE_PERC_INITIAL + (EXTRA_DAMAGE_PERC_PER_LEVEL * level)
            set udg_DamageEventAmount = udg_DamageEventAmount + GetUnitState( udg_DamageEventTarget, UNIT_STATE_MAX_LIFE ) * extraDamagePerc
        endif
	    
	    set pet = null
	    set owner = null
	endfunction
	
	/*Defence*/
	private function condition_defence takes nothing returns boolean
	    return GetUnitTypeId(udg_DamageEventTarget) == 'n02F'
	endfunction
	
	private function action_defence takes nothing returns nothing
		local unit pet = udg_DamageEventTarget
	    local unit owner = LoadUnitHandle( udg_hash, GetHandleId( pet ), StringHash( "houndmaster_r_owner" ) )
	    local integer level = GetUnitAbilityLevel( owner, ABILITY_ID )
	    local real damageReductionPerc
	    
	    if level > 0 then
	    	set damageReductionPerc = DAMAGE_REDUCTION_PERC_INITIAL + (DAMAGE_REDUCTION_PERC_PER_LEVEL * level)
            set udg_DamageEventAmount = udg_DamageEventAmount - udg_DamageEventAmount * damageReductionPerc
        endif
	    
	    set pet = null
	    set owner = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )
	    call TriggerRegisterVariableEvent( trig, "udg_DamageModifierEvent", EQUAL, 1.00 )
	    call TriggerAddCondition( trig, Condition( function condition_offence ) )
	    call TriggerAddAction( trig, function action_offence )
	    
	    set trig = CreateTrigger(  )
	    call TriggerRegisterVariableEvent( trig, "udg_DamageModifierEvent", EQUAL, 1.00 )
	    call TriggerAddCondition( trig, Condition( function condition_defence ) )
	    call TriggerAddAction( trig, function action_defence )
	endfunction

endscope