scope CurseFatigue initializer init

	globals
		private trigger Trigger = null
		
		private constant integer COOLDOWN = 45
		private constant integer DURATION = 10
	endglobals

    private function AddDebuff takes unit target returns nothing
        call UnitAddAbility( target, 'A0I5' )
        call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Other\\HowlOfTerror\\HowlCaster.mdl", target, "origin") )
        call textst( "|c00FF6000 FATIGUE!", target, 64, 90, 15, 1.5 )
        call bufallst( target, target, 'A0I5', 0, 0, 0, 0, 'B03F', "curse_succumbing_end", DURATION )
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
        call TimerStart( timerUsed, COOLDOWN, true, function cast )
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