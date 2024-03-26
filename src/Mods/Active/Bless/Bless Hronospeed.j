scope BlessHronoSpeed initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitType( GetSpellAbilityUnit(), UNIT_TYPE_HERO) and 4 >= GetRandomInt( 1, 100 )
	endfunction
	
	private function end takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "hrspeed" ) )
	    
	    call UnitResetCooldown( caster )
	    call FlushChildHashtable( udg_hash, id )
	    
	    set caster = null
	endfunction

	private function action takes nothing returns nothing
        call DestroyEffect( AddSpecialEffect( "war3mapImported\\Sci Teleport.mdx", GetUnitX( GetSpellAbilityUnit() ), GetUnitY( GetSpellAbilityUnit() ) ) )

		call InvokeTimerWithUnit( GetSpellAbilityUnit(), "hrspeed", 0.1, false, function end )
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
        call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
        call DisableTrigger( Trigger )
    endfunction
	
	private function init takes nothing returns nothing
		set Trigger = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_FINISH, function action, function condition )
		call DisableTrigger( Trigger )
	endfunction

endscope