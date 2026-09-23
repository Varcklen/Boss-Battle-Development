scope GrandMage5 initializer init
	
	globals
		public trigger Trigger = null
		
		private constant integer VAUNT_ID = 'h01W'
		private constant integer SPAWN_DEVIATION = 300
	endglobals
	
	struct VaultItem
        readonly unit hero
        readonly item itemStolen
        
        static method create takes unit hero, item itemStolen returns VaultItem
            local VaultItem this = VaultItem.allocate()
            
            set .hero = hero
            set .itemStolen = itemStolen
             
            return this
        endmethod
    endstruct
    
	private function condition takes nothing returns boolean
		return GetUnitTypeId( udg_DamageEventTarget ) == 'h003'
	endfunction
	
	private function LockItem takes unit hero, unit vault, integer slot, ListInt vaultData returns nothing
		local item itemUsed
		local VaultItem vaultItem

		set itemUsed = UnitItemInSlot(hero, slot )
		
		call UnitRemoveItemFromSlot(hero, slot)
		call SetItemPositionLoc( itemUsed, SpecialLocation_Get(LOC_TYPE_ITEM_HIDDEN) )
		call SetItemVisible( itemUsed, false )

		set vaultItem = VaultItem.create(hero, itemUsed)
		call vaultData.Add(vaultItem)
		
		/*call BJDebugMsg("hero: " + GetUnitName(hero))
		call BJDebugMsg("itemUsed: " + GetItemName(itemUsed))
		call BJDebugMsg("value: " + I2S(vaultItem) )*/
		
		call PlayAnimation_ItemSteal(hero, vault)
		
		set itemUsed = null
	endfunction
	
	private function LockForHero takes unit boss, unit vault, unit hero, ListInt vaultCells returns nothing
		local ListInt items = ListInt.create()
		local integer i
		local integer iMax
		local item itemUsed

		set i = 0
		set iMax = UnitInventorySize(hero)
		loop
			exitwhen i >= iMax
			set itemUsed = UnitItemInSlot(hero, i)
			if itemUsed != null and ItemManipulation_IsLockable(itemUsed) == false  then
				call items.Add(i)
			endif
			set i = i + 1
		endloop
		
		if items.Size == 0 then
			return
		endif
		
		call LockItem(hero, vault, items.GetRandomCell(), vaultCells )
		
		call items.destroy()
		set itemUsed = null
	endfunction
	
	private function TakeItems takes unit boss, unit vault returns nothing
		local group heroes = DeathSystem_GetAliveHeroGroupCopy()
		local unit u
		local ListInt vaultData = ListInt.create()
		
		loop
			set u = FirstOfGroup(heroes)
			exitwhen u == null
			if IsUnitAlive(u) then //Heroes under ressurections counts as alive
				call LockForHero(boss, vault, u, vaultData )
			endif
			call GroupRemoveUnit(heroes, u)
		endloop
		
		call SaveInteger(udg_hash, GetHandleId(vault), StringHash("boss_mage_vault"), vaultData )
	
		call DestroyGroup(heroes)
		set heroes = null
		set u = null
	endfunction
	
	private function SpawnVault takes unit boss returns nothing
		local location unitLoc = GetUnitLoc(boss)
		local location spawnLoc = PolarProjectionBJ(unitLoc, SPAWN_DEVIATION, GetRandomDirectionDeg() )
		local unit vault
		
		set vault = CreateUnitAtLoc( GetOwningPlayer(boss), VAUNT_ID, spawnLoc, 270 )
		
		call TakeItems(boss, vault)
		
		call RemoveLocation(unitLoc)
		call RemoveLocation(spawnLoc)
		set unitLoc = null
		set spawnLoc = null
		set vault = null
	endfunction
	
	private function action takes nothing returns nothing
		call DisableTrigger( GetTriggeringTrigger() )
		call SpawnVault(udg_DamageEventTarget)
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
		call DisableTrigger(Trigger)
	endfunction
	
endscope