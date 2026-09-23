scope Tesseract initializer init

	globals
		private constant integer ITEM_ID = 'I04R'
		
		private constant integer BASE_SPELL_POWER_VALUE = 10
		private constant real SPELL_POWER_GAIN = 0.3
		private constant integer HASH_KEY = StringHash("tesseract")
	endglobals

	private function condition takes nothing returns boolean
		return ExtraArenaGeneral_IsPvPActive() == false and combat( UnitDied.TriggerUnit, false, 0 ) and IsUnitEnemy(UnitDied.TargetUnit, GetOwningPlayer(UnitDied.TriggerUnit))  
	endfunction

	private function action takes nothing returns nothing
		local unit caster = UnitDied.GetDataUnit("killer")
		local integer index = GetUnitUserData(caster)
		local item itemUsed = Trigger_GetItemUsed()
		local integer id = GetHandleId(itemUsed)
		local real extraValue = LoadReal( udg_hash, id, HASH_KEY )
		local string text
	    
	    set extraValue = extraValue + SPELL_POWER_GAIN
	    call SaveReal( udg_hash, id, HASH_KEY, extraValue )
	    
	    call spdst( caster, SPELL_POWER_GAIN)
        call textst( "|c00808080 +" + R2SW(SPELL_POWER_GAIN, 1, 1) + "%|r", caster, 64, GetRandomReal( 0, 360 ), 8, 1.5 )
        
        set text = words( caster, BlzGetItemDescription(itemUsed), "|cffffffff", "|r", R2SW( BASE_SPELL_POWER_VALUE + extraValue, 1, 1 ) + "%" )
        call BlzSetItemExtendedTooltip( itemUsed, text )
        
        set caster = null
        set itemUsed = null
	endfunction
	
	//===========================================================================
	private function Item_Condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction
	
	private function OnItemPickup takes nothing returns nothing
		local real extraValue = LoadReal( udg_hash, GetHandleId( GetManipulatedItem() ), HASH_KEY )
		
		call spdst( GetManipulatingUnit(), extraValue )
	endfunction
	
	private function OnItemDrop takes nothing returns nothing
		local real extraValue = LoadReal( udg_hash, GetHandleId( GetManipulatedItem() ), HASH_KEY )
		
		call spdst( GetManipulatingUnit(), -extraValue )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, UnitDied, function action, function condition, "killer" )
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function OnItemPickup, function Item_Condition )
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_DROP_ITEM, function OnItemDrop, function Item_Condition )
	endfunction

endscope