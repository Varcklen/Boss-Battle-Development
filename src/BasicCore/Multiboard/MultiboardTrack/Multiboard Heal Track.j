scope MultiboardHealTrack initializer init

	globals
		public trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		if ExtraArenaGeneral_IsPvPActive() then
			return false
		endif
		if combat( Event_AfterHeal_Caster, false,  0 ) == false then
			return false
		endif
		return true
	endfunction
	
	private function action takes nothing returns nothing
		local real heal = Event_AfterHeal_Heal
		local integer i = GetPlayerId( GetOwningPlayer( Event_AfterHeal_Caster ) ) + 1
		local integer columnPos = Multiboard_GetPlayerColumn(i)
		
		set udg_HealFight[i] = udg_HealFight[i] + heal
        set udg_HealAllTime[i] = udg_HealAllTime[i] + heal
        call Multiboard_MultiSetValue( 9,  columnPos, R2SI( udg_HealAllTime[i] ) )
        call Multiboard_MultiSetValue( 10, columnPos,  R2SI( udg_HealFight[i] ) )
	endfunction
	
	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "Event_AfterHeal_Real", function action, function condition )
		call DisableTrigger(Trigger)
	endfunction

endscope