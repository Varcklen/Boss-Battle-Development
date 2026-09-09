scope MagicVaultDamage initializer init
	
	private function condition takes nothing returns boolean
		return udg_IsDamageSpell == false and GetUnitTypeId( udg_DamageEventTarget ) == 'h01W'
	endfunction
	
	private function action takes nothing returns nothing
		set udg_DamageEventType = udg_DamageTypeIgnore
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_DamageModifierEvent", function action, function condition )
	endfunction
	
endscope