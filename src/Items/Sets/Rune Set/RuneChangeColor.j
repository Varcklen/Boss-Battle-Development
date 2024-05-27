scope RuneChangeColor initializer init

	private function ChangeColor takes item itemUsed, unit caster returns nothing
		call BlzSetItemExtendedTooltip( itemUsed, wordscurrent( caster, BlzGetItemExtendedTooltip(itemUsed), "|cffffffff", "|cff707070" ) )
	endfunction
	
	private function RevertColor takes item itemUsed, unit caster returns nothing
		call BlzSetItemExtendedTooltip( itemUsed, wordscurrent( caster, BlzGetItemExtendedTooltip(itemUsed), "|cff707070", "|cffffffff" ) )
	endfunction

	private function action_gain takes nothing returns nothing
		local item itemUsed = RuneSetGainCheck.GetDataItem("item")
		local unit caster = RuneSetGainCheck.GetDataUnit("caster")
		
		call ChangeColor(itemUsed, caster)
		
		set itemUsed = null
		set caster = null
	endfunction
	
	private function action_lose takes nothing returns nothing
		local item itemUsed = RuneSetLoseCheck.GetDataItem("item")
		local unit caster = RuneSetGainCheck.GetDataUnit("caster")
		
		call RevertColor(itemUsed, caster)
		
		set itemUsed = null
		set caster = null
	endfunction
	
	private function condition takes nothing returns boolean
	    if udg_logic[36] then
	        return false
	    endif
	    if SetCount_IsActive( GetManipulatingUnit(), SET_RUNE) == false then
	        return false
	    endif
	    if RuneLogic(GetManipulatedItem()) == false then
	        return false
	    endif
	    return true
	endfunction
	
	private function on_gain takes nothing returns nothing
		call ChangeColor(GetManipulatedItem(), GetManipulatingUnit()) 
	endfunction
	
	private function on_lose takes nothing returns nothing
		call RevertColor(GetManipulatedItem(), GetManipulatingUnit())
	endfunction

	private function init takes nothing returns nothing
		call RuneSetGainCheck.AddListener(function action_gain, null)
		call RuneSetLoseCheck.AddListener(function action_lose, null)
		
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function on_gain, function condition )
		call CreateNativeEvent( EVENT_PLAYER_UNIT_DROP_ITEM, function on_lose, function condition )
	endfunction

endscope