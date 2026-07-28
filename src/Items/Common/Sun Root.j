scope SunRoot initializer init

	globals
		private constant integer ITEM_ID = 'I08E'
		
		private constant integer HEAL_REQUIRE = 200
		private constant integer ADDITIONAL_HEAL = 200
	endglobals
	
	private function condition takes nothing returns boolean 
		return BeforeHeal.GetDataReal("static_heal") >= HEAL_REQUIRE
	endfunction 
	
	private function action takes nothing returns nothing 
		local real heal = BeforeHeal.GetDataReal("heal")
		
		call BeforeHeal.SetDataReal("heal", heal + ADDITIONAL_HEAL)
	endfunction 

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BeforeHeal, function action, function condition, "caster")
	endfunction

endscope