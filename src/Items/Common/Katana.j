scope Katana initializer init

	globals
		public trigger Trigger = null
	
		private constant integer ITEM_ID = 'I0CF'
		
		private constant integer MAX_RANDOM_DAMAGE = 30
	endglobals

	private function condition takes nothing returns boolean 
		//call BJDebugMsg("BanditArmorCrit")
		return udg_IsDamageSpell == false //udg_Set_Weapon_Logic[i + 72] and inv(udg_DamageEventSource, 'I030') > 0
	endfunction 

	private function action takes nothing returns nothing
		local unit caster = BeforeAttack.GetDataUnit("caster")
		local real damage = BeforeAttack.GetDataReal("damage") 
		local real extraDamage = IMinBJ( MAX_RANDOM_DAMAGE, GetRandomInt( 1 + GetUnitLuck(caster), MAX_RANDOM_DAMAGE ) )
	    
	    //call BJDebugMsg("works!")
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