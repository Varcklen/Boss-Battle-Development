scope RunestoneZi initializer init

	globals
		private constant integer ITEM_ID = 'I04F'
	endglobals

	private function condition takes nothing returns boolean 
		return udg_IsDamageSpell and SetCount_IsActive( AfterAttack.TriggerUnit, SET_RUNE) == false
	endfunction 

	private function action takes nothing returns nothing
		local unit caster = AfterAttack.GetDataUnit("caster")
		local real damage = AfterAttack.GetDataReal("damage") 
		local real healthRemove = damage * 0.15
	    
	    call SetUnitState( caster, UNIT_STATE_LIFE, RMaxBJ(0, GetUnitState( caster, UNIT_STATE_LIFE ) - healthRemove ) )
	    
	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction

endscope