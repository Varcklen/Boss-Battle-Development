scope RunestoneMandom initializer init

	globals
		private constant integer ITEM_ID = 'I00B'
	
		private constant integer VALUE_TO_ADD = 25
		private constant integer STAT_TYPE = STAT_COOLDOWN
		private constant integer ABILITY_USED = 'A1G4'
	endglobals

	private function ItemCheck takes nothing returns boolean
		return RuneSetGainLose_GetItemType() == ITEM_ID
	endfunction

	private function SetGain takes nothing returns nothing
		local unit caster = RuneSetGainCheck.GetDataUnit("caster")
		local item itemUsed = RuneSetGainCheck.GetDataItem("item")
		
		call StatSystem_Add( caster, STAT_TYPE, -VALUE_TO_ADD)
		call BlzItemRemoveAbilityBJ( itemUsed, ABILITY_USED )
		call BlzItemRemoveAbilityBJ( itemUsed, 'A0Z8' )
		
		set caster = null
		set itemUsed = null
	endfunction
	
	private function SetLose takes nothing returns nothing
		local unit caster = RuneSetLoseCheck.GetDataUnit("caster")
		local item itemUsed = RuneSetLoseCheck.GetDataItem("item")
		
		call StatSystem_Add( caster, STAT_TYPE, VALUE_TO_ADD)
		call BlzItemAddAbilityBJ( itemUsed, ABILITY_USED )
		call BlzItemAddAbilityBJ( itemUsed, 'A0Z8' )
		
		set caster = null
		set itemUsed = null
	endfunction

	private function init takes nothing returns nothing
		call RuneSetGainCheck.AddListener( function SetGain, function ItemCheck)
        call RuneSetLoseCheck.AddListener( function SetLose, function ItemCheck)
	endfunction
	
endscope