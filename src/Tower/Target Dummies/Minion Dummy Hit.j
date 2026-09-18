scope MinionDummyHit initializer init
	
	globals
		private constant integer UNIT_TYPE_ID = 'h01F'
	
		private constant real MIN_COOLDOWN = 2
		private constant real MAX_COOLDOWN = 4
		
		private constant string PLAYED_ANIMATION = "stand hit"
		
		private constant integer HASH_KEY = StringHash("minion_dummy_cd")
	endglobals

	private function condition takes nothing returns boolean
		if udg_IsDamageSpell then
			return false
		elseif GetUnitTypeId(udg_DamageEventTarget) != UNIT_TYPE_ID then
			return false
		elseif LoadBoolean(udg_hash, GetHandleId(udg_DamageEventTarget), HASH_KEY ) then
			return false
		elseif udg_DamageEventAmount >= GetUnitState( udg_DamageEventTarget, UNIT_STATE_LIFE) then
			return false
		endif
	    return true
	endfunction
	
	private function CooldownEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "minion_dummy_cooldown" ) )
	    
		call SaveBoolean( udg_hash, GetHandleId( target ), HASH_KEY, false )
	    call FlushChildHashtable( udg_hash, id )
	
	    set target = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit target = udg_DamageEventTarget
		local real cooldown = GetRandomReal(MIN_COOLDOWN, MAX_COOLDOWN)
		local integer id = GetHandleId(target)
		
		call SaveBoolean(udg_hash, id, HASH_KEY, true)
		call SetUnitAnimation(target, PLAYED_ANIMATION)
		call InvokeTimerWithUnit( target, "minion_dummy_cooldown", cooldown, false, function CooldownEnd )
		
		set target = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	endfunction
	
endscope