scope CursedTag initializer init
	
	globals
		private constant string TAG_CHECK = "|cffC71585Cursed|r"
		private constant integer SYMBOLS_TO_CHECK = 18
	endglobals

	private function condition takes nothing returns boolean
		return ExtraArenaGeneral_IsPvPActive() == false
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		local integer i
		local item itemCheck
		local string text
		
		set i = 0
        loop
            exitwhen i > 5
            set itemCheck = UnitItemInSlot(hero, i)
            if itemCheck != null then
            	set text = SubString(BlzGetItemExtendedTooltip(itemCheck), 0, SYMBOLS_TO_CHECK)
	            if text == TAG_CHECK then
	                call RemoveItem( itemCheck )
	            endif
            endif
            set i = i + 1
        endloop
        
        set itemCheck = null
        set hero = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call BattleEnd.AddListener(function action, function condition)
	endfunction
	
endscope