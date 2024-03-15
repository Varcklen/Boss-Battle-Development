scope MoonSetDamageBonus initializer init

	private function condition takes nothing returns boolean
		return StatSystem_Get(Event_UntilMoonSetCast_Hero, STAT_MOON_SET_DAMAGE_DEALT) != 0
	endfunction

	private function action takes nothing returns nothing
		local real multiplier = StatSystem_Get(Event_UntilMoonSetCast_Hero, STAT_MOON_SET_DAMAGE_DEALT)
		local real damageGain = Event_UntilMoonSetCast_Static_Damage * multiplier
		
        set Event_UntilMoonSetCast_Damage = Event_UntilMoonSetCast_Damage + damageGain
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_UntilMoonSetCast_Real", function action, function condition )
	endfunction

endscope