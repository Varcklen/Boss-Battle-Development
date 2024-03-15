scope Vampirism initializer init

	globals
		private boolean Loop = false	
	endglobals

	private function condition takes nothing returns boolean
		return Loop == false and StatSystem_IsHero(udg_DamageEventSource) and StatSystem_Get(udg_DamageEventSource, STAT_VAMPIRISM) > 0
	endfunction

	private function action takes nothing returns nothing
		local real heal = udg_DamageEventAmount * StatSystem_Get(udg_DamageEventSource, STAT_VAMPIRISM)
		
		set Loop = true
        call healst( udg_DamageEventSource, null, heal )
        call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", udg_DamageEventSource, "origin" ) )
        set Loop = false
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	endfunction

endscope