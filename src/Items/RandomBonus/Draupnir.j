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