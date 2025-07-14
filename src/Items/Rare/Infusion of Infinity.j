scope InfusionOfInfinity initializer init

	globals
		private constant integer ITEM_ID = 'I082'
		private constant integer EXTRA_CHARGE = 1
	endglobals

	//OnBattleStart
	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer i
		local integer itemCharges
		local item potion
		
		set i = 1
        loop
            exitwhen i > 6 or UnitInventoryCount(caster) >= 6
            set potion = CreateItem( udg_Database_Item_Potion[GetRandomInt(1, udg_Database_NumberItems[9])], GetUnitX( caster ), GetUnitY( caster ) )
            call UnitAddItem(caster, potion )
            set itemCharges = BlzGetItemIntegerField( potion, ITEM_IF_NUMBER_OF_CHARGES)
			call BlzSetItemIntegerFieldBJ( potion, ITEM_IF_NUMBER_OF_CHARGES, itemCharges + EXTRA_CHARGE )

            set i = i + 1
        endloop
	    
	    set potion = null
	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, function condition, null )
	endfunction

endscope