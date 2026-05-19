scope BlessThirstForKnowledge initializer init

	globals
		private boolean isUsedAgain = false	
		
		private constant integer ITEM_TO_CREATE = 'I0E2'
	endglobals

	//===========================================================================
	private function Create takes unit hero returns nothing
		local item newItem
		
		if ItemManipulation_IsInventoryFull(hero) then
			return
		endif
		
		set newItem = CreateItem( ITEM_TO_CREATE, GetUnitX( hero ), GetUnitY( hero ) )
		call UnitAddItem( hero, newItem )
		call BlzSetItemExtendedTooltip( newItem, wordscurrent( hero, BlzGetItemExtendedTooltip(newItem), "|cffC71585Cursed|r", "|cFF1CE6B9Cleansed!|r" ) )
		
		set newItem = null
	endfunction
	
	public function Enable takes nothing returns nothing
		local integer i
		
		if isUsedAgain then
			return
		endif
		set isUsedAgain = true
		
        set i = 1
        loop
            exitwhen i > 4
            if udg_hero[i] != null then
                call Create( udg_hero[i] )
            endif
            set i = i + 1
        endloop
    endfunction
    
    public function Disable takes nothing returns nothing
		
    endfunction
	
	private function init takes nothing returns nothing
	endfunction

endscope