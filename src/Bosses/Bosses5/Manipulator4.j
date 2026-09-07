scope Manipulator4 initializer init
	
	globals
		public trigger Trigger = null
		private weathereffect Weather = null
		private integer UseIndex = -1
		
		private constant integer WEATHER_TYPE = 'MEds'
		private constant integer AREA_SIZE = 800
		private constant real SIZE_MULTIPLIER = AREA_SIZE / 100.
		private constant real TICK = 1.5
		
		private constant real PERCENT_TO_BURN = 0.04
		
		private constant string EFFECT_MODEL = "war3mapImported\\Indicator_Aim_Thin.mdx"//"war3mapImported\\Spell Marker Gray.mdx"
		private constant string AREA_BURN_ANIMATION = "Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl"
	endglobals

	private function condition takes nothing returns boolean
		return GetUnitTypeId( udg_DamageEventTarget ) == 'n02W' and GetUnitLifePercent(udg_DamageEventTarget) <= 60
	endfunction
	
	private function UnitsCheck takes unit boss, location areaSpawn returns nothing
		local real toBurn
		local location unitLoc
		local real range
		local group g = CreateGroup()
	    local unit u
	    
	    set toBurn = PERCENT_TO_BURN * SpellPower_GetBossSpellPower()
	    
	    call GroupEnumUnitsInRect(g, udg_Boss_Rect, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, boss, "enemy" ) then
            	set unitLoc = GetUnitLoc(u)
            	set range = DistanceBetweenPoints(unitLoc, areaSpawn)
            	if range > AREA_SIZE then
            		call DestroyEffect( AddSpecialEffectTarget( AREA_BURN_ANIMATION, u, "origin") )
            		call SetUnitState( u, UNIT_STATE_LIFE, RMaxBJ( 0, GetUnitState( u, UNIT_STATE_LIFE ) - GetUnitState( u, UNIT_STATE_MAX_LIFE ) * toBurn ) )
	                call SetUnitState( u, UNIT_STATE_MANA, RMaxBJ( 0, GetUnitState( u, UNIT_STATE_MANA ) - GetUnitState( u, UNIT_STATE_MAX_MANA ) * toBurn ) )
                endif
            endif
            call GroupRemoveUnit(g,u)
        endloop

		call RemoveLocation(unitLoc)
	    call DestroyGroup( g )
	    set unitLoc = null
	    set g = null
	    set u = null
	endfunction
	
	private function WorldEffect takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "boss_manipulator_world_boss" ) )
	    local effect area = LoadEffectHandle( udg_hash, id, StringHash( "boss_manipulator_world_area" ) )
	    local location areaSpawn = LoadLocationHandle( udg_hash, id, StringHash( "boss_manipulator_world_location" ) )
	
	    if IsUnitDead(boss) or not( udg_fightmod[0] ) then
	    	call DangerArea_RemoveReverse(UseIndex)
	    	call DestroyEffect(area)
	    	//call RemoveWeatherEffect(Weather)
	    	call RemoveLocation(areaSpawn)
	        call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
	    else
	        call UnitsCheck(boss, areaSpawn)
	    endif
	    
	    set areaSpawn = null
	    set area = null
	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit boss = udg_DamageEventTarget
		local location areaSpawn = GetRectCenter(udg_Boss_Rect)
		local effect area
		local integer id

		call DisableTrigger( GetTriggeringTrigger() )
		
		set area = AddSpecialEffectLoc(EFFECT_MODEL, areaSpawn)
		call BlzSetSpecialEffectScale(area, SIZE_MULTIPLIER)
		call BlzSetSpecialEffectColorByPlayer( area, Player(18) )
		
		set UseIndex = DangerArea_CreateReverse( GetLocationX(areaSpawn), GetLocationY(areaSpawn), AREA_SIZE, 600 )
		
		//set Weather = AddWeatherEffect( udg_Boss_Rect, WEATHER_TYPE )
		//call EnableWeatherEffect( Weather, true )
		
		
		set id = InvokeTimerWithEffect( area, "boss_manipulator_world_area", TICK, true, function WorldEffect )
		call SaveUnitHandle(udg_hash, id, StringHash("boss_manipulator_world_boss"), boss)
		call SaveLocationHandle(udg_hash, id, StringHash("boss_manipulator_world_location"), areaSpawn )
		
		set boss = null
		set areaSpawn = null
		set area = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
		call DisableTrigger(Trigger)
	endfunction
	
endscope