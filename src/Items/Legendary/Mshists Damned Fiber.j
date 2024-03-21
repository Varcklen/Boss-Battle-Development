scope MshistDamnedFiber initializer init

	globals
		private constant integer ITEM_ID = 'I04L'
		
		private constant integer MINION_DURATION = 30
	endglobals
	
	private function condition takes nothing returns boolean
		return GetUnitTypeId(AnyUnitDied.TargetUnit) != ID_SHEEP and IsUnitAlive( AnyUnitDied.TriggerUnit)
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = AnyUnitDied.GetDataUnit("caster")
		local unit unitDied = AnyUnitDied.GetDataUnit("unit_died")
		local unit newUnit
		local real x = GetUnitX(unitDied)
		local real y = GetUnitY(unitDied)
		
		call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", x, y ) )
        set newUnit = CreateUnit(GetOwningPlayer(caster), ID_SHEEP, x, y, GetRandomInt( 0, 360 ))
        call UnitApplyTimedLife( newUnit, 'BTLF', MINION_DURATION )

		set newUnit = null
        set caster = null
        set unitDied = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, AnyUnitDied, function action, function condition, "caster")
	endfunction

endscope