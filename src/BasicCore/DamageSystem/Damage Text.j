scope DamageText initializer init

	globals
		private constant integer DAMAGE_DEALT_TO_INCREASE = 200
		private constant integer MIN_SIZE_TEXT = 8
		private constant integer MAX_SIZE_TEXT = 16
		
		private constant real CRIT_TEXT_SIZE_INCREASE = 1.25
	endglobals

	private function GetTextSize takes real damage returns real
		local integer sizeIncrease = R2I(damage)/DAMAGE_DEALT_TO_INCREASE
		local real size = MIN_SIZE_TEXT + sizeIncrease 
		
        if udg_DamageEventType == udg_DamageTypeCriticalStrike then
        	set size = size * CRIT_TEXT_SIZE_INCREASE
        endif
        
		return RMinBJ( size, MAX_SIZE_TEXT)
	endfunction
	
	private function GetTextMovementDegree takes nothing returns real
		return GetRandomReal( 20, 150 )
	endfunction
	
	private function SetDamageText takes nothing returns nothing
		local real textSize = GetTextSize(udg_DamageEventAmount)
		local string damageText = I2S(R2I(udg_DamageEventAmount))
		
        if udg_DamageEventType == udg_DamageTypeCriticalStrike then
            if udg_IsDamageSpell then
                call textst( "|cf0FF1765" + damageText + "!", udg_DamageEventTarget, 64, GetTextMovementDegree(), textSize, 1 )
            else
                call textst( "|cf0FF0510" + damageText + "!", udg_DamageEventTarget, 64, GetTextMovementDegree(), textSize, 1 )
            endif
        elseif udg_IsDamageSpell then
            call textst( "|cf07510FF" + damageText, udg_DamageEventTarget, 64, GetTextMovementDegree(), textSize, 1 )
        else
            call textst( "|cf0FFCC00" + damageText, udg_DamageEventTarget, 64, GetTextMovementDegree(), textSize, 1 )
        endif
    endfunction

	private function action takes nothing returns nothing
	    if udg_DamageEventType == udg_DamageTypeBlocked then
	        call textst( "|cf0FF0510miss!", udg_DamageEventTarget, 75, 90, 10, 1.5 )
	    elseif udg_DamageEventAmount >= 1 and ( GetPlayerController(GetOwningPlayer(udg_DamageEventTarget)) != MAP_CONTROL_USER or udg_DamageEventTarget == udg_unit[57] or udg_DamageEventTarget == udg_unit[58] )  then
	        call SetDamageText()
	    endif
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set gg_trg_Damage_Tag = CreateTrigger(  )
	    call TriggerRegisterVariableEvent( gg_trg_Damage_Tag, "udg_DamageEvent", EQUAL, 1.00 )
	    call TriggerAddAction( gg_trg_Damage_Tag, function action )
	endfunction

endscope