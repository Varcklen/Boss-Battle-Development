scope Armadillo initializer init

	globals
		public trigger Trigger = null
	
		private constant integer ITEM_ID = 'I0D4'
		
		private constant real DAMAGE_REDUCTION_PERC = -0.6
	endglobals

	private function condition takes nothing returns boolean 
		if GetUnitAbilityLevel( BeforeAttack.TargetUnit, 'BPSE' ) > 0 then
			return true
		elseif GetUnitAbilityLevel( BeforeAttack.TargetUnit, 'BNsi' ) > 0 then
			return true
		elseif GetUnitAbilityLevel( BeforeAttack.TargetUnit, 'B043' ) > 0 then
			return true
		endif
		return false
	endfunction 

	private function action takes nothing returns nothing
		local unit caster = BeforeAttack.GetDataUnit("caster")
		local real damage = BeforeAttack.GetDataReal("damage") 
		local real extraDamage = BeforeAttack.GetDataReal("static_damage") * DAMAGE_REDUCTION_PERC
	    
	    //call BJDebugMsg("works!")
	    call BeforeAttack.SetDataReal("damage", damage + extraDamage )
	    
	    set caster = null
	endfunction
	
	//===========================================================================
	public function Enable takes nothing returns nothing
		call BlzItemAddAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A175' )
    endfunction
    
    public function Disable takes nothing returns nothing
		call BlzItemRemoveAbilityBJ( WeaponPieceSystem_WeaponData.TriggerItem, 'A175' )
    endfunction
	
	private function init takes nothing returns nothing
	    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, BeforeAttack, function action, function condition, "target" )
	endfunction

endscope