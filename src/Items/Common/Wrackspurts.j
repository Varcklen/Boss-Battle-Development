scope Wrackspurts initializer init

	globals
		private constant integer ITEM_ID = 'I03Y'
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false and UnitInventoryCount(BattleEnd.TriggerUnit) < UnitInventorySize(BattleEnd.TriggerUnit)
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleEnd.GetDataUnit("caster")
		
        call UnitAddItem( caster, CreateItem(ITEM_ID, GetUnitX(caster), GetUnitY(caster) ) )
	    
	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition, null )
	endfunction
	
endscope
