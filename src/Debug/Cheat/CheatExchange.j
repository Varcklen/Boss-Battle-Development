scope CheatExchange initializer init

	globals
		public trigger Trigger = null
	endglobals

	private function action takes nothing returns nothing
		call BJDebugMsg("Exchange setup.")
		set udg_artifzone[2] = gg_unit_ncp3_0068
		if udg_auctionartif[2] == null then
	    	set udg_auctionartif[2] = CreateItemLoc('I02A', GetUnitLoc(udg_artifzone[2]) )
    	endif
	    call SetUnitOwner( udg_artifzone[2], Player(0), true )
	    call SetItemPositionLoc( udg_auctionartif[2], GetUnitLoc(udg_artifzone[2]) )
	    set udg_auctionlogic[2] = true
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger()
	    call TriggerRegisterPlayerChatEvent( Trigger, Player(0), "-exchange", false )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope