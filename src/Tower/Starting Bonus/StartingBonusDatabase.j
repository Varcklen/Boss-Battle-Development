library StartingBonusDatabase initializer init

	globals
		private integer array StartingBonuses[50]
		private integer StartingBonusesMax = 0
	endglobals
	
	private function action takes nothing returns nothing
		set udg_base = 0
    	set StartingBonuses[BaseNum()] = 'I03U'
    	set StartingBonuses[BaseNum()] = 'I05E'
    	set StartingBonuses[BaseNum()] = 'I05M'
    	set StartingBonuses[BaseNum()] = 'I01Q'
    	
    	set StartingBonusesMax = udg_base
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
	
	public function GetRandomStartingBonus takes ListInt exceptions returns integer
		local integer bonus
		
		if exceptions == 0 then
			return StartingBonuses[GetRandomInt(1, StartingBonusesMax)]
		endif
		
		loop
			set bonus = StartingBonuses[GetRandomInt(1, StartingBonusesMax)]
			exitwhen IsBonusExcepted(exceptions, bonus) == false
		endloop
		return bonus
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call TimerStart( CreateTimer(), 0.2, false, function action )
	endfunction

endlibrary