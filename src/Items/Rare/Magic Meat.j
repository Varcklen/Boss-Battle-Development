scope MagicMeat initializer init
	globals
		private constant integer ITEM_ID = 'I044'
		
		private constant integer POTION_CHARGES = 3
	endglobals
	
	private function condition takes nothing returns boolean
	    return udg_fightmod[3] == false
	endfunction

	private function delay takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
		local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "magic_meat_delay" ) )
		local item newItem

		set newItem = CreateItem(udg_Database_Item_Potion[GetRandomInt(1,udg_Database_NumberItems[9])], GetUnitX(caster), GetUnitY(caster))
        call UnitAddItem(caster, newItem)
        call BlzSetItemIntegerFieldBJ( newItem, ITEM_IF_NUMBER_OF_CHARGES, POTION_CHARGES )
        call BlzSetItemExtendedTooltip( newItem, "|cffC71585Cursed|r|n" + BlzGetItemExtendedTooltip(newItem) )
        call FlushChildHashtable( udg_hash, id )
		
		set newItem = null
    	set caster = null
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")

        call InvokeTimerWithUnit( caster, "magic_meat_delay", 0.01, false, function delay )
    	set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, function condition, null)
	endfunction

endscope