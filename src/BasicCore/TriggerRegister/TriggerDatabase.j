library TriggerDatabase initializer init

	globals
		public playerunitevent array EventUsed
		public integer EventUsed_Max = 1
		
		public string array EventUsedCustom
		public integer EventUsedCustom_Max = 1
	endglobals
	
	private function SetEventUsed takes playerunitevent eventUsed returns nothing
		set EventUsed[EventUsed_Max] = eventUsed
		set EventUsed_Max = EventUsed_Max + 1
    endfunction
    
    private function SetEventUsedCustom takes string eventUsed returns nothing
		set EventUsedCustom[EventUsedCustom_Max] = eventUsed
		set EventUsedCustom_Max = EventUsedCustom_Max + 1
    endfunction
	
	private function init takes nothing returns nothing
		call SetEventUsed(EVENT_PLAYER_UNIT_SPELL_EFFECT)
		
		call SetEventUsedCustom("udg_FightStart_Real")
		//call SetEventUsedCustom("Event_OnDamageChange_Real")
    endfunction

endlibrary