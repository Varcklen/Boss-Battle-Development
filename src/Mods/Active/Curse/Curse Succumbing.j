scope CurseSuccumbing initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function use takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "curse_succumbing" ) )
	
	    call SetUnitState( target, UNIT_STATE_LIFE, GetUnitState( target, UNIT_STATE_LIFE) - (GetUnitState( target, UNIT_STATE_MAX_LIFE) * 0.3) )
        call SetUnitState( target, UNIT_STATE_MANA, GetUnitState( target, UNIT_STATE_MANA) - (GetUnitState( target, UNIT_STATE_MAX_MANA) * 0.3) )
        call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", target, "origin") )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set target = null
	endfunction
	
	private function action takes nothing returns nothing
        local unit target = DeathSystem_GetRandomAliveHero()
        
        if target != null then
        	call InvokeTimerWithUnit( target, "curse_succumbing", 1, false, function use )
        endif
        
        set target = null
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
		//set Trigger = AnyHeroDied.AddListener(function action, function condition)
		call DisableTrigger( Trigger )
	endfunction

endscope