scope BlessFieryRain initializer init

	globals
		private trigger Trigger = null
		private constant integer SCATTER = 800
		
		private constant integer STRING_HASH = StringHash( "bless_rain" )
	endglobals
	
	private function SummonGolem takes nothing returns nothing
		local unit target = DeathSystem_GetRandomAliveHero()
		local unit dummy
		local location summonLoc
	
		if target != null then
			set summonLoc = Location(Math_GetUnitRandomX(target, SCATTER), Math_GetUnitRandomY(target, SCATTER))
			if RectContainsLoc( udg_Boss_Rect, summonLoc ) == false then
				set summonLoc = GetRandomLocInRect(udg_Boss_Rect)
			endif
		else
			set summonLoc = GetRandomLocInRect(udg_Boss_Rect)
		endif
		
		set dummy = CreateUnitAtLoc( Player(4), 'u000', summonLoc, 270 )
        call UnitApplyTimedLife( dummy, 'BTLF', 1. )
        call UnitAddAbility( dummy, 'A11D' )
        call IssuePointOrder( dummy, "dreadlordinferno", GetUnitX( dummy ), GetUnitY( dummy ) )
        
        call RemoveLocation(summonLoc)
        set summonLoc = null
        set dummy = null
	endfunction
	
	private function summon takes nothing returns nothing
	    if not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	    else
	        call SummonGolem()
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