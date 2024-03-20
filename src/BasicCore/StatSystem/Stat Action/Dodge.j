scope Dodge initializer init

	private function condition takes nothing returns boolean
		return udg_IsDamageSpell == false and StatSystem_IsHero(udg_DamageEventTarget)
	endfunction

	private function action takes nothing returns nothing
		local real dodgeChance = StatSystem_Get(udg_DamageEventTarget, STAT_DODGE)
		
		//call BJDebugMsg("chance: " + R2S(dodgeChance * 100))
		if dodgeChance <= BASE_VALUE then
			return
		endif
		
		//call BJDebugMsg("1")
		if LuckChance(udg_DamageEventTarget, R2I(dodgeChance * 100)) == false then
			return
		endif
		
		//call BJDebugMsg("Ignored!")
		set udg_DamageEventAmount = 0
        set udg_DamageEventType = udg_DamageTypeBlocked
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_OnDamageChange_Real", function action, function condition )
	endfunction

endscope