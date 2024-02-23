scope OutOfCombatTimer initializer init

	globals
		public timer Timer = CreateTimer() //timer[1]
		public timer TimerWarning = CreateTimer()  //timer[2]
		public timer RepickDisableTimer = CreateTimer()  //timer[3]
		private timerdialog Dialog = CreateTimerDialog(Timer)  //timerdialog[2]
		
		private constant integer WARNING_TIME_DEVIATION = 20
		private constant integer FIRST_TIMER_TIME = 120
		private constant integer REPICK_DISABLE_TIME = 115
		private constant string DIALOG_DESCRIPTION = "Start of the battle:"
	endglobals


	/*OnFightStart*/
	private function OnFightStart takes nothing returns nothing
	    if IsSinglePlayer == false then
    		call PauseTimer( Timer )
    		call PauseTimer( TimerWarning )
		endif
		call TimerDialogDisplay( Dialog, false )
	endfunction
	
	
	/*OnFightEnd*/
	private function OnFightEnd_Condition takes nothing returns boolean
		return udg_real[1] > 0 and not( udg_logic[43] ) and not(udg_logic[97]) and IsSinglePlayer == false
	endfunction
	
	private function OnFightEnd takes nothing returns nothing
        call TimerStart( Timer, udg_real[1], false, null )
        call TimerStart( TimerWarning, udg_real[1] - WARNING_TIME_DEVIATION, false, null )
        
        call TimerDialogDisplay( Dialog, true)
	endfunction
	
	
	/*OnStart*/
	private function OnStart_Condition takes nothing returns boolean
		return IsSinglePlayer == false
	endfunction
	
	private function OnStart takes nothing returns nothing
    	call TimerStart( Timer, FIRST_TIMER_TIME, false, null )
        call PauseTimer( Timer )
        
        call TimerDialogSetTitle( Dialog, DIALOG_DESCRIPTION )
        call TimerDialogDisplay( Dialog, true)
        
        call TimerStart( RepickDisableTimer, REPICK_DISABLE_TIME, false, null )
        call PauseTimer( RepickDisableTimer)
	endfunction
	
	
	/*OnHeroChoose*/
	private function OnHeroChoose_Condition takes nothing returns boolean
        local integer i 
        
        if IsSinglePlayer then
            return false
        endif
        set i = 1
        loop
            exitwhen i > PLAYERS_LIMIT
            if udg_hero[i] == null and GetPlayerSlotState(ConvertedPlayer(i)) == PLAYER_SLOT_STATE_PLAYING then
                return false
            endif
            set i = i + 1
        endloop 
        return true
    endfunction
	
	private function OnHeroChoose takes nothing returns nothing
        call ResumeTimer( Timer )
        call ResumeTimer( RepickDisableTimer )
	endfunction
	
	
	/*OnHeroRepick*/
	private function OnHeroRepick_Condition takes nothing returns boolean
		return IsSinglePlayer == false and PlayerLeave_IsPlayerLeaver(Event_HeroRepick_Player) == false
	endfunction
	
	private function OnHeroRepick takes nothing returns nothing
		//call BJDebugMsg("OnHeroRepick")
        call PauseTimer( Timer )
        call PauseTimer( TimerWarning )
        call PauseTimer( RepickDisableTimer )
	endfunction


	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateEventTrigger( "udg_FightStartGlobal_Real", function OnFightStart, null )
	    call CreateEventTrigger( "udg_FightEndGlobal_Real", function OnFightEnd, function OnFightEnd_Condition )
	    call CreateEventTrigger( "Event_Start", function OnStart, function OnStart_Condition )
	    call CreateEventTrigger( "Event_HeroChoose_Real", function OnHeroChoose, function OnHeroChoose_Condition )
	    call CreateEventTrigger( "Event_HeroRepick_Real", function OnHeroRepick, function OnHeroRepick_Condition )
	endfunction

endscope