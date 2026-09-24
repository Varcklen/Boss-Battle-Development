scope Heuz5 initializer init
	
	globals
		public trigger Trigger = null
		
		private constant real TICK_CHECK = 1
		private constant real DAMAGE_TICK = 1
		private constant integer RANGE_TO_NEW_AREA = 175
		private constant integer BEHIND_RANGE = 75
		private constant integer AREA_SIZE = 125
		private constant integer DAMAGE = 50
		private constant integer AREA_SLOWDOWN_ABILITY = 'A0RQ'
		
		private constant string AREA_MODEL = "war3mapImported\\Toxic Ground.mdx"
		private constant real MODEL_SIZE = AREA_SIZE / 95.
	endglobals

	private function condition takes nothing returns boolean
		return GetUnitTypeId(udg_DamageEventTarget) == 'e008'
	endfunction
	
	private function AreaDamage takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "boss_heuz_area" ) )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "boss_heuz_area_boss" ) )
	    local effect model
	
	    if IsUnitDead( boss ) or IsUnitDead( dummy ) or not( udg_fightmod[0] ) then
	    	set model = LoadEffectHandle( udg_hash, id, StringHash( "boss_heuz_area_model" ) )
	    	call DestroyEffect(model)
	        call RemoveUnit(dummy)
	        call DestroyTimer( GetExpiredTimer() )
	    else
	    	call GroupAoE( boss, GetUnitX( dummy ), GetUnitY( dummy ), DAMAGE, AREA_SIZE, "enemy", null, null )
	    endif
	    
		set model = null
	    set dummy = null
	    set boss = null
	endfunction
	
	private function CreateArea takes unit boss, location spawnLoc returns nothing
		local integer id
		local effect model
		local unit dummy
		
		//TEMP
		//call IndicatorSystem_Create( INDICATOR_AIM, GetLocationX(spawnLoc), GetLocationY(spawnLoc), AREA_SIZE, 3, boss )
	
		set model = AddSpecialEffectLoc( AREA_MODEL, spawnLoc )
		call BlzSetSpecialEffectScale( model, MODEL_SIZE )
		
		set dummy = CreateUnitAtLoc( GetOwningPlayer( boss ), 'u000', spawnLoc, 270 )
		//Requires to change area size manually in Object Editor!
		call UnitAddAbility( dummy, AREA_SLOWDOWN_ABILITY)
		
		set id = InvokeTimerWithUnit( dummy, "boss_heuz_area", DAMAGE_TICK, true, function AreaDamage )
		call SaveUnitHandle( udg_hash, id, StringHash( "boss_heuz_area_boss" ), boss )
		call SaveEffectHandle( udg_hash, id, StringHash( "boss_heuz_area_model" ), model )
        
        call RemoveLocation(spawnLoc)
		set spawnLoc = null
		set model = null
		set dummy = null
	endfunction
	
	private function AreaCheck takes unit boss, integer id returns nothing
		local location oldLoc = LoadLocationHandle( udg_hash, id, StringHash( "boss_heuz_move_area_loc" ) )
		local location unitLoc = GetUnitLoc(boss)
		local location currentLoc 
		
		//call BJDebugMsg("range: " + R2S(DistanceBetweenPoints(oldLoc, unitLoc)))
		if DistanceBetweenPoints(oldLoc, unitLoc) < RANGE_TO_NEW_AREA then
			call RemoveLocation(unitLoc)
			set oldLoc = null
			set unitLoc = null
			return
		endif
		//call BJDebugMsg("make")
		set currentLoc = PolarProjectionBJ(unitLoc, -BEHIND_RANGE, GetUnitFacing(boss) )
		call SaveLocationHandle( udg_hash, id, StringHash( "boss_heuz_move_area_loc" ), unitLoc )
		
		call CreateArea(boss, currentLoc)
		
		call RemoveLocation(currentLoc)
		call RemoveLocation(oldLoc)
		set currentLoc = null
		set oldLoc = null
		set currentLoc = null
	endfunction
	
	private function TimerUpdate takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "boss_heuz_move_area" ))
	    
	    if GetUnitState( boss, UNIT_STATE_LIFE) <= 0.405 or not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
	    else
	        call AreaCheck(boss, id)
	    endif
	    
	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		local integer id
		local unit boss = udg_DamageEventTarget
		local location unitLoc = GetUnitLoc( boss )
	
		call DisableTrigger( GetTriggeringTrigger() )
		call CreateArea( boss, unitLoc )
		set id = InvokeTimerWithUnit( udg_DamageEventTarget, "boss_heuz_move_area", TICK_CHECK, true, function TimerUpdate )
		call SaveLocationHandle( udg_hash, id, StringHash( "boss_heuz_move_area_loc" ), unitLoc )
		
		set unitLoc = null
		set boss = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	    call DisableTrigger( Trigger )
	endfunction
	
endscope