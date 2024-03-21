scope DraupnirRingGain initializer init

	globals
		private constant integer ITEM_ID = 'I0G3'
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false and UnitInventoryCount(BattleEnd.TriggerUnit) < UnitInventorySize(BattleEnd.TriggerUnit)
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleEnd.GetDataUnit("caster")
		local integer itemId = DB_SetItems[3][GetRandomInt(1,udg_DB_SetItems_Num[3])]
		
        call UnitAddItem( caster, CreateItem(itemId, GetUnitX(caster), GetUnitY(caster) ) )
	    
	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition, null )
	endfunction
	
endscope
