scope Arah0 initializer init

	globals
		public trigger Trigger = null
		private unit NewUnit = null

		private constant real SUMMON_ANIMATION_DURATION = 1
		
		private constant real SUMMON_RANGE = 150
	endglobals
	
	private function AnimationEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit summon = LoadUnitHandle( udg_hash, id, StringHash( "boss_arach_summon" ) )

		call pausest( summon, -1 )
	    call FlushChildHashtable( udg_hash, id )

	    set summon = null
	endfunction
	
	public function SummonArachnid takes unit boss, location loc, real angle returns unit
		set NewUnit = CreateUnitAtLoc( GetOwningPlayer( boss ), 'h00L', loc, angle )
		
		call pausest( NewUnit, 1 )
		call SetUnitAnimation( NewUnit, "morph alternate" )
		call InvokeTimerWithUnit( NewUnit, "boss_arach_summon", SUMMON_ANIMATION_DURATION, false, function AnimationEnd )
		
		return NewUnit
	endfunction
	
	private function condition takes nothing returns boolean
	    return GetUnitTypeId(udg_DamageEventTarget) == 'h00K' and GetUnitLifePercent(udg_DamageEventTarget) <= 90
	endfunction
	
	private function action takes nothing returns nothing
		local group heroes = DeathSystem_GetAliveHeroGroupCopy()
	    local unit u
	    local real angle
	    local location spawnLoc
	    local location heroLoc
	    local unit boss = udg_DamageEventTarget

    	call DisableTrigger( GetTriggeringTrigger() )

        loop
            set u = FirstOfGroup(heroes)
            exitwhen u == null
            set heroLoc = GetUnitLoc(u)
            set spawnLoc = PolarProjectionBJ( heroLoc, SUMMON_RANGE, GetRandomDirectionDeg() )
            set angle = AngleBetweenPoints(spawnLoc, heroLoc)
            call SummonArachnid(boss, spawnLoc, angle)
            call GroupRemoveUnit(heroes,u)
        endloop

		call DestroyGroup(heroes)
		call RemoveLocation(spawnLoc)
		call RemoveLocation(heroLoc)
		set spawnLoc = null
		set heroLoc = null
		set heroes = null
		set boss = null
		set u = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	    call DisableTrigger( Trigger )
	endfunction

endscope