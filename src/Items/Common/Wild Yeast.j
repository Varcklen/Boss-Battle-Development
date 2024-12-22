scope WildYeast initializer init

	globals
		private constant integer ITEM_ID = 'I08Q'
		
		private constant integer EXTRA_CHARGE = 1
	endglobals
	
	private function condition takes nothing returns boolean
	    return udg_fightmod[3] == false
	endfunction
	
	private function delay takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
		local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "wild_yeast_delay" ) )
		local integer i
		local integer iMax = UnitInventorySize(caster)
		local item itemInSlot
		local item newItem
		local integer itemCharges
		
		//call BJDebugMsg("Check")
		set newItem = CreateItem(udg_Database_Item_Potion[GetRandomInt(1,udg_Database_NumberItems[9])], GetUnitX(caster), GetUnitY(caster))
        call UnitAddItem(caster, newItem)
		
		set i = 0
        loop
            exitwhen i >= iMax
            set itemInSlot = UnitItemInSlot(caster, i)
            //call BJDebugMsg("Item: " + GetItemName(itemInSlot))
            if itemInSlot != null and IsPotion(itemInSlot) then
            	//call BJDebugMsg("Work")
                set itemCharges = BlzGetItemIntegerField(itemInSlot, ITEM_IF_NUMBER_OF_CHARGES)
                call BlzSetItemIntegerFieldBJ( itemInSlot, ITEM_IF_NUMBER_OF_CHARGES, itemCharges + EXTRA_CHARGE )
            endif
            set i = i + 1
        endloop

		set newItem = null
		set itemInSlot = null
    	set caster = null
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")

        call InvokeTimerWithUnit( caster, "wild_yeast_delay", 0.01, false, function delay )
    	set caster = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleStart, function action, function condition, null)
	endfunction

endscope