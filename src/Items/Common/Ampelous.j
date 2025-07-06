scope Ampelous initializer init

	globals
		private constant integer ITEM_ID = 'I0HD'
		private constant real MAX_HEAL_BONUS = 0.5
	endglobals
	
	private function action takes nothing returns nothing
		local unit target = BeforeHeal.GetDataUnit("target")
		local real heal = BeforeHeal.GetDataReal("heal")
		local real hpPerc = GetUnitState( target, UNIT_STATE_LIFE)/BlzGetUnitMaxHP(target)
		local real healBonus = (1 - hpPerc) * 0.5
		
		call BeforeHeal.SetDataReal("heal", heal + (heal * healBonus))
		
		set target = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BeforeHeal, function action, null, "caster" )
	endfunction

endscope