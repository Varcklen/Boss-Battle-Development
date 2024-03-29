scope RandomBonusSpellPower initializer init

	globals
		private constant integer SPELL_POWER_TO_ADD = 8	
		private constant integer ABILITY_ID = 'A0Y4'
	endglobals

	private function condition takes nothing returns boolean
		return BlzGetItemAbility( GetManipulatedItem(), ABILITY_ID ) != null
	endfunction

	private function add_action takes nothing returns nothing
		call spdst( GetManipulatingUnit(), SPELL_POWER_TO_ADD )
	endfunction
	
	private function remove_action takes nothing returns nothing
		call spdst( GetManipulatingUnit(), -SPELL_POWER_TO_ADD )
	endfunction

	private function init takes nothing returns nothing
		local trigger trig
	    set trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function add_action )
	    
	    set trig = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DROP_ITEM )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function remove_action )
	    
	    set trig = null
	endfunction

endscope