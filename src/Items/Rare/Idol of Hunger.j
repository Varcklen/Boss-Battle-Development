scope IdolOfHunger initializer init

	//Lifesteal in the TagSystem. There are only hp decrease.
	globals
		private constant integer ITEM_ID = 'I02B'
		private constant integer ABILITY_ID = 'A101'
	endglobals

	private function OnBattleStart takes nothing returns nothing
		local item itemUsed = Trigger_GetItemUsed()
		
		call BlzItemAddAbilityBJ( itemUsed, ABILITY_ID )
		
		set itemUsed = null
	endfunction
	
	private function OnBattleEnd takes nothing returns nothing
		local item itemUsed = Trigger_GetItemUsed()
		
		call BlzItemRemoveAbilityBJ( itemUsed, ABILITY_ID )
		
		set itemUsed = null
	endfunction
	
	//========================================================================
	private function OnItemPickup_Condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID and udg_fightmod[0]
	endfunction
	
	private function OnItemPickup takes nothing returns nothing
		call BlzItemAddAbilityBJ( GetManipulatedItem(), ABILITY_ID )
	endfunction

	//========================================================================
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function OnBattleStart, null, null )
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function OnBattleEnd, null, null )
	    
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function OnItemPickup, function OnItemPickup_Condition )
	endfunction

endscope