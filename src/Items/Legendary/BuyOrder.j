scope BuyOrder initializer init
	globals
        private constant integer ID_BUYORDER = 'IZ07'
        private constant integer ID_BUYORDER_CAST = 'AZ07'
        private constant real DEFICIT_MULT = 1.5
    endglobals
    
	private function condition takes nothing returns boolean
    	return GetSpellAbilityId() == ID_BUYORDER_CAST and notCombat( GetSpellAbilityUnit(), true, ID_BUYORDER_CAST ) and GetItemTypeId(GetSpellTargetItem()) != ID_BUYORDER and GetItemTypeId(GetSpellTargetItem()) != 'I030' and GetItemType(GetSpellTargetItem()) != ITEM_TYPE_POWERUP and GetItemType(GetSpellTargetItem()) != ITEM_TYPE_PURCHASABLE and GetItemType(GetSpellTargetItem()) != ITEM_TYPE_MISCELLANEOUS
	endfunction

	private function action takes nothing returns nothing
    	local integer cyclA = 1
		local integer h = 1
		local integer hmin = 1
		local integer hmax = 2 + IMinBJ(4, julenum)
		local boolean on = false
    	local unit u = GetSpellAbilityUnit()
    	local item it = GetItemOfTypeFromUnitBJ( u, ID_BUYORDER)
    	local integer itd = GetItemTypeId(GetSpellTargetItem())
    	local itemtype itemType = GetItemType(GetSpellTargetItem())
    	local integer chance = 70
    	local integer result = 0
    	
		loop
		exitwhen cyclA > 3
			set hmax = hmax + 2
			if LuckChance(u, chance) then
				set on = true
				set h = GetRandomInt( hmin, hmax )
   	     		call JuleLib_SetFutureItem( h, itd )
				set hmin = h + 1
			endif
			set chance = (3 - cyclA) * 10
			set cyclA = cyclA + 1
		endloop
		if not(on) then
			if itemType == ITEM_TYPE_PERMANENT then
            	set result = R2I( 500 * DEFICIT_MULT )
        	elseif itemType == ITEM_TYPE_CAMPAIGN then
            	set result = R2I( 750 * DEFICIT_MULT )
       		elseif itemType == ITEM_TYPE_ARTIFACT then
            	set result = R2I( 1000 * DEFICIT_MULT )
        	endif
			set h = GetRandomInt( hmin, hmax )
   	     	call JuleLib_SetFutureItem( h, itd )
       		call JuleLib_SetFutureCost( h, result )
       		call textst( "|c00909090 Deficit!", u, 64, 90, 10, 1 )
   	     endif
    	call stazisst( u, it )
    	
    	set u = null
    	set it = null
    	set itemType = null
	endfunction

//****************************************************************************
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger()
    	call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    	call TriggerAddCondition( trig, Condition( function condition ) )
		call TriggerAddAction( trig, function action)
		set trig = null
	endfunction

endscope