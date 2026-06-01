scope GnomishArmyKnife initializer init

	private function condition takes nothing returns boolean
	    return GetItemTypeId(GetManipulatedItem()) == 'I05I'
	endfunction
	
	private function check takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "gnomish_army_knife_unit" ) )
	    local item it = LoadItemHandle( udg_hash, id, StringHash( "gnomish_army_knife" ) )
	    local integer arm = LoadInteger( udg_hash, id, StringHash( "gnomish_army_knife" ) )
	    local integer mech = SetCount_GetPieces(caster, SET_MECH)
	    local integer spd = (mech - arm) * 6
	    local integer spdnow = LoadInteger( udg_hash, id, StringHash( "gnomish_army_knife_now" ) )
	
	    if not(UnitHasItem(caster, it)) then
	        call statst( caster, -spdnow, -spdnow, -spdnow, 0, false )
	        call SaveReal( udg_hash, id, StringHash( "gnomish_army_knife_now" ), 0 )
	        call FlushChildHashtable( udg_hash, id )
	        call DestroyTimer( GetExpiredTimer() )
	    elseif arm != mech then
	        call statst( caster, spd, spd, spd, 0, false )
	        call SaveInteger( udg_hash, id, StringHash( "gnomish_army_knife_now" ), spdnow+spd )
	        call SaveInteger( udg_hash, id, StringHash( "gnomish_army_knife" ), mech ) 
	    endif
	
	    set caster = null
	    set it = null
	endfunction
	
	private function action takes nothing returns nothing
	    local integer id
	
		set id = InvokeTimerWithItem( GetManipulatedItem(), "gnomish_army_knife", 1, true, function check )
		call SaveUnitHandle( udg_hash, id, StringHash( "gnomish_army_knife_unit" ), GetManipulatingUnit() ) 
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set gg_trg_Steam_generator = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( gg_trg_Steam_generator, EVENT_PLAYER_UNIT_PICKUP_ITEM ) 
	    call TriggerAddCondition( gg_trg_Steam_generator, Condition( function condition ) )
	    call TriggerAddAction( gg_trg_Steam_generator, function action )
	endfunction

endscope