scope Hephaestus initializer init

	globals
		private constant integer ITEM_ID = 'I00K'
		private constant integer STAT_GAIN_BASE = 5
		private constant integer STAT_GAIN_EXCHANGE = 2
		private constant integer HASH_KEY = StringHash("hephaestus")
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetItemTypeId(Event_ItemExchange_Item) == ITEM_ID
	endfunction
	
	private function Formula takes integer level returns integer
		return STAT_GAIN_BASE + STAT_GAIN_EXCHANGE * level
	endfunction
	
	private function action takes nothing returns nothing
	    local unit hero = Event_ItemExchange_Hero
	    local item exchangedItem = Event_ItemExchange_Item
	    local integer id = GetHandleId( exchangedItem )
		local integer counter = LoadInteger( udg_hash, id, HASH_KEY ) + 1
	    local string newText
	    
	    call SaveInteger( udg_hash, id, HASH_KEY, counter )
	    set newText = words( hero, BlzGetItemExtendedTooltip(exchangedItem), "|cffffffff", "|r", I2S( Formula(counter) ) )
	    call BlzSetItemExtendedTooltip( exchangedItem, newText )
	    
	    set exchangedItem = null
	    set hero = null
	endfunction
	
	//===========================================================================
	private function OnGain_Condition takes nothing returns boolean
        return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
    endfunction
 
    private function OnGain takes nothing returns nothing
    	local unit hero = GetManipulatingUnit()
	    local item exchangedItem = GetManipulatedItem()
	    local integer id = GetHandleId( exchangedItem )
		local integer counter = LoadInteger( udg_hash, id, HASH_KEY )
		local integer statChange = Formula( counter )
    
    	call statst( hero, statChange, statChange, statChange, 0, false )
    	
    	set exchangedItem = null
	    set hero = null
	endfunction
	
	private function OnLose takes nothing returns nothing
    	local unit hero = GetManipulatingUnit()
	    local item exchangedItem = GetManipulatedItem()
	    local integer id = GetHandleId( exchangedItem )
		local integer counter = LoadInteger( udg_hash, id, HASH_KEY )
		local integer statChange = Formula( counter )
    
    	call statst( hero, -statChange, -statChange, -statChange, 0, false )
    	
    	set exchangedItem = null
	    set hero = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateEventTrigger( "Event_ItemExchange_Real", function action, function condition )
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function OnGain, function OnGain_Condition )
        call CreateNativeEvent( EVENT_PLAYER_UNIT_DROP_ITEM, function OnLose, function OnGain_Condition )
	endfunction

endscope