scope BrassKnuckles initializer init

	globals
		public trigger Trigger = null
	
		private constant integer ITEM_ID = 'I02O'
	endglobals

	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell == false and luckylogic( AfterAttack.TriggerUnit, 15, 1, 100 )
	endfunction
	
	private function action takes nothing returns nothing
	    local unit target = AfterAttack.GetDataUnit("target")
	    local unit caster = AfterAttack.GetDataUnit("caster")
	    
	    call UnitStun(caster, target, 0.75 )
	
	    set caster = null
	    set target = null
	endfunction
	
	public function Enable takes nothing returns nothing
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0QX' )
    endfunction
    
    public function Disable takes nothing returns nothing
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A0QX' )
    endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction

endscope