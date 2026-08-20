scope StarInBottle initializer init
	
	globals
		private constant integer ITEM_ID = 'I05S'
		private constant integer LUCK_GAIN = 25
		private constant integer SPELL_POWER_BONUS = 60
	endglobals
	
	private function Check takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_ID
	endfunction
	
	private function ConditionCheck takes nothing returns nothing 
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit hero = LoadUnitHandle( udg_hash, id, StringHash( "star_in_bottle_hero" ) )
	    local item it = LoadItemHandle( udg_hash, id, StringHash( "star_in_bottle" ) )
	    local boolean active = LoadBoolean( udg_hash, id, StringHash( "star_in_bottle_is_active" ) )
	    local boolean isConditionMet
	
	    if UnitHasItem(hero,it) == false then
	        if active then
	            call spdst(hero, -SPELL_POWER_BONUS)
	        endif
	        call DestroyTimer( GetExpiredTimer() )
	    elseif IsUnitAlive(hero) then
	        
	        set isConditionMet = AlchemyOnly(hero)
	        
	        if isConditionMet and active == false then
	            call spdst(hero, SPELL_POWER_BONUS)
	            call SaveBoolean( udg_hash, id, StringHash( "star_in_bottle_is_active" ), true )
	        elseif isConditionMet == false and active then
	            call spdst(hero, -SPELL_POWER_BONUS)
	            call SaveBoolean( udg_hash, id, StringHash( "star_in_bottle_is_active" ), false )
	        endif
	    endif
	    
	    set it = null
	    set hero = null
	endfunction 

	private function OnGain takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		local integer id
	
		call luckyst( hero, LUCK_GAIN )
		
		set id = InvokeTimerWithItem( GetManipulatedItem(), "star_in_bottle", 4, true, function ConditionCheck )
	    call SaveUnitHandle( udg_hash, id, StringHash( "star_in_bottle_hero" ), hero ) 
		
		set hero = null
	endfunction
	
	private function OnLose takes nothing returns nothing
		call luckyst( GetManipulatingUnit(), -LUCK_GAIN )
	endfunction

	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function OnGain, function Check )
		call CreateNativeEvent( EVENT_PLAYER_UNIT_DROP_ITEM, function OnLose, function Check )
	endfunction

endscope