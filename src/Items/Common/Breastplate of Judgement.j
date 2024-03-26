scope BreastplateOfJudgement initializer init

	globals
		private constant integer ITEM_ID = 'I0DT'
		
		private constant integer EXTRA_DAMAGE = 15
	endglobals

	private function action takes nothing returns nothing
		local real damage = BeforeAttack.GetDataReal("damage") 
	    
	    call BeforeAttack.SetDataReal("damage", damage + EXTRA_DAMAGE )
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BeforeAttack, function action, null, "caster" )
	endfunction
	
endscope