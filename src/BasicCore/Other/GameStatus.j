library GameStatus initializer init
	
	globals
	    constant integer GAME_STATUS_OFFLINE = 0
	    constant integer GAME_STATUS_ONLINE = 1
	    constant integer GAME_STATUS_REPLAY = 2
	    
	    private integer GameStatus = -1
	endglobals
	
	public function Get takes nothing returns integer
		return GameStatus
	endfunction
	
	private function action takes nothing returns nothing
	    local integer i
	    local player playerCheck
	    local unit unitCheck
	    
	    // Find a playing player. Its Just Works
	    set i = 0
	    loop
	        exitwhen i > 11
	        set playerCheck = Player(i)
	        if GetPlayerController(playerCheck) == MAP_CONTROL_USER and GetPlayerSlotState(playerCheck) == PLAYER_SLOT_STATE_PLAYING then
	            set i = 99
	        endif
	        set i = i + 1
	    endloop
	    
	    // Find out the game status
	    call CreateNUnitsAtLoc( 1, 'hfoo', playerCheck, GetPlayerStartLocationLoc(playerCheck), bj_UNIT_FACING )
	    set unitCheck = bj_lastCreatedUnit
	    call SelectUnitForPlayerSingle( unitCheck, playerCheck )
	    
	    if IsUnitSelected(unitCheck, playerCheck) then
	        if ReloadGameCachesFromDisk() then
	            set GameStatus = GAME_STATUS_OFFLINE
	        else
	            //С этим стоит пользоватся осторожно. Может сломать реплеи
	            set GameStatus = GAME_STATUS_REPLAY
	        endif
	    else
	        set GameStatus = GAME_STATUS_ONLINE
	    endif
	    //call BJDebugMsg("Mode: " + I2S(GameStatus))
	    call RemoveUnit( unitCheck )
	    
	    set playerCheck = null
	    set unitCheck = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger()
	    call TriggerRegisterTimerEventSingle( trig, 0.00 )
	    call TriggerAddAction( trig, function action )
	endfunction

endlibrary