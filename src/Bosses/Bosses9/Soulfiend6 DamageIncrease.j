scope Soulfiend6 initializer init

	private function condition takes nothing returns boolean
		return udg_IsDamageSpell == false and GetUnitTypeId(udg_DamageEventSource) == 'n04F'
	endfunction

	private function action takes nothing returns nothing
		local integer id = GetHandleId( udg_DamageEventSource )
		local real damageBonus = LoadReal( udg_hash, id, StringHash( "bdmg" ) ) + 0.05 * udg_DamageEventAmount
		
        set udg_DamageEventAmount = udg_DamageEventAmount + damageBonus
        if udg_DamageEventAmount >= GetUnitState( udg_DamageEventTarget, UNIT_STATE_LIFE) then
            call SaveReal( udg_hash, id, StringHash( "bdmg" ), 0 )
        else
            call SaveReal( udg_hash, id, StringHash( "bdmg" ), damageBonus )
        endif
	endfunction

	private function init takes nothing returns nothing
	    call CreateEventTrigger( "Event_OnDamageChange_Real", function action, function condition )
	endfunction

endscope
