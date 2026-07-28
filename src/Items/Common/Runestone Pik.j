scope RunestonePik initializer init

	globals
		private constant integer ITEM_ID = 'I05L'
		private constant integer ABILITY_ID = 'A1J9'
		private constant integer VALUE_TO_ADD = -15
		private constant integer STAT_TYPE = STAT_DAMAGE_DEALT
	endglobals

	//===========================================================================
	private function ItemCheck takes nothing returns boolean
		return RuneSetGainLose_GetItemType() == ITEM_ID
	endfunction

	private function SetGain takes nothing returns nothing
		local unit caster = RuneSetGainCheck.GetDataUnit("caster")
		local item itemUsed = RuneSetGainCheck.GetDataItem("item")
		
		call StatSystem_Add( caster, STAT_TYPE, -VALUE_TO_ADD)
		call BlzItemRemoveAbilityBJ( itemUsed, ABILITY_ID )
		
		set caster = null
		set itemUsed = null
	endfunction
	
	private function SetLose takes nothing returns nothing
		local unit caster = RuneSetLoseCheck.GetDataUnit("caster")
		local item itemUsed = RuneSetLoseCheck.GetDataItem("item")
		
		call StatSystem_Add( caster, STAT_TYPE, VALUE_TO_ADD)
		call BlzItemAddAbilityBJ( itemUsed, ABILITY_ID )
		
		set caster = null
		set itemUsed = null
	endfunction
	
	//===========================================================================
	private function OnGain_Condition takes nothing returns boolean
        return GetItemTypeId(GetManipulatedItem()) == ITEM_ID and udg_logic[CorrectPlayer(GetManipulatingUnit()) + 26] == false
    endfunction
 
    private function OnGain takes nothing returns nothing
    	call BlzItemAddAbilityBJ( GetManipulatedItem(), ABILITY_ID )
	endfunction
	
	private function OnLose takes nothing returns nothing
    	call BlzItemRemoveAbilityBJ( GetManipulatedItem(), ABILITY_ID )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call RuneSetGainCheck.AddListener( function SetGain, function ItemCheck)
        call RuneSetLoseCheck.AddListener( function SetLose, function ItemCheck)
        
        call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function OnGain, function OnGain_Condition )
        call CreateNativeEvent( EVENT_PLAYER_UNIT_DROP_ITEM, function OnLose, function OnGain_Condition )
	endfunction
	
endscope