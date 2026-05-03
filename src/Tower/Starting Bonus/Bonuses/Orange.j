scope Orange initializer init

	globals
		private integer ITEM_TYPE = 'IV00'
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction
	
	private function FillList takes unit hero, ListInt potionList returns nothing
    	local integer k
    	local integer kMax
    	local item itemCheck
    	
		set k = 1
		set kMax = udg_Database_NumberItems[9]
		loop
			exitwhen k > kMax
			call potionList.Add(udg_Database_Item_Potion[k])
			set k = k + 1
        endloop
        
        set k = 0
        loop
            exitwhen k > 5
            set itemCheck = UnitItemInSlot( hero, k )
            if IsPotion(itemCheck) then
                call potionList.TryRemoveByData(GetItemTypeId(itemCheck))
            endif
            set k = k + 1
        endloop

    	set itemCheck = null
    endfunction
    
    private function AddPotion takes unit hero, ListInt potionList returns nothing
    	local item newItem
    	local integer itemType = potionList.GetRandomCellAndRemove()
    	
    	set newItem = CreateItem(itemType, GetUnitX(hero), GetUnitY(hero))
    	call UnitAddItem(hero, newItem)
    	
    	set newItem = null
    endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		local ListInt potionList = ListInt.create()
		
		call FillList(hero, potionList)
		loop
			exitwhen ItemManipulation_IsInventoryFull(hero)
			call AddPotion(hero, potionList)
		endloop
		
		call potionList.destroy()
		set hero = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope