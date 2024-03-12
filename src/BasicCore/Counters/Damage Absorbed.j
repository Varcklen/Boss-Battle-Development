scope DamageAbsorbed initializer init

	globals
		public integer array Value[5]
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false and IsUnitType( udg_DamageEventTarget, UNIT_TYPE_HERO) and combat(udg_DamageEventTarget, false, 0)
	endfunction

	private function action takes nothing returns nothing
		local real previousDamage = Event_OnDamageChange_StaticDamage
		local real currentDamage = udg_DamageEventAmount
		local integer index = GetUnitUserData(udg_DamageEventTarget)
		local real damageAbsorbed = RMaxBJ(0, previousDamage - currentDamage)
		
		set Value[index] = Value[index] + R2I(damageAbsorbed)
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateEventTrigger( "udg_DamageEvent", function action, function condition )
	endfunction

endscope