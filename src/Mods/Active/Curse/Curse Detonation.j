scope CurseDetonation initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function end takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "curse_succumbing_end" ) )
	    local group g = CreateGroup()
	    local unit u
	    
	    call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", GetUnitX( dummy ), GetUnitY( dummy ) + 70 ) )
	    call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", GetUnitX( dummy ) + 100, GetUnitY( dummy ) - 100 ) )
	    call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", GetUnitX( dummy ) - 100, GetUnitY( dummy ) - 100 ) )
	    call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), 250, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if unitst( u, dummy, "enemy" ) then
	            call UnitDamageTarget( dummy, u, GetUnitState( u, UNIT_STATE_MAX_LIFE) * 0.2, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    call RemoveUnit( dummy )
	    
	    call FlushChildHashtable( udg_hash, id )
	    call DestroyGroup( g )
	    set u = null
	    set g = null
	    set dummy = null
	endfunction 

	private function cast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit u = DeathSystem_GetRandomAliveHero()
	
	    if not( udg_fightmod[0] ) then
	        call FlushChildHashtable( udg_hash, id )
	    elseif u != null then
	        set bj_lastCreatedUnit = CreateUnit( Player(10), 'u000', GetUnitX( u ) + GetRandomReal(-300, 300), GetUnitY( u ) + GetRandomReal(-300, 300), 270 )
	        call SetUnitScale(bj_lastCreatedUnit, 2.5, 2.5, 2.5 )
	        call UnitAddAbility( bj_lastCreatedUnit, 'A136')
	        
	        call InvokeTimerWithUnit( bj_lastCreatedUnit, "curse_succumbing_end", 4, false, function end )
	    endif
	    
	    set u = null
	endfunction

    private function action takes nothing returns nothing
    	local timer timerUsed = LoadTimerHandle( udg_hash, 1, StringHash("curse_detonation") )
        if timerUsed == null then
        	set timerUsed = CreateTimer()
            call SaveTimerHandle( udg_hash, 1, StringHash("curse_detonation"), timerUsed )
        endif
        call TimerStart( timerUsed, 10, true, function cast )
        
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