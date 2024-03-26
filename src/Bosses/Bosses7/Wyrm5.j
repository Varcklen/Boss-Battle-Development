scope Wyrm5 initializer init
	
	globals
		trigger trig_Wyrm5 = null
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetUnitTypeId(udg_DamageEventTarget) == 'o00M'
	endfunction
	
	private function WyrmSpawn takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "bswr1" ) )
	    
	    if GetUnitState( boss, UNIT_STATE_LIFE) <= 0.405 or not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
	    else
	        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( boss ), 'e00E', GetRectCenterX( udg_Boss_Rect ) + GetRandomReal( -1500, 1500 ), GetRectCenterY( udg_Boss_Rect ) + GetRandomReal( -1500, 1500 ), GetRandomReal( 0, 360 ) )
	        call PingMinimapLocForForceEx( bj_FORCE_ALL_PLAYERS, GetUnitLoc(bj_lastCreatedUnit), 5, bj_MINIMAPPINGSTYLE_ATTACK, 100, 50, 50 )
	    endif
	    
	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
	    local integer id = GetHandleId( udg_DamageEventTarget )
	    local integer cyclA
	    local real x
	    local real y 
	    
	    call DisableTrigger( GetTriggeringTrigger() )
	    
	    set cyclA = 1
	    loop
	        exitwhen cyclA > 4
	        set x = GetRectCenterX( udg_Boss_Rect ) + 2000 * Cos( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD )
            set y = GetRectCenterY( udg_Boss_Rect ) + 2000 * Sin( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD )
            set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'e00E', x, y, GetRandomReal( 0, 360 ) )
            call PingMinimapLocForForceEx( bj_FORCE_ALL_PLAYERS, GetUnitLoc( bj_lastCreatedUnit ), 5, bj_MINIMAPPINGSTYLE_ATTACK, 100, 50, 50 )
	        set cyclA = cyclA + 1
	    endloop
	    
	    set id = GetHandleId( udg_DamageEventTarget )
	    if LoadTimerHandle( udg_hash, id, StringHash( "bswr1" ) ) == null  then
	        call SaveTimerHandle( udg_hash, id, StringHash( "bswr1" ), CreateTimer() )
	    endif
		set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "bswr1" ) ) ) 
	    call SaveUnitHandle( udg_hash, id, StringHash( "bswr1" ), udg_DamageEventTarget )
	    //No bosscast intended - balance preferences
		call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( "bswr1" ) ), 8, true, function WyrmSpawn )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set trig_Wyrm5 = CreateTrigger(  )
	    call DisableTrigger( trig_Wyrm5 )
	    call TriggerRegisterVariableEvent( trig_Wyrm5, "udg_AfterDamageEvent", EQUAL, 1.00 )
	    call TriggerAddCondition( trig_Wyrm5, Condition( function condition ) )
	    call TriggerAddAction( trig_Wyrm5, function action )
	endfunction

endscope