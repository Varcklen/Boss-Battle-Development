scope BlessSecondChance initializer init

	globals
		private trigger Trigger = null
		
		private constant real HEALTH_REQUIRE_PERC = 0.2
		private constant real HEALTH_RESTORE_PERC = 0.2
		private constant string ANIMATION = "Abilities\\Spells\\Human\\ReviveHuman\\ReviveHuman.mdl"
	endglobals
	
	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction
	
	private function end takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "mdg20" ) )
	    local real healthPerc = GetUnitState( caster, UNIT_STATE_LIFE) / RMaxBJ( 1, GetUnitState( caster, UNIT_STATE_MAX_LIFE))
	
	    if combat(caster, false, 0) == false then
	        call DestroyTimer( GetExpiredTimer() )
	    elseif healthPerc <= HEALTH_REQUIRE_PERC and IsUnitAlive(caster) then
	        call healst( caster, null, GetUnitState( caster, UNIT_STATE_MAX_LIFE) * HEALTH_RESTORE_PERC )
	        call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "origin" ) )
	        call DestroyTimer( GetExpiredTimer() )
	    endif
	    
	    set caster = null
	endfunction
	
	private function Launch takes unit caster returns nothing
		call InvokeTimerWithUnit( caster, "mdg20", 1, true, function end )
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
		
		if udg_fightmod[0] == false then
			return
		endif
		
		set i = 1
		loop
            exitwhen i > 4
            if udg_hero[i] != null then
                call Launch(udg_hero[i])
            endif
            set i = i + 1
        endloop
    endfunction
    
    public function Disable takes nothing returns nothing
		call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = BattleStart.AddListener(function action, null)
		call DisableTrigger( Trigger )
	endfunction

endscope