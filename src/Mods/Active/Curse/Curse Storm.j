scope CurseStorm initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function end takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "curse_storm_tick" ) )
	    
	    if not( udg_fightmod[0] ) or IsUnitDead(dummy) or RectContainsUnit(udg_Boss_Rect, dummy) == false then
	    	call RemoveUnit( dummy )
	        call DestroyTimer( GetExpiredTimer() )
	    endif
	    
	    set dummy = null
	endfunction 

	private function cast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local real x
	    local real y
	
	    if not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	    else
			if udg_Boss_Rect == gg_rct_ArenaBossSmall then
				set x = GetRectCenterX( udg_Boss_Rect ) + 1200
				set y = GetRectCenterY( udg_Boss_Rect ) + GetRandomReal( -1200, 1200 )
			else
				set x = GetRectCenterX( udg_Boss_Rect ) + 1800
				set y = GetRectCenterY( udg_Boss_Rect ) + GetRandomReal( -1800, 1800 )
			endif
	        set bj_lastCreatedUnit = CreateUnit( Player(10), 'u000', x, y, 180 )
	        call SetUnitScale(bj_lastCreatedUnit, 1.5, 1.5, 1.5 )
	        call UnitAddAbility( bj_lastCreatedUnit, 'A0M7')
	        call UnitAddAbility( bj_lastCreatedUnit, 'A0M5')
	        call UnitAddAbility( bj_lastCreatedUnit, 'A136')
	    	call SetUnitMoveSpeed( bj_lastCreatedUnit, 100 )
	        call IssuePointOrder( bj_lastCreatedUnit, "move", GetUnitX( bj_lastCreatedUnit ) - 5000, GetUnitY( bj_lastCreatedUnit ) )
	
	        call InvokeTimerWithUnit( bj_lastCreatedUnit, "curse_storm_tick", 1, true, function end )
	    endif
	endfunction

    private function action takes nothing returns nothing
    	local timer timerUsed = LoadTimerHandle( udg_hash, 1, StringHash("curse_storm") )
    	local integer p
    	
    	if udg_Boss_Rect == gg_rct_ArenaBossSmall then
            set p = 8
        else
            set p = 4
        endif
    	
        if timerUsed == null then
        	set timerUsed = CreateTimer()
            call SaveTimerHandle( udg_hash, 1, StringHash("curse_storm"), timerUsed )
        endif
        call TimerStart( timerUsed, p, true, function cast )
        
        set timerUsed = null
    endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		if udg_fightmod[0] then
			call action()
		endif
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightStartGlobal_Real", function action, null )
		call DisableTrigger( Trigger )
	endfunction

endscope