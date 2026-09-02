scope BlessHronoSpeed initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitType( GetSpellAbilityUnit(), UNIT_TYPE_HERO) and 6 >= GetRandomInt( 1, 100 )
	endfunction
	
	private function action takes nothing returns nothing
		local integer abilityId
		local unit target = GetSpellAbilityUnit()
		
        call DestroyEffect( AddSpecialEffect( "war3mapImported\\Sci Teleport.mdx", GetUnitX( target ), GetUnitY( target ) ) )
		set abilityId = FindAbilityOnCooldown(target)
	    if abilityId != -1 then
	    	call UnitReduceAbilityCooldownPercent( target, abilityId, 0.5 )
	    endif
	    
	    set target = null
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