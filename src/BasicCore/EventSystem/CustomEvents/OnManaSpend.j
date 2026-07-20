library OnManaSpend initializer init requires Trigger

	private function condition takes nothing returns boolean
	    return IsUnitType( GetSpellAbilityUnit(), UNIT_TYPE_HERO)
	endfunction
	
	private function ManaUsed takes unit hero, integer manaUsed returns nothing
		call ManaSpent.SetDataInteger("amount", manaUsed)
	    call ManaSpent.SetDataUnit("unit", hero)
    	call ManaSpent.Invoke()
	endfunction
	
	private function action takes nothing returns nothing
		local integer abilityId = GetSpellAbilityId()
		local integer level = GetUnitAbilityLevel( GetSpellAbilityUnit(), abilityId ) - 1
	    local integer manaUsed = BlzGetAbilityManaCost( abilityId, level )
	
		call ManaUsed(GetSpellAbilityUnit(), manaUsed )
	endfunction

	//===========================================================================
	public function Consume takes unit hero, real toSpend returns nothing
		if IsUnitType( hero, UNIT_TYPE_HERO) == false then
			return
		endif
		
		set toSpend = RMinBJ( GetUnitState( hero, UNIT_STATE_MANA), toSpend)
		call SetUnitState( hero, UNIT_STATE_MANA, GetUnitState( hero, UNIT_STATE_MANA) - toSpend )
		call ManaUsed( hero, R2I(toSpend) )
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	endfunction

endlibrary