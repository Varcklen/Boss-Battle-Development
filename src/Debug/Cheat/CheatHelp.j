scope CheatHelp initializer init

	globals
		public trigger Trigger = null
	endglobals


	private function action takes nothing returns nothing
		call CheatSystem_ShowInfo( GetTriggerPlayer() )
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-help", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope