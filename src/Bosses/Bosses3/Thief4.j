scope Thief4 initializer init

	globals
		public trigger Trigger = null
		
		private constant integer ITEM_ID = 'I0HY'
		private constant string ANIMATION = "Abilities\\Spells\\NightElf\\shadowstrike\\shadowstrike.mdl"
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetUnitTypeId(udg_DamageEventTarget) == 'h015'
	endfunction
	
	private function SpawnSouls takes nothing returns nothing
		local group heroes = DeathSystem_GetAliveHeroGroupCopy()
		local unit u
		local boolean isAdded
		local integer limit = 1
		
		loop
			set u = FirstOfGroup(heroes)
			exitwhen u == null
			set isAdded = false
			set limit = 1
			loop
				exitwhen ItemManipulation_IsInventoryFull(u) or limit > 10
				call UnitAddItem( u, CreateItem( ITEM_ID, GetUnitX( u ), GetUnitY(u) ) )
				set isAdded = true
				set limit = limit + 1
			endloop
            if isAdded then
            	call spectimeunit( u, ANIMATION, "overhead", 3 )
            endif
			call GroupRemoveUnit(heroes, u)
		endloop
	
		call DestroyGroup(heroes)
		set heroes = null
		set u = null
	endfunction

	private function action takes nothing returns nothing
	    call DisableTrigger( GetTriggeringTrigger() )
	    if GetOwningPlayer(udg_DamageEventTarget) == Player(10) then
	    	call SpawnSouls()
    	endif
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	    call DisableTrigger( Trigger )
	endfunction

endscope