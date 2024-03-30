scope CheatBerserk initializer init

	globals
		public trigger Trigger = null
		
		private constant integer DURATION = 10
	endglobals

	private function end takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local unit hero = LoadUnitHandle(udg_hash, id, StringHash("bers_end") )
		
		call berserk( hero, -1 )
		
		set hero = null
	endfunction

	private function action takes nothing returns nothing
		call BJDebugMsg("Berserk mode for " + I2S(DURATION) +" seconds enabled.")
	    call berserk( udg_hero[1], 1 )
	    call InvokeTimerWithUnit( udg_hero[1], "bers_end", DURATION, false, function end )
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-rage", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope