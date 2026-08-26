scope Kobold1 initializer init
	
	globals
		private constant integer DAMAGE = 40
		private constant integer AREA = 600
		private constant string ANIMATION = "Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl"
		private constant integer COUNTER_REQUIRED = 3
		private constant integer EFFECT_ID = 'A1JL'
		private constant integer BUFF_ID = 'B0B8'
		
		private unit Target = null
		private integer Counter = 0
		private boolean isSplash = false
		
		public trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetUnitTypeId(udg_DamageEventSource) == 'n00P' and isSplash == false
	endfunction
	
	private function Delay takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
	    local unit boss = LoadUnitHandle( udg_hash, id, StringHash( "kobold_boss_attack" ) )
	
		set isSplash = true
		call GroupAoE(boss, GetUnitX( boss ), GetUnitY( boss ), DAMAGE, AREA, TARGET_ENEMY, null, ANIMATION)
		set isSplash = false
		call FlushChildHashtable( udg_hash, id )
	endfunction
	
	private function action takes nothing returns nothing
		local unit target = udg_DamageEventTarget
		local unit attacker = udg_DamageEventSource
	
		if target == Target then
			set Counter = Counter + 1
			//call BJDebugMsg("+1")
		else
			set Counter = 0
			call UnitRemoveAbility(attacker, EFFECT_ID)
			call UnitRemoveAbility(attacker, BUFF_ID)
			//call BJDebugMsg("0")
		endif
		
		
		/*call BJDebugMsg("Counter: " + I2S(Counter))
		call BJDebugMsg("Target: " + GetUnitName(Target))
		call BJDebugMsg("udg_DamageEventTarget: " + GetUnitName(target))*/
		
		if Counter == COUNTER_REQUIRED - 1 then
			call UnitAddAbility(attacker, EFFECT_ID)
			//call BJDebugMsg("buff")
		endif
	
		if Counter >= COUNTER_REQUIRED and udg_Heroes_Amount > 1 then
			call InvokeTimerWithUnit( attacker, "kobold_boss_attack", 0.01, false, function Delay )
		endif
		set Target = target
		
		set target = null
		set attacker = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	    call DisableTrigger( Trigger )
	endfunction
	
endscope