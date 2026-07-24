scope CheatDamage initializer init
	//shows none if damage 0
	
	globals
		public trigger Trigger = null
		private trigger AttackTrigger = null
		
		private boolean isEnabled = false
	endglobals
	
	private function OnAttack takes nothing returns nothing
		local real damageDealt = GetEventDamage()//AfterAttack.GetDataReal("damage")
		local unit dealer = GetEventDamageSource() //AfterAttack.GetDataUnit("caster")
		local real originalDamage = Event_OnDamageChange_StaticDamage//GetEventDamage()
		local integer percent
	
		call BJDebugMsg("----------------")
		set percent = R2I( ( damageDealt - originalDamage ) / originalDamage * 100 )
		call BJDebugMsg("Damage: " + R2S(damageDealt) + " (" + I2S(percent) + "%).")
		call BJDebugMsg("Dealer: " + GetUnitName(dealer))
		
		set dealer = null
	endfunction
	
	private function action takes nothing returns nothing	
		set isEnabled = isEnabled == false
		
		if isEnabled then
			call EnableTrigger(AttackTrigger)
			call BJDebugMsg("Damage Check Enabled.")
		else
			call DisableTrigger(AttackTrigger)
			call BJDebugMsg("Damage Check Disabled.")
		endif
	endfunction

	private function init takes nothing returns nothing
		//set AttackTrigger = AfterAttack.AddListener(function OnAttack, null)

		set AttackTrigger = CreateTrigger(  )
	    call TriggerRegisterAnyUnitEventBJ( AttackTrigger, EVENT_PLAYER_UNIT_DAMAGED )
	    call TriggerAddAction( AttackTrigger, function OnAttack )
	    call DisableTrigger(AttackTrigger)
	    
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-damage", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope