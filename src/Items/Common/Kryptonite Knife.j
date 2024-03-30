scope KryptoniteKnife initializer init

	globals
		private constant integer ITEM_ID = 'I05Z'
		
		private constant integer SPELL_POWER_BONUS = -30
		private constant integer VALUE_TO_ADD = 45
		private constant integer STAT_TYPE = STAT_DAMAGE_DEALT_PHY
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

	public function Enable takes nothing returns nothing
		call StatSystem_Add( WeaponPieceSystem_WeaponData.TriggerUnit, STAT_TYPE, VALUE_TO_ADD)
		call spdst( WeaponPieceSystem_WeaponData.TriggerUnit, SPELL_POWER_BONUS )
    endfunction
    
    public function Disable takes nothing returns nothing
		call StatSystem_Add( WeaponPieceSystem_WeaponData.TriggerUnit, STAT_TYPE, -VALUE_TO_ADD)
		call spdst( WeaponPieceSystem_WeaponData.TriggerUnit, -SPELL_POWER_BONUS )
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
	    set trig = null
	endfunction

endscope