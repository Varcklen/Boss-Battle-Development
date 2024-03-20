scope PennyPincher initializer init

	globals
		private constant integer ITEM_ID = 'I0C5'
		
		private constant integer GOLD_GAIN = 3
	endglobals

	private function condition takes nothing returns boolean 
		return udg_IsDamageSpell == false and combat( AfterAttack.TriggerUnit, false, 0 ) and not(udg_fightmod[3]) and IsUnitEnemy( AfterAttack.TriggerUnit, GetOwningPlayer( AfterAttack.TargetUnit ) )
	endfunction 

	private function action takes nothing returns nothing
		local unit caster = AfterAttack.GetDataUnit("caster")
	    
	    call moneyst(udg_DamageEventSource, GOLD_GAIN) 
	    
	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition )
	endfunction
	
endscope