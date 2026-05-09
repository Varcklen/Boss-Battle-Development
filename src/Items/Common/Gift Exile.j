scope ExileGift initializer init

	private function condition takes nothing returns boolean
	    return GetItemTypeId(GetManipulatedItem()) == 'I08M'
	endfunction
	
	private function action takes nothing returns nothing
	    local integer cyclA = 2
		local integer array it
	
		set it[0] = 0
		set it[1] = 0
		loop
			exitwhen cyclA > 4
	        set it[cyclA] = ItemRandomizerLib_GetRandomExileItemType()
			if (it[cyclA] == it[cyclA-1] or it[cyclA] == it[cyclA-2]) then
				set cyclA = cyclA - 1
			endif
			set cyclA = cyclA + 1
		endloop
		call forge( GetManipulatingUnit(), GetManipulatedItem(), it[4], it[2], it[3], true )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_USE_ITEM, function action, function condition )
	endfunction

endscope