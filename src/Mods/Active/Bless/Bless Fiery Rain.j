scope BlessFieryRain initializer init

	globals
		private trigger Trigger = null
		
		private constant integer STRING_HASH = StringHash( "bless_rain" )
	endglobals
	
	private function summon takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	
	    if not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	    else
	        set bj_lastCreatedUnit = CreateUnitAtLoc( Player(4), 'u000', Location(GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect)), GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect))), 270 )
	        call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 1. )
	        call UnitAddAbility( bj_lastCreatedUnit, 'A11D' )
	        call IssuePointOrder( bj_lastCreatedUnit, "dreadlordinferno", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) )
	    endif
	endfunction

	private function action takes nothing returns nothing
		local integer id = 1
		local timer timerUsed = LoadTimerHandle( udg_hash, id, STRING_HASH )

		if timerUsed == null then 
			set timerUsed = CreateTimer()
		    call SaveTimerHandle( udg_hash, id, STRING_HASH, timerUsed )
		endif
		call TimerStart( timerUsed, 45, true, function summon )
		
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