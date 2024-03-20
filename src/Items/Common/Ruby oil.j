scope RubyOil initializer init

	globals
		private constant integer ITEM_ID = 'I0CG'
		
		private constant real SELF_DAMAGE_PERC = 0.2
	endglobals

	private function condition takes nothing returns boolean 
		return udg_IsDamageSpell == false
	endfunction 

	private function action takes nothing returns nothing
		local unit caster = AfterAttack.GetDataUnit("caster")
		local real damage = AfterAttack.GetDataReal("damage") * SELF_DAMAGE_PERC
	    
	    call SetUnitState( caster, UNIT_STATE_LIFE, RMaxBJ( 0, GetUnitState( caster, UNIT_STATE_LIFE ) - damage ) )
	    
	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction
	
endscope