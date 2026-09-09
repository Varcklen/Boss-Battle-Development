library SpecialLocation initializer init

	globals
		private location array Location
		
		constant integer LOC_TYPE_ITEM_HIDDEN = 0
	endglobals
	
	//SpecialLocation_Get(LOC_TYPE_ITEM_HIDDEN)
	public function Get takes integer locType returns location
		return Location[locType]
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		set Location[LOC_TYPE_ITEM_HIDDEN] = GetRectCenter(gg_rct_Hidden)
	endfunction

endlibrary