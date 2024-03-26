scope BanditSilentSteps initializer init

	globals
		private constant integer ITEM_ID = 'I06B'
		
		private constant integer CHANCE = 15
		private constant real STUN_DURATION = 1
	endglobals

	private function condition takes nothing returns boolean 
		return udg_IsDamageSpell == false and LuckChance( AfterAttack.TriggerUnit, CHANCE )
	endfunction 

	private function action takes nothing returns nothing
		local unit target = AfterAttack.GetDataUnit("target")
		local unit caster = AfterAttack.GetDataUnit("caster")
	    
	    call UnitStun(caster, target, STUN_DURATION )
	    
	    set caster = null
	    set target = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction
	
endscope