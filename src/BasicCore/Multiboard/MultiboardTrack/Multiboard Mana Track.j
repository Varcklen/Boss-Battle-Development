scope MultiboardManaTrack initializer init

	globals
		public trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		if ExtraArenaGeneral_IsPvPActive() then
			return false
		endif
		if combat( Event_AfterManaRestore_Caster, false,  0 ) == false then
			return false
		endif
		return true
	endfunction
	
	private function action takes nothing returns nothing
		local real heal = Event_AfterManaRestore_Amount
		local integer i = GetPlayerId( GetOwningPlayer( Event_AfterManaRestore_Caster ) ) + 1
		local integer columnPos = Multiboard_GetPlayerColumn(i)
		
		set udg_ManaAllTime[i] = udg_ManaAllTime[i] + heal
		set udg_ManaFight[i] = udg_ManaFight[i] + heal
        call Multiboard_MultiSetValue( 11, columnPos, R2SI( udg_ManaAllTime[i] ) )
        call Multiboard_MultiSetValue( 12, columnPos,  R2SI( udg_ManaFight[i] ) )
	endfunction
	
	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "Event_AfterManaRestore", function action, function condition )
		call DisableTrigger(Trigger)
	endfunction

endscope