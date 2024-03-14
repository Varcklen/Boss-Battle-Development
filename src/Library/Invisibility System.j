library InvisibilitySystem initializer init requires TimebonusLib, Trigger

	globals
		private constant integer STRING_HASH = StringHash( "invisibility" )
		
		private constant player PLAYER_CHECK = Player(PLAYER_NEUTRAL_AGGRESSIVE)
	endglobals

	public function IsActive takes unit target returns boolean
		return /*IsUnitVisible( target, PLAYER_CHECK )*/ IsUnitHasAbility( target, 'A1EZ' )
	endfunction

	//Invisibility Applying
    //===========================================================================
	private function RiverEyeCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "rvey" ) )
	    
	    if IsUnitVisible( u, Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
	        call UnitRemoveAbility( u, 'A0E7' )
	        call DestroyTimer( GetExpiredTimer() )
	    endif
	    
	    set u = null
	endfunction
	
	private function LorderBadgeCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "ldbg" ) )
	    
	    if IsUnitVisible( u, Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
	        call UnitRemoveAbility( u, 'A0TQ' )
	        call DestroyTimer( GetExpiredTimer() )
	    endif
	    
	    set u = null
	endfunction
	
	private function CrownCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "crwn" ) )
	    
	    if IsUnitInvisible( u, Player(PLAYER_NEUTRAL_AGGRESSIVE)) then
	        call bufst( u, u, 'A0YE', 'B088', "crwn1", 6 )
	    else
	        call DestroyTimer( GetExpiredTimer() )
	    endif
	    
	    set u = null
	endfunction
	
	/*private function Stealth takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( "stlth" ) ), 'A10C' )
	    call FlushChildHashtable( udg_hash, id )
	endfunction*/

	public function LaunchEvent takes unit u returns nothing
	    local integer i = GetPlayerId( GetOwningPlayer( u ) ) + 1
	    local integer id = GetHandleId( u )
	    
	    if IsUnitType( u, UNIT_TYPE_HERO) == false then
	    	return
	    endif
	    
	    if inv( u, 'I07F') > 0 then
	        call UnitAddAbility( u, 'A0E7' )
	
	        if LoadTimerHandle( udg_hash, id, StringHash( "rvey" ) ) == null then
	            call SaveTimerHandle( udg_hash, id, StringHash( "rvey" ), CreateTimer() )
	        endif
	        set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "rvey" ) ) ) 
	        call SaveUnitHandle( udg_hash, id, StringHash( "rvey" ), u )
	        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "rvey" ) ), 1, true, function RiverEyeCast )
	    endif
	    if inv( u, 'I08O') > 0 then
	        call UnitAddAbility( u, 'A0TQ' )
	
	        if LoadTimerHandle( udg_hash, id, StringHash( "ldbg" ) ) == null then
	            call SaveTimerHandle( udg_hash, id, StringHash( "ldbg" ), CreateTimer() )
	        endif
	        set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "ldbg" ) ) ) 
	        call SaveUnitHandle( udg_hash, id, StringHash( "ldbg" ), u )
	        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "ldbg" ) ), 1, true, function LorderBadgeCast )
	    endif
	    if inv( u, 'I00R') > 0 then
	        call bufst( u, u, 'A0YE', 'B088', "crwn1", 6 )
	        set id = GetHandleId( u )
	        if LoadTimerHandle( udg_hash, id, StringHash( "crwn" ) ) == null then
	            call SaveTimerHandle( udg_hash, id, StringHash( "crwn" ), CreateTimer() )
	        endif
	        set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "crwn" ) ) ) 
	        call SaveUnitHandle( udg_hash, id, StringHash( "crwn" ), u )
	        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "crwn" ) ), 1, true, function CrownCast )
	    endif
	    
	    /*call UnitAddAbility( u, 'A10C' )
	    
	    set id = GetHandleId( u )
	    if LoadTimerHandle( udg_hash, id, StringHash( "stlth" ) ) == null  then
	        call SaveTimerHandle( udg_hash, id, StringHash( "stlth" ), CreateTimer() )
	    endif
		set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "stlth" ) ) ) 
		call SaveUnitHandle( udg_hash, id, StringHash( "stlth" ), u )
		call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "stlth" ) ), 3, false, function Stealth )*/
	    
	    set u = null
	endfunction

	//Buff Applying
    //===========================================================================
	private function SetCounter takes unit target, integer newCounter returns nothing
		call SaveInteger( udg_hash, GetHandleId( target ), STRING_HASH, newCounter )
        if newCounter <= 0 then
            call UnitRemoveAbility( target, 'A1EZ' )
            call UnitRemoveAbility( target, 'B0AL' )
            call UnitRemoveAbility( target, 'A1F0' )
        endif
	endfunction

	private function BuffEnd takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit target = LoadUnitHandle( udg_hash, id, STRING_HASH )
        local integer counter = IMaxBJ( 0, LoadInteger( udg_hash, GetHandleId( target ), STRING_HASH ) - 1 )
        local integer pattern = LoadInteger( udg_hash, id, STRING_HASH )

		if pattern == udg_Pattern then
        	call SetCounter(target, counter)
    	endif
        call FlushChildHashtable( udg_hash, id )

        set target = null
    endfunction

    public function Apply takes unit caster, unit target, real duration returns nothing
        local integer counter 
        local timer timerUsed
        local integer id
        
        if target == null then
        	set target = caster
        endif
        
        if IsUnitDeadBJ(target) then
        	return
        endif
        
        set duration = timebonus(caster, duration)
        set id = GetHandleId( target )
		set counter = LoadInteger( udg_hash, id, STRING_HASH ) + 1

        call SaveInteger( udg_hash, id, STRING_HASH, counter )
        call UnitAddAbility( target, 'A1EZ' )
        call UnitAddAbility( target, 'A1F0' )
        call LaunchEvent(target)
        
        //Without condition as intended
        set timerUsed = CreateTimer()
        call SaveTimerHandle( udg_hash, id, STRING_HASH, timerUsed )
        
        set id = GetHandleId( timerUsed )
        call SaveUnitHandle( udg_hash, id, STRING_HASH, target )
        call SaveInteger( udg_hash, id, STRING_HASH, udg_Pattern )
        call TimerStart( timerUsed, duration, false, function BuffEnd )

		set timerUsed = null
    endfunction
    
    //On Between Battles
    //===========================================================================
    private function condition takes nothing returns boolean
    	return IsUnitHasAbility(Event_BetweenUnit_Hero, 'A1EZ' )
    endfunction
    
    private function action takes nothing returns nothing
    	call SetCounter(Event_BetweenUnit_Hero, 0)
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
    	call CreateEventTrigger( "Event_BetweenUnit", function action, function condition )
    endfunction

endlibrary