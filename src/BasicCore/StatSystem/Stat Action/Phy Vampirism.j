scope PhyVampirism initializer init

	private function condition takes nothing returns boolean
		return udg_IsDamageSpell == false and StatSystem_IsHero(udg_DamageEventSource) and StatSystem_Get(udg_DamageEventSource, STAT_VAMPIRISM_PHY) > BASE_VALUE
	endfunction

	private function action takes nothing returns nothing
		local real heal = udg_DamageEventAmount * StatSystem_Get(udg_DamageEventSource, STAT_VAMPIRISM_PHY)
		
        call healst( udg_DamageEventSource, null, heal )
        call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", udg_DamageEventSource, "origin" ) )
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	endfunction

endscope