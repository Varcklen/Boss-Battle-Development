scope KryptoniteKnife initializer init

	globals
		private constant integer ITEM_ID = 'I05Z'
		
		private constant integer SPELL_POWER_BONUS = -30
		private constant real ATTACK_PERC_BONUS = 0.45
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
		local integer index = GetPlayerId( GetOwningPlayer(udg_DamageEventSource) ) + 1
        return inv( udg_DamageEventSource, ITEM_ID) > 0 or ( udg_Set_Weapon_Logic[index + 96] and inv(udg_DamageEventSource, 'I030') > 0 )
	endfunction
	
	private function AttackChange takes nothing returns nothing
        set udg_DamageEventAmount = udg_DamageEventAmount + (ATTACK_PERC_BONUS * Event_OnDamageChange_StaticDamage) 
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