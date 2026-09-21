scope CheatMultiplayer initializer init

	globals
		public trigger Trigger = null
	endglobals
	
	private function action takes nothing returns nothing			
		set IsSinglePlayer = IsSinglePlayer == false
		if IsSinglePlayer then
			call BJDebugMsg("Singleplayer enabled.")
		else
			call BJDebugMsg("Singleplayer disabled.")
		endif
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-multiplayer", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope