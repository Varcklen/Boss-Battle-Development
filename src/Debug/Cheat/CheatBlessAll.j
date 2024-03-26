scope CheatBlessAll initializer init

	globals
		public trigger Trigger = null
	endglobals

	private function CheckData takes ListInt modeList returns nothing
		local integer iMax = modeList.Size
		local Mode mode
        local integer i = 0
        
        loop
            exitwhen i >= iMax
            set mode = modeList.GetIntegerByIndex(i)
            call BJDebugMsg("Data [" + I2S(i) + "]: " + BlzGetAbilityTooltip(mode.Info, 0))
            set i = i + 1
        endloop
        call BJDebugMsg("================================")
    endfunction

	private function action takes nothing returns nothing
	    call BJDebugMsg(" ")
	    call BJDebugMsg("|cffffcc00InactiveBlesses|r")
	    call CheckData(ModeClass_InactiveBlesses)
	    call BJDebugMsg(" ")
	    call BJDebugMsg("|cffffcc00InactiveCurses|r")
	    call CheckData(ModeClass_InactiveCurses)
	    call BJDebugMsg(" ")
	    call BJDebugMsg("|cffffcc00ActiveBlesses|r")
	    call CheckData(ModeClass_ActiveBlesses)
	    call BJDebugMsg(" ")
	    call BJDebugMsg("|cffffcc00ActiveCurses|r")
	    call CheckData(ModeClass_ActiveCurses)
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call DisableTrigger( Trigger )
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-modcheck", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope