scope Icethorn initializer init

	globals
		private constant integer ITEM_ID = 'I0CN'
		
		private constant real SHIELD_GAIN_PERC = 0.3
	endglobals
	
	private function condition takes nothing returns boolean
		return GetUnitState( AfterHeal.TargetUnit, UNIT_STATE_LIFE ) == GetUnitState( AfterHeal.TargetUnit, UNIT_STATE_MAX_LIFE )
	endfunction

	private function action takes nothing returns nothing
		local unit caster = AfterHeal.GetDataUnit("caster")
		local unit target = AfterHeal.GetDataUnit("target")
		local real heal = AfterHeal.GetDataReal("raw_heal")
		
	    call shield( caster, target, heal * SHIELD_GAIN_PERC )

        set caster = null
        set target = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterHeal, function action, function condition, "caster" )
	endfunction

endscope