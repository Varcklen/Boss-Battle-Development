scope CheatRemoveRewardOption initializer init

	globals
		public trigger Trigger = null
	endglobals
	
	private function action takes nothing returns nothing			
		call BJDebugMsg("Removed 1 extra reward option.")
		call ItemRandomizerLib_AddRewardSelectionOption(Player(0), -1)
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-removereward", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope