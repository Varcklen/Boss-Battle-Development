library RuneSetGainLose initializer init requires SetCount

	globals
		public integer ItemUsed = 0	
	endglobals

	public function GetItemType takes nothing returns integer
		return ItemUsed
	endfunction

	private function action_gain takes nothing returns nothing
		local unit caster = RuneSetGain.GetDataUnit("caster")
		local integer i = 0
		local integer iMax = UnitInventorySize(caster)
		local item itemUsed
		
		loop
			exitwhen i >= iMax
			set itemUsed = UnitItemInSlot( caster, i )
			if itemUsed != null and RuneLogic(itemUsed) then
				set ItemUsed = GetItemTypeId(itemUsed)
				call RuneSetGainCheck.SetDataUnit("caster", caster )
				call RuneSetGainCheck.SetDataItem("item", itemUsed )
				call RuneSetGainCheck.Invoke()
			endif
			set i = i + 1
		endloop
		set itemUsed = null
		set caster = null
	endfunction
	
	private function action_lose takes nothing returns nothing
		local unit caster = RuneSetLose.GetDataUnit("caster")
		local integer i = 0
		local integer iMax = UnitInventorySize(caster)
		local item itemUsed
		
		loop
			exitwhen i >= iMax
			set itemUsed = UnitItemInSlot( caster, i )
			if itemUsed != null and RuneLogic(itemUsed) then
				set ItemUsed = GetItemTypeId(itemUsed)
				call RuneSetLoseCheck.SetDataUnit("caster", caster )
				call RuneSetLoseCheck.SetDataItem("item", itemUsed )
				call RuneSetLoseCheck.Invoke()
			endif
			set i = i + 1
		endloop
		set itemUsed = null
		set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RuneSetGain.AddListener(function action_gain, null)
		call RuneSetLose.AddListener(function action_lose, null)
	endfunction

endlibrary