scope BlessMagic initializer init

	globals
		private trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
		return IsUnitType( GetSpellAbilityUnit(), UNIT_TYPE_HERO) and combat( GetSpellAbilityUnit(), false, 0 ) and GetSpellAbilityId() == Database_Hero_Abilities[1][udg_HeroNum[GetUnitUserData(GetSpellAbilityUnit())]] 
	endfunction
	
	private function action takes nothing returns nothing
		local integer rand = GetRandomInt( 0, 2 )
		local trigger abilityUsed = udg_DB_Trigger_Two[GetRandomInt( 1, udg_Database_NumberItems[14 + rand])]
		
		call CastRandomAbility(GetSpellAbilityUnit(), GetRandomInt( 1, 5 ), abilityUsed )
		
		set abilityUsed = null
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