scope BlessChaosEarning initializer init

	globals
		private trigger Trigger = null
		
		private integer count = 0
		private boolean isActive = false
	endglobals
	
	private function UniqueChange takes integer k returns nothing
        local integer i = 1
        loop
            exitwhen i > 4
            if udg_hero[i] != null then
                call skillst( i, k )
            endif
            set i = i + 1
        endloop
    endfunction
	
    private function ChaosEarring_Conditions takes nothing returns boolean
        return udg_fightmod[3] == false
    endfunction

    private function ChaosEarring_Actions takes nothing returns nothing
        set count = count + 1
        if count >= 3 then
            call UniqueChange(1)
            set isActive = true
        endif
    endfunction

    private function ChaosEarringEnd_Conditions takes nothing returns boolean
        return isActive
    endfunction

    private function ChaosEarringEnd_Actions takes nothing returns nothing
        call UniqueChange(-1)
        set count = 0
        set isActive = false
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightStartGlobal_Real", function ChaosEarring_Actions, function ChaosEarring_Conditions )
		call DisableTrigger( Trigger )
		
		call CreateEventTrigger( "udg_FightEndGlobal_Real", function ChaosEarringEnd_Actions, function ChaosEarringEnd_Conditions )
	endfunction

endscope