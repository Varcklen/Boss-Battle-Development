scope SecondChanceHS initializer init

	globals
		private constant integer ANILITY_ID = 'A1GA'
		private constant integer CATS_REQUIRE = 8
	endglobals

	private function condition takes nothing returns boolean
	    return IsUnitHasAbility( GetSpellAbilityUnit(), ANILITY_ID) and (GetSpellAbilityId() == MagicThrowHS_ANILITY_ID or GetSpellAbilityId() == SmallHealHS_ANILITY_ID)
	endfunction
	
	private function AddCounter takes unit caster, integer abilityId returns nothing
		local integer stringHash = StringHash( "second_chance_" + I2S(abilityId))
		local integer id = GetHandleId(caster)
		local integer counter = LoadInteger(udg_hash, id, stringHash) + 1
		local unit hero
		
		if counter >= CATS_REQUIRE then
			set hero = LoadUnitHandle(udg_hash, id, HeroSpiritSummon_STRING_HASH )
			if IsUnitDead(hero) then
				call UnitRemoveAbility(caster, ANILITY_ID)
				call ResInBattle( caster, hero, 50 )
				call SaveBoolean(udg_hash, GetHandleId(hero), StringHash("second_chance_disable"), true)
			endif
		else
			call SaveInteger(udg_hash, id, stringHash, counter)
			call textst( "|c00FF6000" + I2S(counter) + "/" + I2S(CATS_REQUIRE), caster, 64, 90, 15, 1 )
		endif
		
		set hero = null
	endfunction
	
	private function action takes nothing returns nothing
		call AddCounter(GetSpellAbilityUnit(), GetSpellAbilityId())
	endfunction
	
	private function RestoreCharges takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		call SaveBoolean(udg_hash, GetHandleId(hero), StringHash("second_chance_disable"), false)
		set hero = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	    call BattleEnd.AddListener(function RestoreCharges, null)
	endfunction

endscope