scope FortuneTellingBall initializer init

	globals
		private constant integer ITEM_ID = 'I0FH'

		private constant integer REPICK_LIMIT = 20
		private constant integer STRING_HASH = StringHash("fortune_telling_ball")
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction

	private function action takes nothing returns nothing
		local unit caster = GetManipulatingUnit()
		local item itemUsed = GetManipulatedItem()
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
		
		call Forge_DisableNextItemMaking()
		call forge( caster, itemUsed, itemType[0], itemType[1], itemType[2], false )
		
		set caster = null
		set itemUsed = null
	endfunction
	
	//=================================================================================
	private function ItemRewardCreate_Condition takes nothing returns boolean
		return LoadInteger(udg_hash, GetHandleId(Event_ItemRewardCreate_Hero), STRING_HASH ) != 0
	endfunction

	private function OnItemRewardCreate takes nothing returns nothing
		local unit caster = Event_ItemRewardCreate_Hero
		local integer id = GetHandleId(caster)

		call ItemRandomizerLib_OfferItemLater(caster, LoadInteger(udg_hash, id, STRING_HASH ))
        call SaveInteger(udg_hash, id, STRING_HASH, 0 )
        call ChangeToolItem( caster, ITEM_ID, "Future: ", ")|r", "Nothing" )
		
		set caster = null
	endfunction
	
	//=================================================================================
	private function OnForge_Condition takes nothing returns boolean
		return GetItemTypeId(Event_BeforeForge_ForgedItem) == ITEM_ID
	endfunction

	private function OnForge takes nothing returns nothing
		local unit caster = Event_BeforeForge_Hero
		local item usedItem = Event_BeforeForge_ForgedItem
		local item tempItem
		
		call SaveInteger(udg_hash, GetHandleId(caster), STRING_HASH, Event_BeforeForge_NewItem )
        set tempItem = CreateItem( Event_BeforeForge_NewItem, 0, 0 )
        call BlzSetItemExtendedTooltip( usedItem, words( caster, BlzGetItemDescription(usedItem), "Future: ", ")|r", GetItemName(tempItem) ) ) // sadtwig
        call RemoveItem(tempItem)
        
        set tempItem = null
        set caster = null
        set usedItem = null
	endfunction

	//=================================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_USE_ITEM, function action, function condition )
		
		call CreateEventTrigger( "Event_ItemRewardCreate_Real", function OnItemRewardCreate, function ItemRewardCreate_Condition )
		
		call CreateEventTrigger( "Event_BeforeForge_Real", function OnForge, function OnForge_Condition )
	endfunction

endscope