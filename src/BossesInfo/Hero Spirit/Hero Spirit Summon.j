scope HeroSpiritSummon initializer init

	globals
		private constant integer UNIT_ID = 'o021'	
		private constant integer SUMMON_DELAY = 5
		
		private constant string ANIMATION = "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl"
		public constant integer STRING_HASH = StringHash("hero_spirit")
	endglobals

	private function condition takes nothing returns boolean
	    return IsUnitType( GetDyingUnit(), UNIT_TYPE_HERO) and combat(GetDyingUnit(), false, 0) and udg_fightmod[3] == false and NoSpirit == false
	endfunction

	private function CreateSpirit takes unit hero returns nothing
		local unit summon
		local integer id = GetHandleId(hero)
		local player owner = LoadPlayerHandle(udg_hash, id, StringHash("main_owner") )
		
		set summon = CreateUnit(owner, UNIT_ID, GetUnitX(hero), GetUnitY(hero), 270)
		call DestroyEffect( AddSpecialEffectTarget(ANIMATION, summon, "origin") )
		call SaveUnitHandle(udg_hash, id, STRING_HASH, summon )
		call SaveUnitHandle(udg_hash, GetHandleId(summon), STRING_HASH, hero )
		
		if LoadBoolean(udg_hash, id, StringHash("second_chance_disable") ) == false then
			call UnitAddAbility(summon, 'A1GA')
		endif
		
		call ClearSelectionForPlayer( owner )
		call SelectUnitAddForPlayer( summon, owner )

		set summon = null
	endfunction

	private function Delay takes nothing returns nothing
	    local integer id = GetHandleId(GetExpiredTimer())
	    local unit hero = LoadUnitHandle(udg_hash, id, StringHash("hero_spirit_delay") )
	    
	    if combat(hero, false, 0) and IsUnitDead(hero) then
	    	call CreateSpirit(hero)
	    endif
	    call FlushChildHashtable( udg_hash, id )
	    
	    set hero = null
	endfunction

	private function action takes nothing returns nothing
	    call InvokeTimerWithUnit( GetDyingUnit(), "hero_spirit_delay", SUMMON_DELAY, false, function Delay )
	endfunction

	//===========================================================================
	private function revive_condition takes nothing returns boolean
	    return LoadUnitHandle(udg_hash, GetHandleId(GetRevivingUnit()), STRING_HASH ) != null
	endfunction

	private function revive takes nothing returns nothing
		local integer id = GetHandleId( GetRevivingUnit() )
	    local unit summon = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    
	    call DestroyEffect( AddSpecialEffect(ANIMATION, GetUnitX(summon), GetUnitY(summon) ) )
	    call RemoveUnit(summon)
	    call RemoveSavedHandle( udg_hash, id, STRING_HASH )
	    
	    set summon = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
	    call CreateNativeEvent( EVENT_PLAYER_HERO_REVIVE_FINISH, function revive, function revive_condition )
	endfunction

endscope