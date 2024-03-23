scope CurseReincarnation initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function Lower takes unit hero returns nothing
	    local boolean l = false
	
		if GetUnitState( hero, UNIT_STATE_LIFE)/RMaxBJ(1,GetUnitState( hero, UNIT_STATE_MAX_LIFE)) > 0.8 then
			call SetUnitState( hero, UNIT_STATE_LIFE, GetUnitState( hero, UNIT_STATE_MAX_LIFE ) * 0.8 )
            set l = true
		endif
		if GetUnitState( hero, UNIT_STATE_MANA)/RMaxBJ(1,GetUnitState( hero, UNIT_STATE_MAX_MANA)) > 0.8 then
			call SetUnitState( hero, UNIT_STATE_MANA, GetUnitState( hero, UNIT_STATE_MAX_MANA ) * 0.8 )
            set l = true
		endif
        if l then
            call DestroyEffect( AddSpecialEffect( "war3mapImported\\SoulRitual.mdx", GetUnitX( hero ), GetUnitY( hero ) ) )
        endif
	endfunction
	
	private function cast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local integer i = 1
	
	    if not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	    else
			loop
				exitwhen i > 4
				if IsUnitAlive(udg_hero[i]) then
	                call Lower(udg_hero[i])
				endif
				set i = i + 1
			endloop
	    endif
	endfunction

	private function action takes nothing returns nothing
        local integer id
		local timer timerUsed = LoadTimerHandle( udg_hash, 1, StringHash( "curse_reincarnation" ) )

        if timerUsed == null then
        	set timerUsed = CreateTimer()
            call SaveTimerHandle( udg_hash, 1, StringHash( "curse_reincarnation" ), timerUsed )
        endif
        call TimerStart( timerUsed, 30, true, function cast )

        set timerUsed = null
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		local integer i
		call EnableTrigger( Trigger )
		if udg_fightmod[0] then
			set i = 1
			loop
				exitwhen i > 4
				if IsUnitAlive(udg_hero[i]) then
					call Lower(udg_hero[i])
				endif
				set i = i + 1
			endloop
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