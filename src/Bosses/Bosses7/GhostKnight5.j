scope GhostKnight5 initializer init
	
	globals
		public trigger Trigger = null
		
		private constant integer AREA_SIZE = 900
		private constant integer DAMAGE = 20
		private constant real TICK = 1
		private constant string HIT_ANIMATION = "Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl"
	endglobals

	private function condition takes nothing returns boolean
		return GetUnitTypeId( udg_DamageEventTarget ) == 'n008'
	endfunction
	
	private function GhostKnightCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "bsgk" ) )
	    
	    if IsUnitDead( boss ) or not( udg_fightmod[0] ) then
	    	call FlushChildHashtable( udg_hash, id )
	        call DestroyTimer( GetExpiredTimer() )
	    else
	    	call GroupAoE( boss, GetUnitX(boss), GetUnitY(boss), DAMAGE, AREA_SIZE, "enemy", null, HIT_ANIMATION )
	    endif
	    
	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		call DisableTrigger( GetTriggeringTrigger() )
    
		call InvokeTimerWithUnit( udg_DamageEventTarget, "bsgk", TICK, true, function GhostKnightCast )
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
		call DisableTrigger(Trigger)
	endfunction
	
endscope