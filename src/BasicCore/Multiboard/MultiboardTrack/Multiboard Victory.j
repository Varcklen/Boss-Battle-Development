scope MultiboardVicroty initializer init
	
	private function action takes nothing returns nothing
		call Multiboard_MultiSetValue( 8, 1,  "Max damage" )
	    call Multiboard_MultiSetColor( 2, 4, 0.00, 0.00, 0.00, 100.00 )
	    call Multiboard_MultiSetColor( 2, 5, 0.00, 0.00, 0.00, 100.00 )
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_Victory", function action, null )
	endfunction
	
endscope