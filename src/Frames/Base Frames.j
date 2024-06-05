scope BaseFrames initializer init

	private function action takes nothing returns nothing
		//local framehandle parent = BlzGetFrameByName("EscMenuMainPanel", 0)
	    call BlzFrameSetVisible( BlzGetFrameByName("SaveGameButton", 0), false )
	    //call BlzFrameSetVisible( BlzGetFrameByName("LoadGameButton", 0), false )
	    
	    //call BlzFrameSetPoint(BlzGetFrameByName("SaveGameButton", 0), FRAMEPOINT_CENTER, parent, FRAMEPOINT_CENTER, 0.0, -0.204)
	    
	    //call BlzFrameSetAbsPoint(BlzGetFrameByName("OptionsButton", 0), FRAMEPOINT_CENTER, 0.1, 0.1)
	    
	    //set parent = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call TimerStart( CreateTimer(), 0.2, false, function action )
	endfunction

endscope