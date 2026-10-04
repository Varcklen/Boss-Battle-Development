scope CheatIndicator initializer init

	globals
		public trigger Trigger = null
	endglobals
	
	private function action takes nothing returns nothing			
		call BJDebugMsg("Indicators created.")
		
		//call IndicatorSystem_Create(INDICATOR_CIRCLE, GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]), 100, 10, null)
		call IndicatorSystem_Create(INDICATOR_CIRCLE, GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]), 100, 10, null)
		call IndicatorSystem_Create(INDICATOR_AIM, GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]), 100, 10, null)
		//call IndicatorSystem_Create(INDICATOR_CIRCLE, GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]), 200, 10, null)
		//call IndicatorSystem_Create(INDICATOR_CIRCLE, GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]), 300, 10, null)
		//call IndicatorSystem_Create(INDICATOR_CIRCLE, GetUnitX(udg_hero[1]), GetUnitY(udg_hero[1]), 400, 10, null)
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-indicator", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope