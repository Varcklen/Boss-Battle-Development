scope Turtle7 initializer init
	
	globals
		public trigger Trigger = null
		
		private constant integer COOLDOWN = 10
		private constant integer SHIELD_TO_ADD = 300
	endglobals

	private function condition takes nothing returns boolean
		return GetUnitTypeId( udg_DamageEventTarget ) == 'h01R'
	endfunction
	
	private function AddShield takes unit boss returns nothing
		local real currentShield = ShieldstLib_GetCurrentShield(boss)
		local real shieldToAdd = SHIELD_TO_ADD - currentShield
		
		if shieldToAdd <= 0 then
			return
		endif
	
		call shield( boss, boss, shieldToAdd )
	endfunction
	
	private function ShieldTimer takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "boss_turtle_shield" ) )

	    if IsUnitDead(boss) or not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
	    else
	    	call AddShield(boss)
	    endif

	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		call DisableTrigger( GetTriggeringTrigger() )
		call InvokeTimerWithUnit( udg_DamageEventTarget, "boss_turtle_shield", bosscast(COOLDOWN), true, function ShieldTimer )
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
		call DisableTrigger(Trigger)
	endfunction
	
endscope