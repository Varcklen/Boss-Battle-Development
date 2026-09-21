scope BanditArmorStun initializer init

	globals
		private constant integer ITEM_ID = 'I06K'
		
		private constant integer CHANCE = 25
		private constant real BUFF_DURATION = 1.5
		private constant integer EFFECT_ID = 'A1K2'
		private constant integer BUFF_ID = 'B0BC'
	endglobals

	private function condition takes nothing returns boolean 
		return udg_IsDamageSpell == false and LuckChance( AfterAttack.TriggerUnit, CHANCE )
	endfunction 

	private function action takes nothing returns nothing
		local unit target = AfterAttack.GetDataUnit("target")
		local unit caster = AfterAttack.GetDataUnit("caster")
		local real duration = timebonus(caster, BUFF_DURATION)
	    
	    call bufallst( caster, target, EFFECT_ID, 0, 0, 0, 0, BUFF_ID, "bandit_dizzy", duration )
	    
	    set caster = null
	    set target = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction
	
endscope