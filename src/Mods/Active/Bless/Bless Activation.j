scope BlessActivation initializer init

	globals
		private trigger Trigger = null
		
		private constant integer USES_REQUIRE = 4
		
		private constant integer STRING_HASH = StringHash( "bless_activation" )
	endglobals
	
	private function condition takes nothing returns boolean
		return combat(ItemUsed.TriggerUnit, false, 0) and udg_fightmod[3] == false
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = ItemUsed.GetDataUnit("caster")
		local integer amountOfUses = ItemUsed.GetDataInteger("amount_of_uses")
		local integer id = GetHandleId( caster )
		local integer counter = LoadInteger( udg_hash, id, STRING_HASH ) + 1
	
        if counter >= USES_REQUIRE then
            set counter = 0
            set amountOfUses = ItemUsed.GetDataInteger("amount_of_uses")
            call ItemUsed.SetDataInteger("amount_of_uses", amountOfUses + 1)
        elseif IsUnitAlive(caster) then
            call textst( I2S( counter ) + "/" + I2S(USES_REQUIRE), caster, 64, GetRandomReal( 45, 135 ), 10, 1.5 )
        endif
        call SaveInteger( udg_hash, id, STRING_HASH, counter )
        
        set caster = null
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = ItemUsed.AddListener(function action, function condition)
		call DisableTrigger( Trigger )
	endfunction

endscope