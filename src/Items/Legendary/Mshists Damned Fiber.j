scope MshistDamnedFiber initializer init

	globals
		private constant integer ITEM_ID = 'I04L'
		private constant integer EFFECT = 'A1IB'
		
		private constant integer SPAWN_AMOUNT = 4
		private constant real SPAWN_DELAY = 1.5
		
		private constant real MIN_SPAWN_RANGE = 100
		private constant real SPAWN_RANGE = 350
	endglobals
	
	private function Spawn takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
		local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "damned_fiber" ) )
		local real x = LoadReal( udg_hash, id, StringHash( "damned_fiber_x" ) )
		local real y = LoadReal( udg_hash, id, StringHash( "damned_fiber_y" ) )
		local unit newUnit
	
		if udg_fightmod[0] then
			set newUnit = CreateUnit(GetOwningPlayer(caster), ID_SHEEP, x, y, GetUnitFacing(caster) )
	    	call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", x, y ) )
	    	call UnitAddAbility(newUnit, EFFECT)
    	endif
    	call FlushChildHashtable( udg_hash, id ) 
    	
    	set caster = null
		set newUnit = null
	endfunction
	
	private function SpawnImmortal takes unit caster, real x, real y returns nothing
		local integer id
		
    	set id = InvokeTimerWithUnit( caster, "damned_fiber", SPAWN_DELAY, false, function Spawn )
		call SaveReal( udg_hash, id, StringHash( "damned_fiber_x" ), x)
		call SaveReal( udg_hash, id, StringHash( "damned_fiber_y" ), y)
	endfunction
	
	//===========================================================================
	private function Delay takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
		local unit caster = LoadUnitHandle(udg_hash, id, StringHash( "damned_fiber_delay_unit" ) )
		local integer i
		local real dist 
		local real angle
		local real x
		local real y
		local unit newUnit
		
		set i = 1
		loop
			exitwhen i > SPAWN_AMOUNT
			set dist = GetRandomReal( MIN_SPAWN_RANGE, SPAWN_RANGE )
	        set angle = GetRandomReal( 0, 360 ) * bj_DEGTORAD
	        set x = GetUnitX( caster ) + dist * Cos( angle )
	        set y = GetUnitY( caster ) + dist * Sin( angle )
	        
	    	set newUnit = CreateUnit(GetOwningPlayer(caster), ID_SHEEP, x, y, GetUnitFacing(caster) )
	    	call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", x, y ) )
	    	call UnitAddAbility(newUnit, EFFECT)
			set i = i + 1
		endloop
		
		set caster = null
		set newUnit = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local item itemUsed = Trigger_GetItemUsed()
		local integer id 
		
		set id = InvokeTimerWithItem( itemUsed, "damned_fiber_delay", 1, false, function Delay )
		call SaveUnitHandle(udg_hash, id, StringHash( "damned_fiber_delay_unit" ), caster )

        set caster = null
        set itemUsed = null
	endfunction

	//===========================================================================
	private function OnDie_Condition takes nothing returns boolean
		return GetUnitAbilityLevel( AnyUnitDied.GetDataUnit("unit_died"), EFFECT ) > 0 
	endfunction
	
	private function OnDie takes nothing returns nothing
		local unit unitDied = AnyUnitDied.GetDataUnit("unit_died")

		call SpawnImmortal(unitDied, GetUnitX(unitDied), GetUnitY(unitDied))

		set unitDied = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, null, "caster")
		
		call AnyUnitDied.AddListener(function OnDie, function OnDie_Condition)
	endfunction

endscope