scope EssenceOfTime initializer init

	globals
		private constant integer ITEM_ID = 'I0E0'
		
		private constant integer STAT_INCREASE = -25
		private constant integer STAT_TYPE = STAT_COOLDOWN
		
		private constant integer STRING_HASH = StringHash( "essence_of_time" )
	endglobals

	private function condition takes nothing returns boolean 
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction 
	
	private function IsBonusFound takes unit hero returns boolean 
		return AlchemyOnly(hero)
	endfunction
	
	private function check takes nothing returns nothing 
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit hero = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    local item itemUsed = LoadItemHandle( udg_hash, id, StringHash( "essence_of_time_item" ) )
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
		
		set id = InvokeTimerWithItem( GetManipulatedItem(), "essence_of_time_item", 3, true, function check )
		call SaveUnitHandle( udg_hash, id, STRING_HASH, GetManipulatingUnit() ) 
	endfunction 
	
	//=========================================================================== 
	private function init takes nothing returns nothing 
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope