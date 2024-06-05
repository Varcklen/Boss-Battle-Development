scope Nospirit initializer init

	globals
	    boolean NoSpirit = false
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetTriggerPlayer() == udg_Host
	endfunction
	
	private function action takes nothing returns nothing
	    local integer i = GetPlayerId( GetTriggerPlayer() ) + 1
	
		if udg_fightmod[0] then
			call DisplayTimedTextToPlayer( GetTriggerPlayer(), 0, 0, 5, "The command does not work in battle." )
			return
		endif
	
		set NoSpirit = NoSpirit == false
		if NoSpirit then
			call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5, "Player " + udg_DB_Player_Color[i] + GetPlayerName(GetTriggerPlayer()) + "|r has disabled the heroes' spirits." )
		else
			call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5, "Player " + udg_DB_Player_Color[i] + GetPlayerName(GetTriggerPlayer()) + "|r has enabled the heroes' spirits." )
		endif
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local integer cyclA = 0
	    local trigger trig = CreateTrigger()
	    loop
	        exitwhen cyclA > 3
	        call TriggerRegisterPlayerChatEvent( trig, Player(cyclA), "-nospirit", true )
	        set cyclA = cyclA + 1
	    endloop
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )

	    set trig = null
	endfunction

endscope