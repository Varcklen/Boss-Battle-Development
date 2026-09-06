scope TeleportationStone initializer init
	
	globals
		private constant integer ITEM_ID = 'I00J'
		private boolean isUsed = false
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction
	
	private function OnGet takes nothing returns nothing
		call Attempts_Add(1)
	endfunction
	
	private function OnLose takes nothing returns nothing
		call Attempts_Add(-1)
	endfunction
	
	//===========================================================================
	private function OnSecondChance_Condition takes nothing returns boolean
		return inv(SecondChance.TriggerUnit, ITEM_ID) > 0 and isUsed == false
	endfunction
	
	private function OnSecondChance takes nothing returns nothing
		local unit caster = SecondChance.GetDataUnit("caster")
		local item itemUsed = GetItemOfTypeFromUnitBJ(caster, ITEM_ID)
		
		call RemoveItem( itemUsed )
        call Attempts_Add(1)
        set isUsed = true
        
        set caster = null
        set itemUsed = null
	endfunction
	
	//===========================================================================
	private function DisableUses takes nothing returns nothing
        set isUsed = false
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function OnGet, function condition )
		call CreateNativeEvent( EVENT_PLAYER_UNIT_DROP_ITEM, function OnLose, function condition )
		call SecondChance.AddListener(function OnSecondChance, function OnSecondChance_Condition)
		call BattleStartGlobal.AddListener(function DisableUses, null)
	endfunction
	
endscope