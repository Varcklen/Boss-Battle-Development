scope AirTotem initializer init
	
	globals
		public trigger Trigger = null
	endglobals
	
	private function LockItem takes unit hero, unit vault, integer slot returns nothing
		local item itemUsed

		set itemUsed = UnitItemInSlot(hero, slot )
		
		call UnitRemoveItemFromSlot(hero, slot)
		call SetItemPositionLoc( itemUsed, SpecialLocation_Get(LOC_TYPE_ITEM_HIDDEN) )
		call SetItemVisible( itemUsed, false )

		/*call BJDebugMsg("hero: " + GetUnitName(hero))
		call BJDebugMsg("itemUsed: " + GetItemName(itemUsed))
		call BJDebugMsg("value: " + I2S(vaultItem) )*/
		
		call PlayAnimation_ItemSteal(hero, vault)
		
		call SaveUnitHandle(udg_hash, GetHandleId(vault), StringHash("air_totem_target"), hero )
		call SaveItemHandle(udg_hash, GetHandleId(vault), StringHash("air_totem_item"), itemUsed )
		
		set itemUsed = null
	endfunction
	
	private function LockForHero takes unit vault, unit hero returns nothing
		local ListInt items = ListInt.create()
		local integer i
		local integer iMax
		local item itemUsed
		
		set i = 0
		set iMax = UnitInventorySize(hero)
		loop
			exitwhen i >= iMax
			set itemUsed = UnitItemInSlot(hero, i)
			if itemUsed != null and ItemManipulation_IsLockable(itemUsed) == false then
				call items.Add(i)
			endif
			set i = i + 1
		endloop
		
		set itemUsed = null
		if items.Size == 0 then
			call KillUnit(vault)
			call items.destroy()
			return
		endif
		
		call LockItem(hero, vault, items.GetRandomCell() )
		
		call items.destroy()
	endfunction

	private function action takes nothing returns nothing
		local unit totem = Woodo1_TriggerTotem
		local group heroes = DeathSystem_GetAliveHeroGroupCopy()
		local unit target

		set target = GroupPickRandomUnit(heroes)
		
		if target == null then
			call KillUnit(totem)
			return
		endif
		call LockForHero(totem, target)

		call DestroyGroup(heroes)
		set heroes = null
		set target = null
		set totem = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateTrigger(  )
    	call TriggerAddAction( Trigger, function action )
	endfunction
	
endscope