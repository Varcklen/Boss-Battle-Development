scope NAME initializer init
	
	globals
		private constant integer
	endglobals

	private function condition takes nothing returns boolean
		return 
	endfunction
	
	private function action takes nothing returns nothing
		
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		
	endfunction
	
endscope
	
	EventName.GetDataUnit("unit")
    call EventName.SetDataUnit("unit", UNIT)
	call EventName.Invoke()
	call EventName.AddListener(function action, function condition)
	
	ExtraArenaGeneral_IsPvPActive()
	ItemManipulation_IsInventoryFull()
	Trigger_GetItemUsed()
	DeathSystem_GetAliveHeroGroupCopy()
	
	
	//===========================================================================
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
		call DisableTrigger(Trigger)
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( eventId, function action, function condition )
	endfunction
	
	call bufallst( caster, target, '', 0, 0, 0, 0, '', "", t )
	
	call GroupAoE( caster, x, y, dmg, area, who, null, null )
	
	call InvokeTimerWithUnit( udg_DamageEventTarget, "bsdm2", bosscast(ATTACK_GAIN_COOLDOWN), true, function PowerUp )
	
	call IndicatorSystem_Create( indicatorType, x, y, area, duration, unit owner )
	
	