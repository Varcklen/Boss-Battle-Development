scope IncubusMoney initializer init

	private function condition takes nothing returns boolean
		return udg_IsDamageSpell == false and GetUnitAbilityLevel( udg_DamageEventSource, 'A14R' ) > 0 and combat(udg_DamageEventSource, false, 0) and udg_fightmod[3] == false and IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer( udg_DamageEventTarget ) )
	endfunction

	private function action takes nothing returns nothing
		local unit caster = udg_DamageEventSource
		local integer moneyGain = LoadInteger( udg_hash, GetHandleId( caster ), StringHash( "mephw" ) )
		
		set moneyGain = IMaxBJ(2, moneyGain + 1 )
        call moneyst( caster, moneyGain )
        
        set caster = null
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	endfunction

endscope