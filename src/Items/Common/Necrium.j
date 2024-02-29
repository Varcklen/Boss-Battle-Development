scope Necrium initializer init

	globals
		private constant integer ITEM_ID = 'I07W'
		
		private constant integer SPELL_POWER_BONUS = 15
		private constant real DAMAGE_REDUCTION = 0.25
	endglobals

	private function ItemInventory_Condition takes nothing returns boolean
	    return udg_logic[36] == false and GetItemTypeId(GetManipulatedItem()) == ITEM_ID and GetPlayerSlotState(GetOwningPlayer(GetManipulatingUnit())) == PLAYER_SLOT_STATE_PLAYING
	endfunction
	
	private function Add takes nothing returns nothing
        call spdst( GetManipulatingUnit(), SPELL_POWER_BONUS )
	endfunction
	
	private function Remove takes nothing returns nothing
        call spdst( GetManipulatingUnit(), -SPELL_POWER_BONUS )
	endfunction
	
	private function AttackChange_Condition takes nothing returns boolean
        return udg_IsDamageSpell and inv( udg_DamageEventTarget, ITEM_ID) > 0
	endfunction
	
	private function AttackChange takes nothing returns nothing
		local real damageReduction = Event_OnDamageChange_StaticDamage * DAMAGE_REDUCTION
		
		call manast(udg_DamageEventTarget, null, damageReduction )
        set udg_DamageEventAmount = udg_DamageEventAmount - damageReduction
	endfunction
	
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )  
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	    call TriggerAddCondition( trig, Condition( function ItemInventory_Condition ) )
	    call TriggerAddAction( trig, function Add )
	    
	    set trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DROP_ITEM )
	    call TriggerAddCondition( trig, Condition( function ItemInventory_Condition ) )
	    call TriggerAddAction( trig, function Remove )
	    
	    call CreateEventTrigger( "Event_OnDamageChange_Real", function AttackChange, function AttackChange_Condition )
	endfunction

endscope