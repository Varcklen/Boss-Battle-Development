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
	
	call GetArenaSpawnLocation( unitLoc, SPAWN_RANGE, angle )
	
	call StatSystem_Add( unit, STAT_TYPE, VALUE_TO_ADD)
	
	constant integer STAT_BUFF_DURATION = 0
	constant integer STAT_COOLDOWN = 1
	constant integer STAT_DAMAGE_DEALT = 2
	constant integer STAT_DAMAGE_DEALT_BOSSES = 3
	constant integer STAT_DAMAGE_DEALT_MINIONS = 4
	constant integer STAT_DAMAGE_DEALT_MINIONS_PHY = 5
	constant integer STAT_DAMAGE_DEALT_MAG = 6
	constant integer STAT_DAMAGE_DEALT_PHY = 7
	constant integer STAT_DAMAGE_TAKEN = 8
	constant integer STAT_DAMAGE_TAKEN_PHY = 9
	constant integer STAT_DODGE = 10
	constant integer STAT_GOLD_GAIN = 11
	constant integer STAT_HEAL_BONUS = 12
	constant integer STAT_HEAL_TAKEN = 13
	constant integer STAT_MANA_HEAL_BONUS = 14
	constant integer STAT_MOON_SET_DAMAGE_DEALT = 15
	constant integer STAT_VAMPIRISM = 16
	constant integer STAT_VAMPIRISM_MAG = 17
	constant integer STAT_VAMPIRISM_PHY = 18
	constant integer STAT_SHOP_DISCOUNT = 19
	constant integer STAT_DAMAGE_TAKEN_FROM_MINIONS = 20
	
	