scope OathOfResourcefullness initializer init

	globals
		private constant integer ITEM_ID = 'IZ05'
		private constant integer REPICK_LIMIT = 20
		private constant integer POTION_COST = 150
	endglobals

	private function condition takes nothing returns boolean
		return inv(BeforeItemSplit.GetDataUnit("caster"), ITEM_ID) > 0 and GetItemTypeId( BeforeItemSplit.GetDataItem("item_used") ) != ITEM_ID
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BeforeItemSplit.GetDataUnit("caster")
		local item itemUsed = GetItemOfTypeFromUnitBJ( caster, ITEM_ID)
		local item itemToSplit = BeforeItemSplit.GetDataItem("item_used")
		local player user = GetOwningPlayer(caster)
		local integer array itemType
		local integer i
		local integer repickLimit 
		local integer indexCheck
		
		set i = 0
		set repickLimit = 1
		loop
			exitwhen i >= 3 or repickLimit > REPICK_LIMIT
			set itemType[i] = ItemRandomizerLib_GetRandomItemType()
			set indexCheck = IMaxBJ(0, i - 1)
			if indexCheck == i or itemType[i] != itemType[indexCheck] then
				set i = i + 1
			endif
			set repickLimit = repickLimit + 1
		endloop
		
		call forge( caster, itemUsed, itemType[0], itemType[1], itemType[2], false )
		
		if IsPotion(itemToSplit) then
			call SetPlayerState( user, PLAYER_STATE_RESOURCE_GOLD, IMaxBJ( 0, GetPlayerState( user, PLAYER_STATE_RESOURCE_GOLD) - POTION_COST ) )
		endif
		
		set caster = null
		set itemUsed = null
		set itemToSplit = null
		set user = null
	endfunction

	private function init takes nothing returns nothing
		call BeforeItemSplit.AddListener(function action, function condition)
	endfunction

endscope