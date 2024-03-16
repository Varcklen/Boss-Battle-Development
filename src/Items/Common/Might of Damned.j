scope MightOfDamned initializer init

	globals
		private constant integer ITEM_ID = 'I02M'
		
		private constant integer STAT_INCREASE = 70
		private constant integer STAT_TYPE = STAT_DAMAGE_DEALT_PHY
		
		private constant integer HEATH_REQUIRE_PERC = 95
		
		private constant integer STRING_HASH = StringHash( "might_of_damned" )
	endglobals

	private function condition takes nothing returns boolean 
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction 
	
	private function IsBonusFound takes unit hero returns boolean 
		return GetUnitStatePercent(hero, UNIT_STATE_LIFE, UNIT_STATE_MAX_LIFE) >= HEATH_REQUIRE_PERC
	endfunction
	
	private function check takes nothing returns nothing 
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit hero = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    local item itemUsed = LoadItemHandle( udg_hash, id, StringHash( "might_of_damned_item" ) )
	    local boolean isActive = LoadBoolean( udg_hash, id, STRING_HASH )
	    local boolean isBonusFound
	    
	    if UnitHasItem(hero,itemUsed) == false then
	    	if isActive then
	    		call StatSystem_Add( hero, STAT_TYPE, -STAT_INCREASE)
    		endif
	        call DestroyTimer( GetExpiredTimer() )
	    elseif IsUnitAlive(hero) then
	        set isBonusFound = IsBonusFound(hero)
	        if isBonusFound and isActive == false then
	            call StatSystem_Add( hero, STAT_TYPE, STAT_INCREASE)
	            call SaveBoolean( udg_hash, id, STRING_HASH, true )
	        elseif isBonusFound == false and isActive then
	            call StatSystem_Add( hero, STAT_TYPE, -STAT_INCREASE)
	            call SaveBoolean( udg_hash, id, STRING_HASH, false )
	        endif
	    endif
	    
	    set itemUsed = null
	    set hero = null
	endfunction 
	
	private function action takes nothing returns nothing 
		local integer id 
		
		set id = InvokeTimerWithItem( GetManipulatedItem(), "might_of_damned_item", 1, true, function check )
		call SaveUnitHandle( udg_hash, id, STRING_HASH, GetManipulatingUnit() ) 
	endfunction 
	
	//=========================================================================== 
	private function init takes nothing returns nothing 
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope