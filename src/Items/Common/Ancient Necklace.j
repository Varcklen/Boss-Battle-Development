scope AncientNecklace initializer init

	globals
		private constant integer ITEM_ID = 'I09Z'
		
		private constant integer STAT_INCREASE = 1
		private constant integer STAT_TYPE = STAT_DODGE
		
		private constant integer STRING_HASH = StringHash( "ancient_necklace" )
	endglobals

	private function condition takes nothing returns boolean 
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction 
	
	private function check takes nothing returns nothing 
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit hero = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    local item itemUsed = LoadItemHandle( udg_hash, id, StringHash( "ancient_necklace_item" ) )
	    local real totalBonus = LoadReal( udg_hash, id, STRING_HASH )
	    local integer levelSaved = LoadInteger( udg_hash, id, STRING_HASH )
	    local integer levelCurrent
	    local real bonusToGain
	    
	    if UnitHasItem(hero,itemUsed) == false then
	    	call StatSystem_Add( hero, STAT_TYPE, -totalBonus)
	        call DestroyTimer( GetExpiredTimer() )
	    else
	    	set levelCurrent = GetUnitLevel(hero)
	    	if levelCurrent != levelSaved then
	    		set bonusToGain = (levelCurrent - levelSaved) * STAT_INCREASE
	    		set totalBonus = totalBonus + bonusToGain
	    		call StatSystem_Add( hero, STAT_TYPE, bonusToGain)
	    		call SaveReal( udg_hash, id, STRING_HASH, totalBonus )
	    		call SaveInteger( udg_hash, id, STRING_HASH, levelCurrent )
	    	endif
	    endif
	    
	    set itemUsed = null
	    set hero = null
	endfunction 
	
	private function action takes nothing returns nothing 
		local integer id 
		
		set id = InvokeTimerWithItem( GetManipulatedItem(), "ancient_necklace_item", 1, true, function check )
		call SaveUnitHandle( udg_hash, id, STRING_HASH, GetManipulatingUnit() ) 
	endfunction 
	
	//=========================================================================== 
	private function init takes nothing returns nothing 
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope