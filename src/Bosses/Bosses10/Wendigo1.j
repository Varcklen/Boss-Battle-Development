scope Wendigo1 initializer init
	
	globals
		public trigger Trigger = null
	
		private constant integer ANOMALIES_MAX = 5
		private trigger array AnomalyAction[ANOMALIES_MAX]
		
		private constant integer INDICATOR_GLOW_UP_DURATION = 5
		private constant integer COOLDOWN = 8
		private constant integer SPAWN_DEVIATION = 700
		
		public constant real ANOMALY_CHECK_TICK = 0.25
		public constant real ANOMALY_AREA_SIZE = 100
		public constant real ANOMALY_ANIMATION_SPEED = 2
		
		public location LocationSpawn = null
	endglobals
	
	private function SetData takes nothing returns nothing
		set AnomalyAction[0] = AnomalyHP_Trigger
		set AnomalyAction[1] = AnomalyMP_Trigger
		set AnomalyAction[2] = AnomalyCD_Trigger
		set AnomalyAction[3] = AnomalyATSP_Trigger
		set AnomalyAction[4] = AnomalyMVSP_Trigger
	endfunction
	
	private function condition takes nothing returns boolean
	    return GetUnitTypeId(udg_DamageEventTarget) == 'n03I'
	endfunction
	
	private function SpawnAnomaly takes unit boss returns nothing
		local integer rand = GetRandomInt( 0, ANOMALIES_MAX - 1 )
		local location unitLoc = GetUnitLoc(boss)
		
		//call BJDebugMsg("rand: " + I2S(rand))
		set LocationSpawn = GetArenaSpawnLocation( unitLoc, SPAWN_DEVIATION, GetRandomDirectionDeg() )
		call IndicatorSystem_Create( INDICATOR_SAFE, GetLocationX(LocationSpawn), GetLocationY(LocationSpawn), ANOMALY_AREA_SIZE, INDICATOR_GLOW_UP_DURATION, boss )
		call PingMinimapLocForForceEx( bj_FORCE_ALL_PLAYERS, LocationSpawn, INDICATOR_GLOW_UP_DURATION, bj_MINIMAPPINGSTYLE_SIMPLE, 100, 100, 100 )
		call TriggerExecute( AnomalyAction[rand] )
		
		call RemoveLocation(LocationSpawn)
		call RemoveLocation(unitLoc)
		set unitLoc = null
	endfunction

	private function WendCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "bswd" ) )
	    
	    if GetUnitState( boss, UNIT_STATE_LIFE) <= 0.405 or not( udg_fightmod[0] ) then
	        call FlushChildHashtable( udg_hash, id )
	        call DestroyTimer( GetExpiredTimer() )
	    else
	    	call SpawnAnomaly(boss)
	    endif
	    
	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
	    call DisableTrigger( GetTriggeringTrigger() )
	    call SetData()
		call InvokeTimerWithUnit( udg_DamageEventTarget, "bswd", bosscast(COOLDOWN), true, function WendCast )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	    call DisableTrigger( Trigger )
	endfunction
	
endscope