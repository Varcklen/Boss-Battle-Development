scope OgreE initializer init
	
	globals
		private constant integer ABILITY_ID = 'A0EW'
		
		private constant real STUN_DURATION_INITIAL = 0.25
		private constant real STUN_DURATION_PER_LEVEL = 0.25
		private constant integer EXTRA_DAMAGE_INITIAL = 50
		private constant integer EXTRA_DAMAGE_PER_LEVEL = 50
		private constant integer CHANCE = 5
	endglobals

	private function condition takes nothing returns boolean
		return GetUnitAbilityLevel(udg_DamageEventSource, ABILITY_ID) > 0 and LuckChance( udg_DamageEventSource, CHANCE )
	endfunction
	
	private function action takes nothing returns nothing
		local integer level = GetUnitAbilityLevel(udg_DamageEventSource, ABILITY_ID)
		local real stunDuration = STUN_DURATION_INITIAL + STUN_DURATION_PER_LEVEL * level
		local real damage = EXTRA_DAMAGE_INITIAL + EXTRA_DAMAGE_PER_LEVEL * level
		
        call UnitStun(udg_DamageEventSource, udg_DamageEventTarget, stunDuration )
        set udg_DamageEventAmount = udg_DamageEventAmount + damage
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_DamageModifierEvent", function action, function condition )
	endfunction
	
endscope