library StartingBonusDatabase initializer init

	globals
		private integer array StartingBonuses_Safe[50]
		private integer StartingBonusesSafeMax = 0
		private integer array StartingBonuses_Extreme[50]
		private integer StartingBonusesExtremeMax = 0
	endglobals
	
	private function action takes nothing returns nothing
		set udg_base = 0
    	set StartingBonuses_Safe[BaseNum()] = 'I03U'
    	set StartingBonuses_Safe[BaseNum()] = 'I05E'
    	set StartingBonuses_Safe[BaseNum()] = 'I05M'
    	set StartingBonuses_Safe[BaseNum()] = 'I01Q'
    	set StartingBonusesSafeMax = udg_base
    	
    	set udg_base = 0
    	set StartingBonuses_Extreme[BaseNum()] = 'I02U'
    	set StartingBonuses_Extreme[BaseNum()] = 'I04P'
    	set StartingBonuses_Extreme[BaseNum()] = 'I04Q'
    	set StartingBonuses_Extreme[BaseNum()] = 'I04J'
    	set StartingBonusesExtremeMax = udg_base
	endfunction
	
	private function IsBonusExcepted takes ListInt exceptions, integer bonus returns boolean
		local integer i
		local integer iMax
		
		//call BJDebugMsg("exceptions.Size: " + I2S(exceptions.Size))
		set i = 0
		set iMax = exceptions.Size
		loop
			exitwhen i >= iMax
			//call BJDebugMsg("Iteration: " + I2S(i))
			if bonus == exceptions.GetIntegerByIndex(i) then
				return true
			endif
			set i = i + 1
		endloop
		
		return false
	endfunction
	
	public function GetRandomSafeStartingBonus takes ListInt exceptions returns integer
		local integer bonus
		
		if exceptions == 0 then
			return StartingBonuses_Safe[GetRandomInt(1, StartingBonusesSafeMax)]
		endif
		
		loop
			set bonus = StartingBonuses_Safe[GetRandomInt(1, StartingBonusesSafeMax)]
			exitwhen IsBonusExcepted(exceptions, bonus) == false
		endloop
		return bonus
	endfunction
	
	public function GetRandomExtremeStartingBonus takes ListInt exceptions returns integer
		local integer bonus
		
		if exceptions == 0 then
			return StartingBonuses_Extreme[GetRandomInt(1, StartingBonusesSafeMax)]
		endif
		
		loop
			set bonus = StartingBonuses_Extreme[GetRandomInt(1, StartingBonusesExtremeMax)]
			exitwhen IsBonusExcepted(exceptions, bonus) == false
		endloop
		return bonus
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call TimerStart( CreateTimer(), 0.2, false, function action )
	endfunction

endlibrary