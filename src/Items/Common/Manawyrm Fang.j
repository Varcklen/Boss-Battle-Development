scope ManawyrmFang initializer init

	globals
		private constant integer ITEM_ID = 'I0A2'
		
		private constant real MANA_RESTORE_PERC = 0.1
	endglobals

	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell == false
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = AfterAttack.GetDataUnit("caster")
	    local real damage = AfterAttack.GetDataReal("damage")
	    
        call manast( hero, null, damage * MANA_RESTORE_PERC )
	    
	    set hero = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition )
	endfunction

endscope