scope BoomBox initializer init

	globals
		private constant integer ITEM_ID = 'I0GG'
		
		private constant integer STAT_INCREASE = 15
		private constant integer STAT_TYPE = STAT_BUFF_DURATION
		
		private constant integer STRING_HASH = StringHash( "boom_box" )
		private constant string STRING_HASH_ITEM = "boom_box_item"
	endglobals

	private function condition takes nothing returns boolean 
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction 
	
	private function BonusValue takes unit hero returns integer
		return SetCount_GetPieces(hero, SET_MECH)
	endfunction 
	
	private function check takes nothing returns nothing 
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit hero = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    local item itemUsed = LoadItemHandle( udg_hash, id, StringHash( STRING_HASH_ITEM ) )
	    local real totalBonus = LoadReal( udg_hash, id, STRING_HASH )
	    local integer amountSaved = LoadInteger( udg_hash, id, STRING_HASH )
	    local integer amountCurrent
	    local real bonusToGain
	    
	    if UnitHasItem(hero,itemUsed) == false then
	    	call StatSystem_Add( hero, STAT_TYPE, -totalBonus)
	        call DestroyTimer( GetExpiredTimer() )
	    else
	    	set amountCurrent = BonusValue(hero)
	    	if amountCurrent != amountSaved then
	    		set bonusToGain = (amountCurrent - amountSaved) * STAT_INCREASE
	    		set totalBonus = totalBonus + bonusToGain
	    		call StatSystem_Add( hero, STAT_TYPE, bonusToGain)
	    		call SaveReal( udg_hash, id, STRING_HASH, totalBonus )
	    		call SaveInteger( udg_hash, id, STRING_HASH, amountCurrent )
	    	endif
	    endif
	    
	    set itemUsed = null
	    set hero = null
	endfunction 
	
	private function action takes nothing returns nothing 
		local integer id 
		
		set id = InvokeTimerWithItem( GetManipulatedItem(), STRING_HASH_ITEM, 1, true, function check )
		call SaveUnitHandle( udg_hash, id, STRING_HASH, GetManipulatingUnit() ) 
	endfunction 
	
	//=========================================================================== 
	private function init takes nothing returns nothing 
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope