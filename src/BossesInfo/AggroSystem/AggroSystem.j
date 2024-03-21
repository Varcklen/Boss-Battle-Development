library AggroSystem initializer init requires DeathSystem

	globals
		private constant integer COMMAND_CHECK = OrderId("stop")
		
		private constant integer ORDER_CHANGE_RANGE = 800
	endglobals

	// Выбор цели для противников
	function aggro takes unit unitForced returns nothing
	    local unit target 
	
		//call BJDebugMsg("aggro")
		//If provoced
		if GetUnitAbilityLevel( unitForced, 'B059') > 0 then
			return
		endif
	
		//If paused
		if IsUnitPaused(unitForced) then
			return
		endif

		set target = DeathSystem_GetRandomAliveHero()
		if target == null then
			return
		endif
		
		//call BJDebugMsg("unitForced:" + GetUnitName(unitForced))
		//call BJDebugMsg("unitForced:" + GetUnitName(target))
		if DistanceBetweenUnits(unitForced, target) > ORDER_CHANGE_RANGE then
			call IssueTargetOrder( unitForced, "attackonce", target )
		else
			call IssuePointOrder( unitForced, "attack", GetUnitX(target), GetUnitY(target) )
		endif
		
        set target = null
	endfunction

	//=========Aggro===========
    private function unit_search takes nothing returns boolean
        local unit filtered = GetFilterUnit()
        local boolean b
        
        /*call BJDebugMsg("===============================")
        call BJDebugMsg("Unit: " + GetUnitName(filtered))
        call BJDebugMsg("command search int: " + I2S(COMMAND_CHECK))
        call BJDebugMsg("command search: " + OrderId2String(COMMAND_CHECK))
        call BJDebugMsg("-------------------------------")
        call BJDebugMsg("command int: " + I2S(GetUnitCurrentOrder(filtered)))
        call BJDebugMsg("command: " + OrderId2String(GetUnitCurrentOrder(filtered)))*/
        set b = GetOwningPlayer(filtered) == Player(10) and GetUnitCurrentOrder(filtered) == COMMAND_CHECK and GetUnitDefaultMoveSpeed(filtered) > 0
        set filtered = null
        return b
    endfunction

	private function Aggro takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local group g = CreateGroup()
	    local unit u
	
		//call BJDebugMsg("Aggro")
	    if udg_fightmod[0] == false then
	        call DestroyTimer( GetExpiredTimer() )
	    else
	        call GroupEnumUnitsInRect(g, udg_Boss_Rect, Condition( function unit_search ))
            loop
                set u = FirstOfGroup(g)
                exitwhen u == null
                //call BJDebugMsg("FOUND: " + GetUnitName(u))
                call aggro( u )
                call GroupRemoveUnit(g,u)
            endloop
	    endif
	    
	    call DestroyGroup( g )
	    set g = null
	    set u = null
	endfunction

	private function Launch takes nothing returns nothing
		local timer timerUsed = LoadTimerHandle( udg_hash, 1, StringHash( "aggro" ) )
		
		//call BJDebugMsg("Aggro Launch")
	    if timerUsed == null then
	    	set timerUsed = CreateTimer()
	        call SaveTimerHandle( udg_hash, 1, StringHash( "aggro" ), timerUsed )
	    endif
	    call TimerStart( timerUsed, 5, true, function Aggro )
	    
	    set timerUsed = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_FightStartGlobal_Real", function Launch, null )
	endfunction

endlibrary