library FrameBarCreation

	globals
		private framehandle temp_Frame = null
	endglobals
	
	public function Create takes real x, real y, string text, string icon returns framehandle
	    local framehandle frame
	    
	    set frame = BlzCreateFrameByType( "BACKDROP", "", BlzGetOriginFrame( ORIGIN_FRAME_GAME_UI, 0), "StandardFrameTemplate", 0)
	    call BlzFrameSetSize( frame, 0.016, 0.016 ) 
	    call BlzFrameSetAbsPoint( frame, FRAMEPOINT_TOP, x, y ) //0.47, 0.589
	    call BlzFrameSetTexture( frame, icon, 0, true )
	
	    set temp_Frame = BlzCreateFrameByType( "TEXT", "", BlzGetOriginFrame( ORIGIN_FRAME_GAME_UI, 0), "StandardFrameTemplate", 0)
	    call BlzFrameSetSize( temp_Frame, 0.05, 0.015 ) 
	    call BlzFrameSetAbsPoint( temp_Frame, FRAMEPOINT_TOP, x + 0.04, y - 0.002 )//0.543, 0.578
	    call BlzFrameSetText(temp_Frame, text )
	    call BlzFrameSetTextAlignment( temp_Frame, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_RIGHT)
	    
	    set frame = null
	    return temp_Frame
	endfunction

endlibrary