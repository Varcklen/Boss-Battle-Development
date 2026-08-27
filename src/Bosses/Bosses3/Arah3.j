scope Arah3 initializer init

	globals
		public trigger Trigger = null
		private integer EvasionChance = 0
		
		private constant integer BASE_LUCK_CHANCE = 80
		private constant integer CHANCE_TO_LOSE = 1
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetUnitTypeId(udg_DamageEventTarget) == 'h00K' and udg_IsDamageSpell == false
	endfunction
	
	private function action takes nothing returns nothing
		local integer id = GetHandleId( udg_DamageEventTarget )
		local integer chance = IMaxBJ(0, EvasionChance )
		
		//call BJDebugMsg("chance: " + I2S(chance))
		if GetRandomInt(1, 100) <= chance then
			set udg_DamageEventAmount = 0
            set udg_DamageEventType = udg_DamageTypeBlocked
            set EvasionChance = EvasionChance - CHANCE_TO_LOSE
		endif
	endfunction
	
	//===========================================================================
	private function OnSpawn_Condition takes nothing returns boolean
	    return GetUnitTypeId(GetEnteringUnit()) == 'h00K'
	endfunction
	
	private function OnSpawn takes nothing returns nothing
		set EvasionChance = BASE_LUCK_CHANCE
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig 
		
	    set Trigger = CreateEventTrigger( "udg_DamageModifierEvent", function action, function condition )
	    call DisableTrigger( Trigger )
	    
	    set trig = CreateTrigger(  )
	    call TriggerRegisterEnterRectSimple( trig, GetWorldBounds() )
	    call TriggerAddCondition( trig, Condition( function OnSpawn_Condition ) )
	    call TriggerAddAction( trig, function OnSpawn )
	    
	    set trig = null
	endfunction

endscope