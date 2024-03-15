scope GDMagicHat initializer init

	globals
		private constant integer ITEM_ID = 'I01Z'
	endglobals

	private function FightEndDelBuff takes nothing returns nothing
		local unit u = udg_FightEnd_Unit
		
	    if GetUnitAbilityLevel( u, 'A1BN' ) > 0 then//Fire
	        call UnitRemoveAbility(u, 'A1BN')
	        call UnitRemoveAbility(u, 'A1BO')
	        call UnitRemoveAbility(u, 'B09Q')
	    endif
	    if GetUnitAbilityLevel( u, 'A1BP' ) > 0 then//Ice
	        call UnitRemoveAbility(u, 'A1BP')
	        call UnitRemoveAbility(u, 'A1BT')
	        call UnitRemoveAbility(u, 'B09R')
	    endif
	    if GetUnitAbilityLevel( u, 'A1BR' ) > 0 then//Air
	        call UnitRemoveAbility(u, 'A1BR')
	        call UnitRemoveAbility(u, 'A1BU')
	        call UnitRemoveAbility(u, 'B09T')
	    endif
	    if GetUnitAbilityLevel( u, 'A1BQ' ) > 0 then//Earth
	        call UnitRemoveAbility(u, 'A1BQ')
	        call UnitRemoveAbility(u, 'B09S')
	        call luckyst(u, -25)
	    endif
	    if GetUnitAbilityLevel( u, 'A1BS' ) > 0 then//Shadow
	        call UnitRemoveAbility(u, 'A1BS')
	        call UnitRemoveAbility(u, 'B09U')
	        call spdst(u, -25)
	    endif
	
	    set u = null
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer rand = GetRandomInt( 1, 5 )
		
        if rand == 1 then//Fire
            call UnitAddAbility(caster, 'A1BN')
            call UnitAddAbility(caster, 'A1BO')
        elseif rand == 2 then//Ice
            call UnitAddAbility(caster, 'A1BP')
            call UnitAddAbility(caster, 'A1BT')
        elseif rand == 3 then//Air
            call UnitAddAbility(caster, 'A1BR')
            call UnitAddAbility(caster, 'A1BU')
        elseif rand == 4 then//Earth
            call UnitAddAbility(caster, 'A1BQ')
            call luckyst(caster, 25)
        elseif rand == 5 then//Shadow
            call UnitAddAbility(caster, 'A1BS')
            call spdst(caster, 25)
        endif
    	set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, null)
		
		call CreateEventTrigger( "udg_FightEnd_Real", function FightEndDelBuff, null )
	endfunction

endscope