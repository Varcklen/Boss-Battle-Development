scope OrbFoggySwamp initializer init

	globals
		private constant integer ITEM_ID = 'I0FZ'
		
		private constant integer MINION_ID = 'e009'
		private constant integer DURATION = 15
		private constant string ANIMATION = "war3mapImported\\SoulRitual.mdx"
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitAlive(AnyUnitDied.TriggerUnit) and IsUnitEnemy(AnyUnitDied.TargetUnit, GetOwningPlayer( AnyUnitDied.TriggerUnit ) )
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = AnyUnitDied.GetDataUnit("caster")
		local unit unitDied = AnyUnitDied.GetDataUnit("unit_died")
		local unit newUnit
		local real x = GetUnitX(unitDied)
		local real y = GetUnitY(unitDied)
		
        call DestroyEffect( AddSpecialEffect( ANIMATION, x, y ) )
        set newUnit = CreateUnit(GetOwningPlayer(caster), MINION_ID, x, y, GetRandomInt( 0, 360 ))
        call UnitApplyTimedLife( newUnit, 'BTLF', DURATION )

		set unitDied = null
		set newUnit = null
        set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, AnyUnitDied, function action, function condition, "caster")
	endfunction

endscope