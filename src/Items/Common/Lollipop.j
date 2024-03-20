scope Lollipop initializer init

	globals
		private constant integer ITEM_ID = 'I0A0'
		
		private constant real HEAL_BONUS_PERC = 1
		private constant integer CHANCE = 25
	endglobals

	private function condition takes nothing returns boolean
		return LuckChance( BeforeHeal.TriggerUnit, CHANCE) 
	endfunction

	private function action takes nothing returns nothing
		local real extraHeal = BeforeHeal.GetDataReal("static_heal") * HEAL_BONUS_PERC
		local real heal = BeforeHeal.GetDataReal("heal") 
	    
	    call BeforeHeal.SetDataReal("heal", heal + extraHeal )
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BeforeHeal, function action, function condition, "caster" )
	endfunction

endscope