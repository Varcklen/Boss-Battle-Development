scope PrimalMatter initializer init
	
	globals
		private constant integer ITEM_ID = 'I0CX'
	endglobals

	private function condition takes nothing returns boolean
		return BattleEnd.GetDataBoolean("is_win")
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		local integer itemType
	
		set itemType = DB_Items[3][GetRandomInt( 1, udg_Database_NumberItems[3] )]
		call RemoveItem( Trigger_GetItemUsed() )
        call UnitAddItem( hero, CreateItem( itemType, GetUnitX(hero), GetUnitY(hero) ) )
        
        set hero = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition, null)
	endfunction
	
endscope