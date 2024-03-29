scope RuneSetGainItem initializer init

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
	
	private function delay takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
		local unit hero = LoadUnitHandle( udg_hash, id, StringHash( "rune_set_gain_delay" ) )
	    local item itemUsed = LoadItemHandle( udg_hash, id, StringHash( "rune_set_gain_delay_item" ) )	
	
		set RuneSetGainLose_ItemUsed = GetItemTypeId(itemUsed)
		call RuneSetGainCheck.SetDataUnit("caster", hero )
		call RuneSetGainCheck.SetDataItem("item", itemUsed )
		call RuneSetGainCheck.Invoke()
		
	    call FlushChildHashtable( udg_hash, id )
	    
	    set hero = null
	    set itemUsed = null
	endfunction
	
	private function action takes nothing returns nothing
		local integer id
	    
		set id = InvokeTimerWithUnit( GetManipulatingUnit(), "rune_set_gain_delay", 0.01, false, function delay )
    	call SaveItemHandle( udg_hash, id, StringHash("rune_set_gain_delay_item"), GetManipulatedItem() )
	endfunction

	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope