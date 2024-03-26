scope Visarius initializer init

	globals
		private constant integer ITEM_ID = 'I0EF'
		
		private constant real HEALTH_RESTORE_PERC = 0.2 
		private constant real MANA_RESTORE_PERC = 0.2 
		
		private constant integer COUNTER_CHECK_END = 4
		
		private constant string ANIMATION = "Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl"
		
		private constant string COLOR_ACTIVE = "|c0020FF20"
		private constant string COLOR_INACTIVE = "|c00FF0000"
		
		private constant integer STRING_HASH = StringHash( "visarius" )
	endglobals

	private function condition takes nothing returns boolean
        return combat(GetSpellAbilityUnit(), false, 0)
    endfunction
    
    private function ResetCounter takes unit hero, integer id, boolean isInactive  returns nothing
    	call SaveInteger( udg_hash, id, STRING_HASH, 0 )

        if isInactive then
        	call textst( COLOR_INACTIVE + "_", hero, 64, GetRandomInt( 90, 120 ), 15, 1.5 )
        	call SaveBoolean( udg_hash, id, STRING_HASH, false )
        else
            call textst( COLOR_ACTIVE + "+", hero, 64, GetRandomInt( 90, 120 ), 15, 1.5 )
            call healst( hero, null, GetUnitState( hero, UNIT_STATE_MAX_LIFE) * HEALTH_RESTORE_PERC )
            call manast( hero, null, GetUnitState( hero, UNIT_STATE_MAX_MANA) * MANA_RESTORE_PERC )
            call DestroyEffect( AddSpecialEffectTarget( ANIMATION, hero, "origin") )
        endif
    endfunction
    
    private function CheckCounter takes unit hero, integer id, integer counter, boolean isInactive, integer abilityUsed returns nothing
    	local integer i
    	local integer iMax
    	local integer otherAbility
    
    	call SaveInteger( udg_hash, id, STRING_HASH, counter )
    	call SaveInteger( udg_hash, id, StringHash( "visarius" + I2S(counter) ), abilityUsed )
    	
    	if isInactive == false then
	    	set i = 1
	    	set iMax = counter - 1
	        loop
	            exitwhen i > iMax
	            set otherAbility = LoadInteger( udg_hash, id, StringHash( "visarius" + I2S(i) ) )
	            if abilityUsed == otherAbility then
	            	set isInactive = true
	                call SaveBoolean( udg_hash, id, STRING_HASH, isInactive )
	                set i = iMax
	            endif
	            set i = i + 1
	        endloop
        endif
        
        if counter >= COUNTER_CHECK_END then
        	return
        endif
        
        if isInactive then
        	call textst( COLOR_INACTIVE + I2S(counter), hero, 64, GetRandomInt( 90, 120 ), 12, 1.5 )
        else
            call textst( COLOR_ACTIVE + I2S(counter), hero, 64, GetRandomInt( 90, 120 ), 12, 1.5 )
        endif
    endfunction

	private function action takes nothing returns nothing
		local unit caster = GetSpellAbilityUnit()
		local item itemUsed = Trigger_GetItemUsed()
	    local integer id = GetHandleId(itemUsed)
	    local integer counter = LoadInteger( udg_hash, id, STRING_HASH) + 1
	    local boolean isInactive = LoadBoolean( udg_hash, id, STRING_HASH)
	    local integer abilityUsed = GetSpellAbilityId()
	
		call CheckCounter(caster, id, counter, isInactive, abilityUsed)
	    if counter >= COUNTER_CHECK_END then
	        call ResetCounter(caster, id, isInactive)
	    endif
	    
	    set itemUsed = null
	    set caster = null
    endfunction

	//===========================================================================
    private function init takes nothing returns nothing
        call  RegisterDuplicatableItemType( ITEM_ID, EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
    endfunction

endscope