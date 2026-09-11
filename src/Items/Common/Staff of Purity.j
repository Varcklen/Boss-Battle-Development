scope StaffOfPurity initializer init
	
	globals
		private constant integer ITEM_ID = 'I0AG'
		private constant integer ITEM_TO_ADD = 'I0DW'
	endglobals

	private function condition takes nothing returns boolean
		return inv( BattleStart.TriggerUnit, ITEM_ID) > 0 and not(udg_fightmod[3])
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = BattleStart.GetDataUnit("caster")
		local integer limit = 0
	
        loop
            exitwhen ItemManipulation_IsInventoryFull(hero) or limit > 30
            call UnitAddItem( hero, CreateItem(ITEM_TO_ADD, GetUnitX(hero), GetUnitY(hero) ) )
            set limit = limit + 1
        endloop
		
		set hero = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call BattleStart.AddListener(function action, function condition)
	endfunction
	
endscope