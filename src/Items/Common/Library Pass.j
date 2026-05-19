scope LibraryPass initializer init

	globals
		private constant integer ITEM_ID = 'I0E2'
	endglobals

	private function condition takes nothing returns boolean
	    return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster = GetManipulatingUnit()
		local item itemUsed = GetManipulatedItem()

		call BookSeller_Enable(caster)
    	call stazisst( caster, itemUsed )

	    set itemUsed = null
	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_USE_ITEM, function action, function condition )
	endfunction

endscope