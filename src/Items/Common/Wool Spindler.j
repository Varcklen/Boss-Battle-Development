scope WoolSpindler initializer init

	globals
		private constant integer ITEM_ID = 'I0EY'
		
		private constant integer GOLD_GAIN = 3
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitAlive(AnyUnitDied.TriggerUnit) and combat(AnyUnitDied.TriggerUnit, false, 0) and udg_fightmod[3] == false and GetUnitTypeId(AnyUnitDied.TargetUnit) == ID_SHEEP
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = AnyUnitDied.GetDataUnit("caster")
		
        call moneyst( caster, GOLD_GAIN)

        set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, AnyUnitDied, function action, function condition, "caster")
	endfunction

endscope