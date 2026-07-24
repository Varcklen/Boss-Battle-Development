scope OgreClub initializer init

	globals
		public trigger Trigger = null
	
		private constant integer ITEM_ID = 'I02E'
	endglobals

	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell == false and GetHeroInt( AfterAttack.TriggerUnit, true) <= 20
	endfunction

	private function action takes nothing returns nothing
	    local unit caster = AfterAttack.GetDataUnit("caster")

	    call manast( caster, null, 5 )
    	call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Undead\\ReplenishMana\\SpiritTouchTarget.mdl", caster, "origin") )

	    set caster = null
	endfunction
	
	public function Enable takes nothing returns nothing
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A05I' )
    endfunction
    
    public function Disable takes nothing returns nothing
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A05I' )
    endfunction
    
    //===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction

endscope