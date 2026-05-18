library MessageLib

	function ErrorMessage takes player owner, string message returns nothing
    	if GetLocalPlayer() == owner then
            call StartSound(gg_snd_Error)
        endif
        call DisplayTimedTextToPlayer( owner, 0, 0, 5, message )
    endfunction
    
    function MessageShowInfo takes player user, string colorMessage, string message returns nothing
    	local string text = ""
    	
    	if colorMessage != null then
    		set text = text + "|cffffcc00" + colorMessage + "|r: "
    	endif
    	if message != null then
    		set text = text + message
    	endif
    	
        call DisplayTimedTextToPlayer( user, 0, 0, 10, text )
    endfunction

endlibrary