scope MultiboardTrackEnabler initializer init

	globals
		private trigger array Triggers
		private integer MAX_TRIGGERS = 0
	endglobals
	
	private function SetData takes nothing returns nothing
		//call BJDebugMsg("SetData")
	
    	set udg_base = 0
    	
    	set Triggers[BaseNum()] = MultiboardDamageTrack_Trigger
    	set Triggers[BaseNum()] = MultiboardHealTrack_Trigger
    	set Triggers[BaseNum()] = MultiboardManaTrack_Trigger
    	
    	set MAX_TRIGGERS = udg_base
	endfunction
	
	//===========================================================================
	public function Enable takes nothing returns nothing
		local integer i = 1
		//call BJDebugMsg("Enable " + I2S(MAX_TRIGGERS))
		loop
			exitwhen i > MAX_TRIGGERS
			call EnableTrigger(Triggers[i])
			//call BJDebugMsg("name: " + I2S( GetHandleId(Triggers[i] ) ) )
			set i = i + 1
		endloop
	endfunction
	
	private function Disable takes nothing returns nothing
    	local integer i = 1
		loop
			exitwhen i > MAX_TRIGGERS
			call DisableTrigger(Triggers[i])
			set i = i + 1
		endloop
	endfunction
	
	//===========================================================================
    private function init takes nothing returns nothing
    	local trigger trig = CreateTrigger()
	    call TriggerRegisterTimerEvent( trig, 1, false)
	    call TriggerAddAction( trig, function SetData )
	    set trig = null

		call BattleStartGlobal.AddListener(function Enable, null)
		call BattleEndGlobal.AddListener(function Disable, null)
		call CreateEventTrigger( "Event_MatchEnd", function Disable, null )
	endfunction

endscope