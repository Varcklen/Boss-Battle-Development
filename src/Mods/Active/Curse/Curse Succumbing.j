scope CurseSuccumbing initializer init

	globals
		private trigger Trigger = null
		private constant real RESOURSE_LOSE = 0.1
	endglobals
	
	private function use takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "curse_succumbing" ) )
	
	    call SetUnitState( target, UNIT_STATE_LIFE, GetUnitState( target, UNIT_STATE_LIFE) - (GetUnitState( target, UNIT_STATE_MAX_LIFE) * RESOURSE_LOSE) )
        call SetUnitState( target, UNIT_STATE_MANA, GetUnitState( target, UNIT_STATE_MANA) - (GetUnitState( target, UNIT_STATE_MAX_MANA) * RESOURSE_LOSE) )
        call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", target, "origin") )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set target = null
	endfunction
	
	private function action takes nothing returns nothing
        local unit target
        local integer i
        
        set i = 1
		loop
			exitwhen i > 4
			set target = udg_hero[i]
			if target != null and IsUnitAlive(target) then
				call InvokeTimerWithUnit( target, "curse_succumbing", 1, false, function use )
			endif
			set i = i + 1
		endloop
        
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