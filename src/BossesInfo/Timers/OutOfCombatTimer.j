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
		
		private boolean Debug = false
	endglobals

	public function EnableDebug takes nothing returns nothing
		set Debug = true
	endfunction

	private function IsTimerWorks takes nothing returns boolean
		return IsSinglePlayer == false or Debug
	endfunction

	public function Launch takes real time returns nothing
		set time = RMaxBJ(time, 6)
		call TimerStart( Timer, time, false, null )
        call TimerStart( TimerWarning, time - WARNING_TIME_DEVIATION, false, null )
        
        call TimerDialogDisplay( Dialog, true)
	endfunction

	/*OnFightStart*/
	private function OnFightStart takes nothing returns nothing
	    if IsTimerWorks() then
    		call PauseTimer( Timer )
    		call PauseTimer( TimerWarning )
		endif
		call TimerDialogDisplay( Dialog, false )
	endfunction
	
	
	/*OnFightEnd*/
	private function OnFightEnd_Condition takes nothing returns boolean
		return udg_real[1] > 0 and not( IsVictory ) and not(udg_logic[97]) and IsTimerWorks()
	endfunction
	
	private function OnFightEnd takes nothing returns nothing
		call Launch(udg_real[1])
        /*call TimerStart( Timer, udg_real[1], false, null )
        call TimerStart( TimerWarning, udg_real[1] - WARNING_TIME_DEVIATION, false, null )
        
        call TimerDialogDisplay( Dialog, true)*/
	endfunction
	
	
	/*OnStart*/
	private function OnStart_Condition takes nothing returns boolean
		return IsTimerWorks()
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
		return IsTimerWorks() and PlayerLeave_IsPlayerLeaver(Event_HeroRepick_Player) == false
	endfunction
	
	private function OnHeroRepick takes nothing returns nothing
		//call BJDebugMsg("OnHeroRepick")
        call PauseTimer( Timer )
        call PauseTimer( TimerWarning )
        call PauseTimer( RepickDisableTimer )
	endfunction


	//===========================================================================
	private function init takes nothing returns nothing
		call BattleStartGlobal.AddListener(function OnFightStart, null)
		call BattleEndGlobal.AddListener(function OnFightEnd, function OnFightEnd_Condition)
	    /*call CreateEventTrigger( "udg_FightStartGlobal_Real", function OnFightStart, null )
	    call CreateEventTrigger( "udg_FightEndGlobal_Real", function OnFightEnd, function OnFightEnd_Condition )*/
	    call CreateEventTrigger( "Event_Start", function OnStart, function OnStart_Condition )
	    call CreateEventTrigger( "Event_HeroChoose_Real", function OnHeroChoose, function OnHeroChoose_Condition )
	    call CreateEventTrigger( "Event_HeroRepick_Real", function OnHeroRepick, function OnHeroRepick_Condition )
	endfunction

endscope