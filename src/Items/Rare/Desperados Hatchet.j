scope DesperadoHatchet initializer init

	globals
		public trigger Trigger = null
	
		private constant integer ITEM_ID = 'I0CP'
	endglobals

	private function condition takes nothing returns boolean 
		return udg_IsDamageSpell == false 
	endfunction 

	private function action takes nothing returns nothing
		local unit caster = BeforeAttack.GetDataUnit("caster")
		local real damage = BeforeAttack.GetDataReal("damage") 
		local real extraDamage = 2 * BeforeAttack.GetDataReal("static_damage") 
	    
        if LuckChance( caster, 50 ) then
            call BeforeAttack.SetDataReal("damage", damage + extraDamage )
        else
        	set udg_DamageEventType = udg_DamageTypeBlocked
            call BeforeAttack.SetDataReal("damage", 0 )
        endif
	    
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