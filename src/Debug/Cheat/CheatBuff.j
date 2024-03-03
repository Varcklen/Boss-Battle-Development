scope CheatBuff initializer init

	globals
		trigger trig_CheatBuff = null
	endglobals

	private function action takes nothing returns nothing
	    local integer i = GetPlayerId(GetTriggerPlayer()) + 1
	    local unit hero = udg_hero[i]
	    
	    call BJDebugMsg("Hero Buffed.")
	    call BlzSetUnitBaseDamage( hero, BlzGetUnitBaseDamage(hero, 0) + 500, 0 )
	    call BlzSetUnitMaxHP( hero, BlzGetUnitMaxHP(hero) + 5000 )
	    call BlzSetUnitAttackCooldown( hero, 0.2, 0 )
	    call SetUnitMoveSpeed( hero, 522 )
	    
	    set hero = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local integer i = 0
	    set trig_CheatBuff = CreateTrigger(  )
	    call DisableTrigger( trig_CheatBuff )
	    loop
	        exitwhen i > 3
	            call TriggerRegisterPlayerChatEvent( trig_CheatBuff, Player(i), "-buff", true )
	        set i = i + 1
	    endloop
	    call TriggerAddAction( trig_CheatBuff, function action )
	endfunction

endscope