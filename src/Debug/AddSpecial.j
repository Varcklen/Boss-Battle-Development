scope AddSpecial initializer init
	
	private function action takes nothing returns nothing
		call BJDebugMsg("Special Added")
		//call NewSpecial( udg_hero[1], 'AZ04' )
		call NewUniques( udg_hero[1], 'A0MW' )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterPlayerChatEvent( trig, Player(0), "-spec", true )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope