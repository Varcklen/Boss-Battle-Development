scope HookHands initializer init

	globals
		public trigger Trigger = null
		private constant integer ITEM_ID = 'I079'
	
		private constant integer VALUE_TO_ADD = 10
		private constant integer STAT_TYPE = STAT_DAMAGE_DEALT_PHY
		
		private constant real STUN_DURATION = 0.75
	endglobals
	
	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell == false and IsUnitType( AfterAttack.GetDataUnit("target"), UNIT_TYPE_HERO) == false and IsUnitType( AfterAttack.GetDataUnit("target"), UNIT_TYPE_ANCIENT) == false
	endfunction
	
	private function action takes nothing returns nothing
	    local unit target = AfterAttack.GetDataUnit("target")
	    local unit caster = AfterAttack.GetDataUnit("caster")
	    
	    call UnitStun(caster, target, STUN_DURATION )
	
	    set caster = null
	    set target = null
	endfunction

	public function Enable takes nothing returns nothing
		call StatSystem_Add( WeaponPieceSystem_WeaponData.TriggerUnit, STAT_TYPE, VALUE_TO_ADD)
    endfunction
    
    public function Disable takes nothing returns nothing
		call StatSystem_Add( WeaponPieceSystem_WeaponData.TriggerUnit, STAT_TYPE, -VALUE_TO_ADD)
    endfunction
    
    //===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction

endscope