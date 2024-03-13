scope TarotCardFool initializer init

	globals
		private constant integer ITEM_ID = 'I0CB'
	endglobals

	private function condition takes nothing returns boolean
	    return GetItemTypeId(GetManipulatedItem()) == ITEM_ID and udg_fightmod[3] == false and combat( GetManipulatingUnit(), true, 0 )
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster = GetManipulatingUnit()
		local unit deadHero = DeathSystem_GetRandomDeadHero()
		local item itemUsed = GetManipulatedItem()

    	if deadHero == null then
    		call DisplayTimedTextToPlayer( GetOwningPlayer(caster), 0, 0, 5, GetItemName(itemUsed) + ": There are no dead heroes." )
    	else
    		call stazisst( caster, itemUsed )
    		call ResInBattle( caster, deadHero, 100 )
    	endif

	    set deadHero = null
	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_USE_ITEM )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope