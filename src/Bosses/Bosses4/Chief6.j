scope Chief6 initializer init

	globals
		private constant integer ITEM_ID = 'I0HZ'
		private constant integer COOLDOWN = 35
		private constant string ANIMATION = "Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl"
		
		public trigger Trigger = null
		public trigger Trigger2 = null
		private location HiddenLocation = GetRectCenter(gg_rct_Hidden)
		private boolean isActive = false
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetUnitTypeId( udg_DamageEventTarget ) == 'h01X'
	endfunction
	
	//====================== Unlock ======================
	private function UnlockItem takes unit hero, item locker, integer slot returns nothing
		local item itemUsed = LoadItemHandle(udg_hash, GetHandleId( locker ), StringHash("locker_item") )
		
		call UnitRemoveItemFromSlot(hero, slot)
		call SetItemVisible( itemUsed, true )
		call SetItemPosition( itemUsed, GetUnitX(hero), GetUnitY(hero) )
		call UnitAddItem(hero, itemUsed )
		call UnitDropItemSlot( hero, itemUsed, slot )
		call RemoveItem(locker)
		
		set itemUsed = null
	endfunction
	
	private function UnlockHero takes unit hero returns nothing
		local integer i
		local integer iMax
		local item itemUsed
	
		set i = 0
		set iMax = UnitInventorySize(hero)
		loop
			exitwhen i >= iMax
			set itemUsed = UnitItemInSlot(hero, i)
			if itemUsed != null and GetItemTypeId( itemUsed ) == ITEM_ID then
				call UnlockItem(hero, itemUsed, i)
			endif
			set i = i + 1
		endloop

		call SaveBoolean(udg_hash, GetHandleId( hero ), StringHash("locker_is_locked"), false )
		call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX(hero), GetUnitY(hero) ) )
		
		set itemUsed = null
	endfunction
	
	public function UnlockItems takes nothing returns nothing
		local group heroes = DeathSystem_GetAliveHeroGroupCopy()
		local unit u
		local boolean isLocked
		
		loop
			set u = FirstOfGroup(heroes)
			exitwhen u == null
			set isLocked = LoadBoolean(udg_hash, GetHandleId( u ), StringHash("locker_is_locked") )
			if isLocked and IsUnitAlive(u) then
				call UnlockHero(u)
			endif
			call GroupRemoveUnit(heroes, u)
		endloop
	
		call DestroyGroup(heroes)
		set heroes = null
		set u = null
	endfunction
	
	//====================== Lock ======================
	private function LockItem takes unit hero, integer slot returns nothing
		local item itemUsed
		local string text
		local item locker

		set itemUsed = UnitItemInSlot(hero, slot )
		
		call UnitRemoveItemFromSlot(hero, slot)
		call SetItemPositionLoc( itemUsed, HiddenLocation )
		call SetItemVisible( itemUsed, false )
		
    	set locker = CreateItem( ITEM_ID, GetUnitX( hero ), GetUnitY( hero ) )
        call UnitAddItem(hero, locker )
        call UnitDropItemSlot( hero, locker, slot )
        
        set text = words( hero, BlzGetItemDescription(locker), "|cffffcc00", "|r", GetItemName(itemUsed) )
        call BlzSetItemExtendedTooltip( locker, text )
		
		call SaveItemHandle(udg_hash, GetHandleId( locker ), StringHash("locker_item"), itemUsed )
		call SaveBoolean(udg_hash, GetHandleId( hero ), StringHash("locker_is_locked"), true )
		
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
			if itemUsed != null and GetItemTypeId( itemUsed ) != ITEM_ID then
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
	
	private function UseLocker takes unit boss returns nothing
		local group heroes = DeathSystem_GetAliveHeroGroupCopy()
		local unit u
		
		loop
			set u = FirstOfGroup(heroes)
			exitwhen u == null
			call LockForHero(boss, u)
			call GroupRemoveUnit(heroes, u)
		endloop
	
		call DestroyGroup(heroes)
		set heroes = null
		set u = null
	endfunction
	
	private function LockCooldown takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "boss_chief_lock" ) )

	    if IsUnitDead(boss) or not( udg_fightmod[0] ) then
	        call DestroyTimer( GetExpiredTimer() )
	        call FlushChildHashtable( udg_hash, id )
	    else
	        call UseLocker(boss)
	    endif
	    
	    set boss = null
	endfunction
	
	private function action takes nothing returns nothing
	    call DisableTrigger( GetTriggeringTrigger() )
	    set isActive = true
	    call InvokeTimerWithUnit( udg_DamageEventTarget, "boss_chief_lock", bosscast(COOLDOWN), true, function LockCooldown )
	endfunction
	
	//===========================================================================
	private function OnBattleEnd_Condition takes nothing returns boolean
	    return isActive
	endfunction
	
	private function OnBattleEnd takes nothing returns nothing
	    call UnlockItems()
	    set isActive = false
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	    call DisableTrigger( Trigger )
	    
	    call CreateEventTrigger( "udg_FightEnd_Real", function OnBattleEnd, function OnBattleEnd_Condition )
	endfunction

endscope