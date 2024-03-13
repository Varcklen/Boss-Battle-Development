scope Draupnir initializer init

	globals
		private constant integer STRING_HASH = StringHash( "draupnir" )
	endglobals

	function Trig_Draupnir_Conditions takes nothing returns boolean
	    return inv(GetManipulatingUnit(), 'I0G3') > 0 and GetItemTypeId(GetManipulatedItem()) != 'I0G3' and Ring_Logic(GetManipulatedItem()) and LoadBoolean( udg_hash, GetHandleId(GetManipulatedItem()), STRING_HASH ) == false
	endfunction
	
	function Trig_Draupnir_Actions takes nothing returns nothing
		call RandomBonus_Add(GetManipulatedItem())
		call SaveBoolean( udg_hash, GetHandleId(GetManipulatedItem()), STRING_HASH, true )
	    /*local integer cyclA = 1
	    local integer cyclAEnd
	    local integer cyclB
		local integer cyclBEnd
	    local integer id = GetHandleId(GetManipulatedItem())
	    local integer k
	    local integer rand = 0
	    local string str
	    
        set cyclA = 1
        set cyclAEnd = BONUSES_LIMIT
        loop
            exitwhen cyclA > cyclAEnd
            if LoadInteger( udg_hash, id, StringHash( "extra"+I2S(cyclA) ) ) == 0 then
                set k = cyclA
                set cyclA = cyclAEnd
            endif
            set cyclA = cyclA + 1
        endloop
        
        set cyclA = 1
        loop
            exitwhen cyclA > 1
            set rand = GetRandomInt(1, udg_Database_NumberItems[25])
            if k > 1 then
                set cyclB = 1
                set cyclBEnd = k-1
                loop
                    exitwhen cyclB > cyclBEnd
                    if rand == LoadInteger( udg_hash, id, StringHash( "extra"+I2S(cyclB) ) ) then
                        set cyclA = cyclA - 1
                        set cyclB = cyclBEnd
                    endif
                    set cyclB = cyclB + 1
                endloop
            endif
            set cyclA = cyclA + 1
        endloop
        
        if rand != 0 then
            call BlzItemAddAbilityBJ( GetManipulatedItem(), udg_RandomBonus[rand] )
            call BlzSetItemExtendedTooltip( GetManipulatedItem(), BlzGetItemExtendedTooltip(GetManipulatedItem()) + "|n|cff81f260" + udg_RandomString[rand] + "|r" ) // sadtwig
            //call BlzSetItemIconPath( GetManipulatedItem(), BlzGetItemExtendedTooltip(GetManipulatedItem()) + "|n|cff81f260" + udg_RandomString[rand] + "|r" )
            call SaveBoolean( udg_hash, id, STRING_HASH, true )
        endif */
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	    call TriggerAddCondition( trig, Condition( function Trig_Draupnir_Conditions ) )
	    call TriggerAddAction( trig, function Trig_Draupnir_Actions )
	    set trig = null
	endfunction

endscope