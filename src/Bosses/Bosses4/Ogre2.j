scope Ogre2 initializer init

//No need to Disable/Enable

	globals
		private constant integer SLEEP_CHECK_TICK = 1
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitTypeId(GetEnteringUnit()) == 'h001'
    endfunction
    
    private function OgreAwake takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "bsog" ) )
	
	    if IsUnitAlive(boss) and udg_fightmod[0] and GetUnitTypeId( boss ) == 'h001' then
	        set udg_DamageEventTarget = boss
	        call TriggerExecute( gg_trg_Ogre1 )
	    endif
	    
	    call FlushChildHashtable( udg_hash, id )
	    set boss = null
	endfunction
	
	private function Sleep takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "boss_ogre_sleep_anim" ) )
        
        if IsUnitDead(boss) or udg_fightmod[0] == false then
        	call FlushChildHashtable( udg_hash, id )
            call DestroyTimer( GetExpiredTimer() )
        else
            call SetUnitAnimation( boss, "sleep" )
        endif
        
        set boss = null
    endfunction
	
	private function action takes nothing returns nothing
		local unit u = GetEnteringUnit()
		local integer id = GetHandleId( u )
		
    	call SetUnitAnimation( u, "sleep" )
        if LoadTimerHandle( udg_hash, id, StringHash( "bsog" ) ) == null  then
            call SaveTimerHandle( udg_hash, id, StringHash( "bsog" ), CreateTimer() )
        endif
        set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "bsog" ) ) ) 
        call SaveUnitHandle( udg_hash, id, StringHash( "bsog" ), u )
        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "bsog" ) ), 40, false, function OgreAwake )
        
        call InvokeTimerWithUnit(u, "boss_ogre_sleep_anim", SLEEP_CHECK_TICK, true, function Sleep)
        
        set u = null
    endfunction
	    
    //===========================================================================
	private function init takes nothing returns nothing
	    set gg_trg_SpawnBoss = CreateTrigger(  )
	    call TriggerRegisterEnterRectSimple( gg_trg_SpawnBoss, GetWorldBounds() )
	    call TriggerAddCondition( gg_trg_SpawnBoss, Condition( function condition ) )
	    call TriggerAddAction( gg_trg_SpawnBoss, function action )
	endfunction

endscope