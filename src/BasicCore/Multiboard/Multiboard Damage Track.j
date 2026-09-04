scope MultiboardDamageTrack initializer init

	globals
		private trigger Trigger = null
	endglobals

	private function condition takes nothing returns boolean
		if ExtraArenaGeneral_IsPvPActive() then
			return false
		endif
		if IsUnitAlly(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) then
			return false
		endif
		return true
	endfunction
	
	private function AttackerTrack takes unit attacker, real damage returns nothing
		local integer i = GetPlayerId( GetOwningPlayer(attacker) ) + 1
	
		set udg_DamageAllTime[i] = udg_DamageAllTime[i] + damage
        set udg_DamageFight[i] = udg_DamageFight[i] + damage
        call Multiboard_MultiSetValue( udg_multi, 6, udg_Multiboard_Position[i] * 3 - 1, R2SI( udg_DamageAllTime[i] ) )
        call Multiboard_MultiSetValue( udg_multi, 7, udg_Multiboard_Position[i] * 3 - 1, R2SI( udg_DamageFight[i] ) )
        if udg_IsDamageSpell then
            set udg_Info_DamageMagic[i] = udg_Info_DamageMagic[i] + damage
        else
            set udg_Info_DamagePhysical[i] = udg_Info_DamagePhysical[i] + damage
        endif
	endfunction
	
	private function TargetTrack takes unit target, real damage returns nothing
		local integer k = GetUnitUserData(target)

		set udg_DamagedAllTime[k] = udg_DamagedAllTime[k] + damage
        set udg_DamagedFight[k] = udg_DamagedFight[k] + damage
        call Multiboard_MultiSetValue( udg_multi, 13, udg_Multiboard_Position[k] * 3 - 1, R2SI( udg_DamagedAllTime[k] ) )
        call Multiboard_MultiSetValue( udg_multi, 14, udg_Multiboard_Position[k] * 3 - 1, R2SI( udg_DamagedFight[k] ) )
	endfunction
	
	private function action takes nothing returns nothing
		local real targetHealth 
		local real value 
		
		set targetHealth = GetUnitState( udg_DamageEventTarget, UNIT_STATE_LIFE )
		set value = RMinBJ(udg_DamageEventAmount, targetHealth)
        
        if IsUnitType( udg_DamageEventTarget, UNIT_TYPE_HERO) and combat( udg_DamageEventTarget, false, 0 ) then
            call TargetTrack(udg_DamageEventTarget, value)
        elseif GetPlayerId( GetOwningPlayer( udg_DamageEventSource ) ) < 4 and combat( udg_DamageEventSource, false, 0 ) then
            call AttackerTrack(udg_DamageEventSource, value)
        endif
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	endfunction

endscope
