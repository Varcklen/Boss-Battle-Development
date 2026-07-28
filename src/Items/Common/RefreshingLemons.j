scope Lemons initializer init

	globals
		private constant integer ABILITY_ID = 'A1J4'
		private constant integer SHIELD_GAIN = 500
		private constant integer ITEM = 'IZ10'
		private constant integer HP_RESSURECT = 25
	endglobals

	private function condition takes nothing returns boolean
	    return GetSpellAbilityId() == ABILITY_ID and combat( GetSpellAbilityUnit(), true, 0 )
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster
		local unit deadHero

		if CastLogic() then
	        set caster = udg_Caster
	    elseif RandomLogic() then
	        set caster = udg_Caster
	    else
	        set caster = GetSpellAbilityUnit()
	    endif
	    
	    set deadHero = DeathSystem_GetRandomDeadHero()

    	if deadHero != null then
    		call ResInBattle( caster, deadHero, HP_RESSURECT )
    	endif

	    set deadHero = null
	    set caster = null
	endfunction
	
	//===========================================================================
	private function OnRevive_Condition takes nothing returns boolean
	    return combat( GetTriggerUnit(), false, 0 ) and not(udg_fightmod[3])
	endfunction
	
	private function OnRevive takes nothing returns nothing
		local unit rev = GetTriggerUnit()
	    local group g
	    local unit u
	    local integer amount

	    set g = DeathSystem_GetAliveHeroGroupCopy()
	    loop
		    set u = FirstOfGroup(g)
		    exitwhen u == null
	    	set amount = inv( u, ITEM )
	    	if amount > 0 then
	            call shield( u, rev, R2I(amount * SHIELD_GAIN) )
	    	endif
	    	call GroupRemoveUnit( g, u )
	    endloop
	    
	    set u = null
	    set rev = null
	    call DestroyGroup( g )
	    set g = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
		call CreateNativeEvent( EVENT_PLAYER_HERO_REVIVE_FINISH, function OnRevive, function OnRevive_Condition )
	endfunction

endscope