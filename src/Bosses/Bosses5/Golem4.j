scope Golem4 initializer init
	
	globals
		public trigger Trigger = null
		
		private constant integer ITEM_ID = 'I0I0'
		private constant integer COOLDOWN = 12
		private constant string ANIMATION = "Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl"
	endglobals

	private function condition takes nothing returns boolean
		return GetUnitTypeId(udg_DamageEventTarget) == 'n00R' and GetUnitLifePercent(udg_DamageEventTarget) <= 95
	endfunction
	
	private function LockItem takes unit hero, integer slot returns nothing
		local item itemUsed
		local string text
		local item locker

		set itemUsed = UnitItemInSlot(hero, slot )
		
		call UnitRemoveItemFromSlot(hero, slot)
		call SetItemPositionLoc( itemUsed, SpecialLocation_Get(LOC_TYPE_ITEM_HIDDEN)  )
		call SetItemVisible( itemUsed, false )
		
    	set locker = CreateItem( ITEM_ID, GetUnitX( hero ), GetUnitY( hero ) )
        call UnitAddItem(hero, locker )
        call UnitDropItemSlot( hero, locker, slot )
        
        set text = words( hero, BlzGetItemDescription(locker), "|cffffcc00", "|r", GetItemName(itemUsed) )
        call BlzSetItemExtendedTooltip( locker, text )
		
		call SaveItemHandle(udg_hash, GetHandleId( locker ), StringHash("locker_item"), itemUsed )

		/*call BJDebugMsg("locker: " + GetItemName(locker) )
		call BJDebugMsg("lock: " + GetItemName(itemUsed) )*/
		
		set itemUsed = null
		set locker = null
	endfunction
	
	private function LockForHero takes unit boss, unit hero returns nothing
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
		
		if items.Size == 0 then
			return
		endif
		
		call LockItem(hero, items.GetRandomCell() )
		call DestroyEffect( AddSpecialEffectTarget( ANIMATION, hero, "origin" ) )
		
		call items.destroy()
		set itemUsed = null
	endfunction
	
	private function MakePolarizedItems takes unit boss returns nothing
		local group heroes = DeathSystem_GetAliveHeroGroupCopy()
		local unit u
		
		loop
			set u = FirstOfGroup(heroes)
			exitwhen u == null
			if IsUnitAlive(u) then //Heroes under ressurections counts as alive
				call LockForHero(boss, u)
			endif
			call GroupRemoveUnit(heroes, u)
		endloop
	
		call DestroyGroup(heroes)
		set heroes = null
		set u = null
	endfunction
	
	private function GolemAbility takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "boss_golem_4" ) )

	    if IsUnitDead(boss) or not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
	    else
	        call MakePolarizedItems(boss)
	    endif
	    
	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
		call InvokeTimerWithUnit( udg_DamageEventTarget, "boss_golem_4", bosscast(COOLDOWN), true, function GolemAbility )
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
		call DisableTrigger(Trigger)
	endfunction
	
endscope