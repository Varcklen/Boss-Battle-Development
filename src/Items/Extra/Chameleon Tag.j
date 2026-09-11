scope ChameleonTag initializer init
	
	globals
		private constant string TAG_CHECK = "|cff00cceeChameleon"
		private constant integer SYMBOL_AMOUNT = 19
	endglobals
	
	private function condition takes nothing returns boolean
		return not(udg_fightmod[3])
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = BattleStart.GetDataUnit("caster")
		local integer i
		local item itemCheck
		local string text
		local integer itemType
		
		set i = 0
        loop
            exitwhen i > 5
            set itemCheck = UnitItemInSlot(hero, i)
            if itemCheck != null then
            	set text = SubString(BlzGetItemExtendedTooltip(itemCheck), 0, SYMBOL_AMOUNT)
            	if text == TAG_CHECK then
            		set itemType = udg_DB_Item_Activate[GetRandomInt(1,udg_Database_NumberItems[31])]
	                call Inventory_ReplaceItemByNew(hero, itemCheck, itemType)
	            endif
            endif
            set i = i + 1
        endloop
		
		set itemCheck = null
		set hero = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call BattleStart.AddListener(function action, function condition)
	endfunction
	
endscope