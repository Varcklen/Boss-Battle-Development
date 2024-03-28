scope RunestoneDoh initializer init

	globals
		private constant integer VALUE_TO_ADD = 25
		private constant integer STAT_TYPE = STAT_DAMAGE_TAKEN
	endglobals

	private function ItemCheck takes nothing returns boolean
		return RuneSetGainLose_GetItemType() == 'I0AF'
	endfunction

	private function SetGain takes nothing returns nothing
		local unit caster = RuneSetGainCheck.GetDataUnit("caster")
		local item itemUsed = RuneSetGainCheck.GetDataItem("item")
		
		call StatSystem_Add( caster, STAT_TYPE, -VALUE_TO_ADD)
		call BlzItemRemoveAbilityBJ( itemUsed, 'A1FA' )
		
		set caster = null
		set itemUsed = null
	endfunction
	
	private function SetLose takes nothing returns nothing
		local unit caster = RuneSetLoseCheck.GetDataUnit("caster")
		local item itemUsed = RuneSetLoseCheck.GetDataItem("item")
		
		call StatSystem_Add( caster, STAT_TYPE, VALUE_TO_ADD)
		call BlzItemAddAbilityBJ( itemUsed, 'A1FA' )
		
		set caster = null
		set itemUsed = null
	endfunction

	private function init takes nothing returns nothing
		call RuneSetGainCheck.AddListener( function SetGain, function ItemCheck)
        call RuneSetLoseCheck.AddListener( function SetLose, function ItemCheck)
	endfunction
	
endscope