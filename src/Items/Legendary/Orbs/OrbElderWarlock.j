scope OrbElderWarlock initializer init
	
	private function condition takes nothing returns boolean
	    return GetItemTypeId(GetManipulatedItem()) == 'I0FX'
	endfunction
	
	private function MinionCheck takes unit minion returns boolean
		if IsUnitType( minion, UNIT_TYPE_ANCIENT ) then
			return false
		endif
		if IsUnitType( minion, UNIT_TYPE_HERO ) then
			return false
		endif
		if IsUnitDead(minion) then
			return false
		endif
		if GetUnitTypeId( minion ) == 'h01B' then
			return false
		endif
		if GetUnitName(minion) == "dummy"  then
			return false
		endif
		return true
	endfunction
	
	private function CheckAmount takes player owner returns integer
		local group g = CreateGroup()
	    local unit u
	    local integer amount = 0
	
		call GroupEnumUnitsOfPlayer(g, owner, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if MinionCheck( u ) then
	            set amount = amount + 1
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    call DestroyGroup( g )
	    set u = null
	    set g = null
	    return amount
	endfunction
	
	function OrbElderWarlockCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "orbew" ) )
	    local item it = LoadItemHandle( udg_hash, id, StringHash( "orbewi" ) )
	    local integer idItem = GetHandleId( it )
	    local real oldAmount = LoadReal( udg_hash, id, StringHash( "orbew" ) )
	    local real spellPowerToAdd
	    local real currentBonus = LoadReal( udg_hash, idItem, StringHash( "orbewn" ) )
	    local integer amount = 0
	
	    set amount = CheckAmount( GetOwningPlayer(caster) )
	    set spellPowerToAdd = (amount - oldAmount) * 5
	
	    /*if not(UnitHasItem(caster, it)) then
	        call spdst( caster, spdnow )
	        call SaveReal( udg_hash, GetHandleId( caster ), StringHash( "orbewn" ), 0 )
	        call FlushChildHashtable( udg_hash, id )
	        call DestroyTimer( GetExpiredTimer() )
	    else*/if spellPowerToAdd != 0 then
	        call spdst( caster, spellPowerToAdd )
	        call SaveReal( udg_hash, idItem, StringHash( "orbewn" ), currentBonus + spellPowerToAdd )
	        call SaveReal( udg_hash, id, StringHash( "orbew" ), amount ) 
	    endif

	    set caster = null
	    set it = null
	endfunction
	
	private function action takes nothing returns nothing
	    local integer id = GetHandleId( GetManipulatedItem() )
	    local timer usedTimer
	
	    if LoadTimerHandle( udg_hash, id, StringHash( "orbew" ) ) == null  then
	    	set usedTimer = CreateTimer()
	        call SaveTimerHandle( udg_hash, id, StringHash( "orbew" ), usedTimer )
	    endif
	    set id = GetHandleId( usedTimer )
	    call SaveUnitHandle( udg_hash, id, StringHash( "orbew" ), GetManipulatingUnit() ) 
	    call SaveItemHandle( udg_hash, id, StringHash( "orbewi" ), GetManipulatedItem() )
	    call TimerStart( usedTimer, 1, true, function OrbElderWarlockCast )
	    
	    set usedTimer = null
	endfunction
	
	//===========================================================================
	private function drop_condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == 'I0FX'
	endfunction
	
	private function drop_action takes nothing returns nothing
		local integer id = GetHandleId( GetManipulatedItem() )
		local timer usedTimer = LoadTimerHandle( udg_hash, id, StringHash( "orbew" ) )
		local real spellPowerBonus = LoadReal( udg_hash, id, StringHash( "orbewn" ) )
		
		call spdst( GetManipulatingUnit(), -spellPowerBonus )
		call FlushChildHashtable( udg_hash, GetHandleId( usedTimer ) )
		call FlushChildHashtable( udg_hash, GetHandleId( GetManipulatedItem() ) )
		call DestroyTimer( usedTimer )
		
		set usedTimer = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_DROP_ITEM, function drop_action, function drop_condition )
	endfunction
	
endscope