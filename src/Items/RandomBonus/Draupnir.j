scope Draupnir initializer init
	function Trig_Draupnir_Conditions takes nothing returns boolean
	    return inv(GetManipulatingUnit(), 'I0G3') > 0 and GetItemTypeId(GetManipulatedItem()) != 'I0G3' and Ring_Logic(GetManipulatedItem()) 
	endfunction
	
	function Trig_Draupnir_Actions takes nothing returns nothing
	    local integer cyclA = 1
	    local integer cyclAEnd
	    local integer cyclB
		local integer cyclBEnd
	    local integer id = GetHandleId(GetManipulatedItem())
	    local integer k
	    local integer rand = 0
	    local string str
	    
	    if not(LoadBoolean( udg_hash, id, StringHash( "extrab" ) )) then
	        set cyclA = 1
	        set cyclAEnd = 5
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
	            call SaveBoolean( udg_hash, id, StringHash( "extrab" ), true )
	        endif 
	    endif
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	    call TriggerAddCondition( trig, Condition( function Trig_Draupnir_Conditions ) )
	    call TriggerAddAction( trig, function Trig_Draupnir_Actions )
	endfunction

endscope