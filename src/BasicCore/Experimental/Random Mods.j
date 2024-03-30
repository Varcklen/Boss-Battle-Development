scope RandomMods initializer init

	globals
		private timer Timer = CreateTimer()	
		
		private boolean FirstLaunch = true
		private constant integer AMOUNT_OF_MODS = 3
		
		private constant real COOLDOWN = 20
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

	private function OnBattleStart takes nothing returns nothing
		if udg_fightmod[3] then
			return
		endif
		call TimerStart( Timer, COOLDOWN, true, function Switch )
	endfunction
	
	private function OnBattleEnd takes nothing returns nothing
		if udg_fightmod[3] then
			return
		endif
		call PauseTimer(Timer)
	endfunction

	private function Delay takes nothing returns nothing
		call BattleStartGlobal.AddListener(function OnBattleStart, null)
		call BattleEndGlobal.AddListener(function OnBattleEnd, null)
	endfunction
	
	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.5, false, function Delay )
	endfunction

endscope