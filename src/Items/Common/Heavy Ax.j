scope HeavyAx initializer init

	globals
		public trigger Trigger = null
	
		private constant integer ITEM_ID = 'I04W'
	endglobals

	private function condition takes nothing returns boolean 
		return udg_IsDamageSpell == false and luckylogic( BeforeAttack.TriggerUnit, 10, 1, 100 )
	endfunction 

	private function action takes nothing returns nothing
		local unit caster = BeforeAttack.GetDataUnit("caster")
		local real damage = BeforeAttack.GetDataReal("damage") 
		local real extraDamage = damage * 2
	    
	    //call BJDebugMsg("works!")
	    set udg_DamageEventType = udg_DamageTypeCriticalStrike
	    call BeforeAttack.SetDataReal("damage", damage + extraDamage )
	    
	    set caster = null
	endfunction
	
	//===========================================================================
	public function Enable takes nothing returns nothing
		
    endfunction
    
    public function Disable takes nothing returns nothing
		
    endfunction
	
	private function init takes nothing returns nothing
	    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, BeforeAttack, function action, function condition, "caster" )
	endfunction
	
endscope