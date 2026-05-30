scope CheatLuck initializer init

	globals
		public trigger Trigger = null
	endglobals
	
	private function action takes nothing returns nothing			
		call BJDebugMsg("Luck Added.")
		call luckyst( udg_hero[1], 50 )
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-luck", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope