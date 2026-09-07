scope PolarizedItem initializer init
	
	globals
		private constant integer ITEM_ID = 'I0I0'
		private constant integer DAMAGE = 250
		private constant string ANIMATION = "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId( GetManipulatedItem() ) == ITEM_ID
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = GetManipulatingUnit()
	    local item locker = GetManipulatedItem()
	    local item itemUsed = LoadItemHandle(udg_hash, GetHandleId( locker ), StringHash("locker_item") )
	    local integer slot = -1
		local integer i
		local integer iMax
		
		set i = 0
		set iMax = UnitInventorySize(caster)
		loop
			exitwhen i >= iMax
			if UnitItemInSlot(caster, i) == locker then
				set slot = i
				exitwhen true
			endif
			set i = i + 1
		endloop

	    call UnitRemoveItemFromSlot(caster, slot)
		call SetItemVisible( itemUsed, true )
		call SetItemPosition( itemUsed, GetUnitX(caster), GetUnitY(caster) )
		call UnitAddItem(caster, itemUsed )
		call UnitDropItemSlot( caster, itemUsed, slot )
		
	    call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX(caster), GetUnitY(caster) ) )
	    call UnitDamageTarget( caster, caster, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
	    
	    call RemoveItem(locker)
	    
	    set caster = null
	    set locker = null
	    set itemUsed = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_USE_ITEM, function action, function condition )
	endfunction
	
endscope