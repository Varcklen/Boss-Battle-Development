scope CheatSets initializer init

	globals
		public trigger Trigger = null
	endglobals

	private function action takes nothing returns nothing
		local integer i
		local integer iMax
		
		call BJDebugMsg("=========================")
		call BJDebugMsg("Result:")
		set i = 1
		loop
			exitwhen i > SETS_COUNT
			call BJDebugMsg( "|cffffcc00" + SetCount_GetSetName(i) + ":|r " + I2S( SetCount_GetPieces(udg_hero[1], i) ) )
			set i = i + 1
		endloop
		
		call BJDebugMsg("------------------------")
		call BJDebugMsg("Tags:")
		set i = 1
		set iMax = TagSystem_GetTagsMax()
		loop
			exitwhen i > iMax
			call BJDebugMsg( "|cffffcc00" + TagSystem_GetTagData(i).Name + ":|r " + I2S( TagSystem_GetInventoryAmountOfTagItems(udg_hero[1], i) ) )
			set i = i + 1
		endloop
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-sets", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope