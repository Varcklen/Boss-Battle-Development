library OutcastFrame initializer init requires HeroesTable

	globals
     	private framehandle outcastframe
     	private framehandle array outballframe
     	
     	public constant integer BALL_RED = 0
     	public constant integer BALL_GREEN = 1
     	public constant integer BALL_BLUE = 2
     	
     	public constant integer BALL_AMOUNT = 3
	endglobals
	
	public function SetVisibility takes unit hero, boolean isVisible returns nothing
		local player owner = HeroesTable_GetHeroMainOwner(hero)
		
		/*call BJDebugMsg("owner: " + GetPlayerName(owner))
		call BJDebugMsg("isVisible: " + B2S(isVisible))*/
		
		if GetLocalPlayer() == owner then
			call BlzFrameSetVisible( outcastframe, isVisible )
		endif
		
		set owner = null
	endfunction
	
	public function SetBallVisibility takes unit hero, integer ballType, boolean isVisible returns nothing
		local player owner = HeroesTable_GetHeroMainOwner(hero)
		
		if ballType < 0 or ballType >= BALL_AMOUNT then
			call BJDebugMsg("Error! OutcastFrame_SetBallVisibility: You're trying to get ball out of range: " + I2S(ballType) + " hero: " + GetUnitName(hero) + " isVisible: " + B2S(isVisible))
			return
		endif
		
		if GetLocalPlayer() == owner then
			call BlzFrameSetVisible( outballframe[ballType], isVisible )
		endif
		
		set owner = null
	endfunction
	
	private function action takes nothing returns nothing
		local integer i
	
	    set outcastframe = BlzCreateFrameByType("BACKDROP", "", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), "StandartFrameTemplate", 0)
	    call BlzFrameSetAbsPoint(outcastframe, FRAMEPOINT_LEFT, 0, 0.19)	
	    call BlzFrameSetSize(outcastframe, 0.24, 0.12)
	    call BlzFrameSetTexture(outcastframe, "outcastframe.blp", 0, true)
	    call BlzFrameSetLevel( outcastframe, -1 )
	    call BlzFrameSetVisible( outcastframe, false )
	
		set i = 0
		loop
			exitwhen i >= BALL_AMOUNT
			set outballframe[i] = BlzCreateFrameByType("BACKDROP", "", outcastframe, "StandartFrameTemplate", 0)
    		call BlzFrameSetAbsPoint(outballframe[i], FRAMEPOINT_CENTER, (0.06 * i) + 0.052, 0.20)	
			call BlzFrameSetSize(outballframe[i], 0.07, 0.07)
    		call BlzFrameSetVisible( outballframe[i], false )
			set i = i + 1
		endloop
	
	    call BlzFrameSetTexture(outballframe[0], "ballred.blp", 0, true)
	    call BlzFrameSetTexture(outballframe[1], "ballgreen.blp", 0, true)
	    call BlzFrameSetTexture(outballframe[2], "ballblue.blp", 0, true)
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set gg_trg_OutcastFrame = CreateTrigger(  )
	    call TriggerRegisterTimerExpireEvent( gg_trg_OutcastFrame, udg_StartTimer )
	    call TriggerAddAction( gg_trg_OutcastFrame, function action )
	endfunction

endlibrary