scope RunestoneIsli initializer init

	globals
		private constant integer ITEM_ID = 'I053'
		
		private constant integer COOLDOWN_REDUCTION = 5
		private constant integer MANA_STEAL_PERC = 3
	endglobals

	/*private function condition takes nothing returns boolean
	    return inv( GetSpellAbilityUnit(), ITEM_ID) > 0
	endfunction*/
	
	private function action takes nothing returns nothing
		local unit caster = GetSpellAbilityUnit()
		local integer index = GetUnitUserData(caster)
		local integer abilityOnCooldown = FindAbilityOnCooldown(caster)
		
		if abilityOnCooldown != -1 then
			call UnitReduceAbilityCooldown( caster, abilityOnCooldown, COOLDOWN_REDUCTION )
			
			if not(udg_logic[index + 26]) then
				call SetUnitManaPercentBJ( caster, GetUnitManaPercent(caster) - MANA_STEAL_PERC )
			endif
		endif
		
		set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    /*set gg_trg_Rune_Isli = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( gg_trg_Rune_Isli, EVENT_PLAYER_UNIT_SPELL_FINISH )
	    call TriggerAddCondition( gg_trg_Rune_Isli, Condition( function condition ) )
	    call TriggerAddAction( gg_trg_Rune_Isli, function action )*/
	    
	    call RegisterDuplicatableItemType(ITEM_ID, EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, null )
	endfunction

endscope