library ErrorMessageLib

	function ErrorMessage takes player owner, string message returns nothing
    	if GetLocalPlayer() == owner then
            call StartSound(gg_snd_Error)
        endif
        call DisplayTimedTextToPlayer( owner, 0, 0, 5, message )
    endfunction

endlibrary