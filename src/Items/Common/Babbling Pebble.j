scope BabblingPebble initializer init

	globals
		private constant integer ITEM_ID = 'I09V'
		
		private constant integer STAT_INCREASE = 40
		private constant integer STAT_TYPE = STAT_DAMAGE_DEALT
		
		private constant integer MAX_MANA_REQUIRE_PERC = 25
		
		private constant integer STRING_HASH = StringHash( "babbling_pebble" )
	endglobals

	private function condition takes nothing returns boolean 
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction 
	
	private function IsBonusFound takes unit hero returns boolean 
		return GetUnitStatePercent(hero, UNIT_STATE_MANA, UNIT_STATE_MAX_MANA) <= MAX_MANA_REQUIRE_PERC
	endfunction
	
	private function check takes nothing returns nothing 
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit hero = LoadUnitHandle( udg_hash, id, STRING_HASH )
	    local item itemUsed = LoadItemHandle( udg_hash, id, StringHash( "babbling_pebble_item" ) )
	    local boolean isActive = LoadBoolean( udg_hash, id, STRING_HASH )
	    local boolean isBonusFound
	    
	    if UnitHasItem(hero,itemUsed) == false then
	    	if isActive then
	    		call StatSystem_Add( hero, STAT_TYPE, -STAT_INCREASE)
    		endif
    		call UnitRemoveAbility( hero, 'A19O')
        	call UnitRemoveAbility( hero, 'B035')
	        call DestroyTimer( GetExpiredTimer() )
	    elseif IsUnitAlive(hero) then
	        set isBonusFound = IsBonusFound(hero)
	        if isBonusFound and isActive == false then
	            call StatSystem_Add( hero, STAT_TYPE, STAT_INCREASE)
	            call SaveBoolean( udg_hash, id, STRING_HASH, true )
	            call UnitAddAbility( hero, 'A19O')
	        elseif isBonusFound == false and isActive then
	            call StatSystem_Add( hero, STAT_TYPE, -STAT_INCREASE)
	            call SaveBoolean( udg_hash, id, STRING_HASH, false )
	            call UnitRemoveAbility( hero, 'A19O')
            	call UnitRemoveAbility( hero, 'B035')
	        endif
	    endif
	    
	    set itemUsed = null
	    set hero = null
	endfunction 
	
	private function action takes nothing returns nothing 
		local integer id 
		
		set id = InvokeTimerWithItem( GetManipulatedItem(), "babbling_pebble_item", 1, true, function check )
		call SaveUnitHandle( udg_hash, id, STRING_HASH, GetManipulatingUnit() ) 
	endfunction 
	
	//=========================================================================== 
	private function init takes nothing returns nothing 
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope