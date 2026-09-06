scope CalculateDPS initializer init
	
	globals
	    private real array DPS_Per_Tick[5][11]//герой/позиция
	    private real array DPS[5]
	    
	    public trigger Trigger = null
	endglobals
	
	private function condition takes nothing returns boolean
	    return IsUnitInGroup(udg_DamageEventTarget, udg_Bosses)
	endfunction
	
	private function CalculateDPSForPlayer takes integer index returns nothing
		local integer k
		local integer columnPos = Multiboard_GetPlayerColumn(index)
	
		set udg_dpsnum[index] = udg_dpsnum[index] + 1
        if udg_dpsnum[index] > 10 then
            set udg_dpsnum[index] = 1
        endif
        set DPS_Per_Tick[index][udg_dpsnum[index]] = udg_DamageFight[index] - udg_dpslast[index]
        set udg_dpslast[index] = udg_DamageFight[index]
    
        set DPS[index] = 0
        set k = 1
        loop
            exitwhen k > 10
            set DPS[index] = DPS[index] + DPS_Per_Tick[index][k]
            set k = k + 1
        endloop
        set DPS[index] = DPS[index] / 10
        if DPS[index] > udg_DPSMax[index] then
            set udg_DPSMax[index] = DPS[index]
        endif
        call Multiboard_MultiSetValue( 8, columnPos, R2SI(DPS[index]) )
	endfunction
	
	private function CalculateDPS takes nothing returns nothing
		local integer i
	    
		set i = 1
        loop
            exitwhen i > 4
            if IsUnitAlive( udg_hero[i] ) and not( IsVictory ) then
                call CalculateDPSForPlayer(i)
            endif
            set i = i + 1
        endloop
	endfunction
	
	private function BossDamageCast takes nothing returns nothing
	    set udg_Info_Time = udg_Info_Time + 1
	    if udg_fightmod[0] == false or udg_fightmod[3] then
	    	call DestroyTimer( GetExpiredTimer() )
		else
	        call CalculateDPS()
	    endif
	endfunction
	
	private function action takes nothing returns nothing
	    call DisableTrigger( GetTriggeringTrigger() )
        
        set udg_Info_Time = 0
	    call TimerStart( CreateTimer(), 1, true, function BossDamageCast )
	    
	    if udg_fightmod[4] == false then
	        call CombatTimer_Launch()
	    endif
	endfunction
	
	//===========================================================================
	private function OnFightEnd takes nothing returns nothing
		local integer index = BattleEnd.GetDataInteger("index")
		local integer k
		
		if IsVictory then
            return
        endif
        
		set k = 1
	    loop
	        exitwhen k > 10
	        set DPS_Per_Tick[index][k] = 0
	        set k = k + 1
	    endloop
	    set udg_dpslast[index] = 0
	    set DPS[index] = 0
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	    call BattleEnd.AddListener(function OnFightEnd, null)
	endfunction

endscope