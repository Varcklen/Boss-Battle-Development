scope CurseSuppression initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function use takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit u = LoadUnitHandle( udg_hash, id, StringHash( "curse_suppression" ) )
	    local real r = GetUnitState( u, UNIT_STATE_MANA) / RMaxBJ(1,GetUnitState( u, UNIT_STATE_MAX_MANA))
	
	    if combat(u, false , 0) == false then
	        call DestroyTimer( GetExpiredTimer() )
	    elseif r <= 0.2 and IsUnitAlive(u) then
	        call SetUnitState( u, UNIT_STATE_MANA, 0 ) 
	        call DestroyEffect( AddSpecialEffectTarget( "Objects\\Spawnmodels\\NightElf\\NECancelDeath\\NECancelDeath.mdl", u, "origin" ) )
	        call DestroyTimer( GetExpiredTimer() )
	    endif
	    
	    set u = null
	endfunction
	
	private function Launch takes unit hero returns nothing
		call InvokeTimerWithUnit( hero, "curse_suppression", 1, true, function use )
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		
		call Launch(caster)
		
        set caster = null
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
					call Launch(udg_hero[i])
				endif
				set i = i + 1
			endloop
		endif
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = BattleStart.AddListener(function action, null)
		call DisableTrigger( Trigger )
	endfunction

endscope