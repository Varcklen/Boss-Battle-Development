scope CurseFatigue initializer init

	globals
		private trigger Trigger = null
	endglobals

	private function end takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "curse_succumbing_end" ) )
	    
	    call UnitRemoveAbility( target, 'A0I5' )
	    call UnitRemoveAbility( target, 'B03F' )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set target = null
	endfunction

    private function AddDebuff takes unit target returns nothing
        call UnitAddAbility( target, 'A0I5' )
        call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Other\\HowlOfTerror\\HowlCaster.mdl", target, "origin") )
        call textst( "|c00FF6000 FATIGUE!", target, 64, 90, 15, 1.5 )

        call InvokeTimerWithUnit( target, "curse_succumbing_end", 10, false, function end )
    endfunction
    
    private function cast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit u
	
	    if udg_fightmod[0] == false then
	        call DestroyTimer( GetExpiredTimer() )
	    else
	        set u = DeathSystem_GetRandomAliveHero()
	        if u != null then
	        	call AddDebuff(u)
	    	endif
	    endif
	    
	    set u = null
	endfunction
	
	private function action takes nothing returns nothing
		local integer id
		local timer timerUsed = LoadTimerHandle( udg_hash, 1, StringHash( "curse_fatigue" ) )

        if timerUsed == null then
        	set timerUsed = CreateTimer()
            call SaveTimerHandle( udg_hash, 1, StringHash( "curse_fatigue" ), timerUsed )
        endif
        call TimerStart( timerUsed, 45, true, function cast )
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		call EnableTrigger( Trigger )
		if udg_fightmod[0] then
			call cast()
		endif
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_FightStartGlobal_Real", function action, null )
		//set Trigger = AnyHeroDied.AddListener(function action, function condition)
		call DisableTrigger( Trigger )
	endfunction

endscope