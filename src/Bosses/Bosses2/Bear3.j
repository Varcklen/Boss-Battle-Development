scope Bear3 initializer init

	globals
		public trigger Trigger = null
		
		private constant integer EFFECT = 'A1JN'
		private constant integer BUFF = 'B0B9'
		private constant integer DURATION = 6
		private constant integer TICK = 1
		private constant integer DAMAGE = 8
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetUnitTypeId(udg_DamageEventSource) == 'n010' and udg_IsDamageSpell == false
	endfunction
	
	private function WoundTick takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "boss_bear_wound_boss" ) )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "boss_bear_wound" ) )
	    
	    if GetUnitAbilityLevel( target, EFFECT) == 0 then
	    	call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
	    else
	    	call UnitDamageTarget( boss, target, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
	    endif
	    
	    set boss = null
	    set target = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit boss = udg_DamageEventSource
		local unit target = udg_DamageEventTarget
		local integer id
	
		if GetUnitAbilityLevel( target, EFFECT) == 0 then
			set id = InvokeTimerWithUnit( target, "boss_bear_wound", TICK, true, function WoundTick )
			call SaveUnitHandle(udg_hash, id, StringHash("boss_bear_wound_boss"), boss )
		endif
		call bufallst( boss, target, EFFECT, 0, 0, 0, 0, BUFF, "boss_bear_wound_buff", DURATION )
		
		set boss = null
		set target = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	    call DisableTrigger( Trigger )
	endfunction

endscope