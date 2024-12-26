scope SniperRH initializer init

    globals
		trigger trg_SniperRH = null
		private constant integer ITEM_ID = 'I05T'
		private constant integer ITEM_ALT_ID = 'I0HC'
    endglobals

private function Trig_SniperRH_Actions takes nothing returns nothing
    local unit caster 
    local unit u 
    local item it = GetManipulatedItem()
    local integer itid = GetItemTypeId(it)
    local integer itHandle
    local real heal 
    local real mana
    
    if itid == ITEM_ID then
    	set itHandle = GetHandleId( it )
    	set u = GetManipulatingUnit()
    	set caster = LoadUnitHandle( udg_hash, itHandle, StringHash( "snpr" ) )
    elseif itid == ITEM_ALT_ID then
    	set itHandle = GetHandleId( it )
    	set u = GetManipulatingUnit()
    	set caster = LoadUnitHandle( udg_hash, itHandle, StringHash( "snpr" ) )
    	
    	set mana = LoadReal( udg_hash, itHandle, StringHash( "snprm" ) )
    	call manast(caster, u, mana)
    	call RemoveSavedReal(udg_hash, itHandle, StringHash( "snprm" ) )
    else
    	set it = null
    	return
    endif
    
    set heal = LoadReal( udg_hash, itHandle, StringHash( "snpr" ) )
    call healst( caster, u,  heal)
    call RemoveSavedHandle(udg_hash, itHandle, StringHash( "snpr" ) )
    call RemoveSavedReal(udg_hash, itHandle, StringHash( "snpr" ) )
    call spectimeunit( u, "Abilities\\Spells\\Human\\Heal\\HealTarget.mdl", "origin", 2 )
    
    set caster = null
    set u = null
    set it = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_SniperRH = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_SniperRH, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddAction( trg_SniperRH, function Trig_SniperRH_Actions )
endfunction

endscope

