scope DamageText initializer init

	globals
		private constant integer DAMAGE_DEALT_TO_INCREASE = 200
		private constant integer MIN_SIZE_TEXT = 8
		private constant integer MAX_SIZE_TEXT = 16
		
		private constant real DAMAGE_TEXT_DURATION = 1
		private constant real DAMAGE_TEXT_SPEED = 64
		private constant real DAMAGE_TEXT_ANGLE_MIN = 20
		private constant real DAMAGE_TEXT_ANGLE_MAX = 150
		
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
		return GetRandomReal( DAMAGE_TEXT_ANGLE_MIN, DAMAGE_TEXT_ANGLE_MAX )
	endfunction
	
	private function SetDamageText takes nothing returns nothing
		local real textSize = GetTextSize(udg_DamageEventAmount)
		local string damageText = R2SI(udg_DamageEventAmount)
		local string text = "|cf0"
		
        if udg_DamageEventType == udg_DamageTypeCriticalStrike then
            if udg_IsDamageSpell then
            	set text = text + "FF1765" + damageText
            else
            	set text = text + "FF0510" + damageText
            endif
            set text = text + "!"
        elseif udg_IsDamageSpell then
        	set text = text + "842aff" + damageText
        else
        	set text = text + "FFCC00" + damageText
        endif
        call textst( text, udg_DamageEventTarget, DAMAGE_TEXT_SPEED, GetTextMovementDegree(), textSize, DAMAGE_TEXT_DURATION )
    endfunction

	private function action takes nothing returns nothing
	    if udg_DamageEventType == udg_DamageTypeBlocked then
	        call textst( "|cf0FF0510miss!", udg_DamageEventTarget, 75, 90, 10, 1.5 )
	    elseif udg_DamageEventAmount >= 1 and ( GetPlayerController( GetOwningPlayer(udg_DamageEventTarget) ) != MAP_CONTROL_USER or ExtraArenaGeneral_IsPvPFighter(udg_DamageEventTarget) )  then
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