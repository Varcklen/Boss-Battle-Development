scope BlessMalice initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitType( GetSpellAbilityUnit(), UNIT_TYPE_HERO) and combat( GetSpellAbilityUnit(), false, 0 ) and not( udg_fightmod[3] )
	endfunction
	
	private function action takes nothing returns nothing
		call spdst( GetSpellAbilityUnit(), 0.1 )
    	call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DeathPact\\DeathPactTarget.mdl", GetSpellAbilityUnit(), "origin" ) )
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