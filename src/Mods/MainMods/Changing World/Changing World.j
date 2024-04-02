scope ChangingWorld initializer init

	globals
		public trigger Trigger = null
	
		private boolean FirstLaunch = true
		private constant integer AMOUNT_OF_MODS = 3
	endglobals

	private function Switch takes nothing returns nothing
		local integer i
        local Mode mode
        
		if FirstLaunch then
			set FirstLaunch = false
		else
			set i = 1
	        loop
	        	exitwhen i > AMOUNT_OF_MODS
	        	set mode = ModeSystem_GetRandomBless(true)
	            call ModeSystem_Disable(mode)
	            
	            set mode = ModeSystem_GetRandomCurse(true)
	            call ModeSystem_Disable(mode)
	            set i = i + 1
	        endloop
		endif
		
		set i = 1
        loop
        	exitwhen i > AMOUNT_OF_MODS
        	set mode = ModeSystem_GetRandomBless(false)
            call ModeSystem_Enable(mode)
            
            set mode = ModeSystem_GetRandomCurse(false)
            call ModeSystem_Enable(mode)
            set i = i + 1
        endloop
        
        call DisplayTimedTextToForce( GetPlayersAll(), 5, "|cffffcc00Warning!|r The world is changing!" )
	endfunction

	private function OnBattleEnd takes nothing returns nothing
		if udg_fightmod[3] then
			return
		endif
		call Switch()
	endfunction

	private function init takes nothing returns nothing
		set Trigger = BattleEndGlobal.AddListener(function OnBattleEnd, null)
		call DisableTrigger( Trigger )
	endfunction

endscope