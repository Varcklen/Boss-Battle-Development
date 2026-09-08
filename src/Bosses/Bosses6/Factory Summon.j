scope FactorySummon initializer init

	globals
		private constant integer ROBOT_TO_SUMMON = 2
		private constant integer ROBOT_SPAWN_DEVIATION = 200
		private constant integer ROBOT_TYPE = 'n012'
		private constant integer COOLDOWN = 10
		private constant string SPAWN_ANIMATION = "birth"
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitTypeId(GetEnteringUnit()) == 'n05H'
	endfunction
	
	private function Spawn takes unit caster returns nothing
		local unit newUnit
		local location unitLoc
		local location newLoc
		local integer i
		
		set unitLoc = GetUnitLoc(caster)
		
		set i = 1
		loop
			exitwhen i > ROBOT_TO_SUMMON
			set newLoc = PolarProjectionBJ(unitLoc, ROBOT_SPAWN_DEVIATION, GetRandomDirectionDeg() )
			set newUnit = CreateUnitAtLoc( GetOwningPlayer( caster ), ROBOT_TYPE, newLoc, 270 )
			call SetUnitAnimation(newUnit, SPAWN_ANIMATION)
			call RemoveLocation(newLoc)
			set i = i + 1
		endloop
		
		call RemoveLocation(unitLoc)
		
		set newUnit = null
		set unitLoc = null
		set newLoc = null
	endfunction
	
	private function SpawnTimer takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit factory = LoadUnitHandle( udg_hash, id, StringHash( "boss_factory" ) )

	    if IsUnitDead(factory) or not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
	    else
	        call Spawn(factory)
	    endif

	    set factory = null
	endfunction
	
	private function action takes nothing returns nothing
		call InvokeTimerWithUnit( GetEnteringUnit(), "boss_factory", bosscast(COOLDOWN), true, function SpawnTimer )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger()
	    call TriggerRegisterEnterRectSimple( trig, GetWorldBounds() )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope