library SetIconActivation

	function iconon takes integer index, string setType, string icon returns nothing
	    local integer cyclA = 0
	    
	    loop
	        exitwhen cyclA > 2
	        if udg_Multiboard_Sets[udg_Multiboard_Position[index] * 3 - 2 + cyclA] == null then
	            set udg_Multiboard_Sets[ udg_Multiboard_Position[index] * 3 - 2 + cyclA] = setType
	            call MultiSetIcon( udg_multi, udg_Multiboard_Position[index] * 3 - 1 + cyclA, 15, icon )
	            set cyclA = 2
	        endif
	        set cyclA = cyclA + 1
	    endloop
	endfunction
	
	function iconoff takes integer index, string setType returns nothing
	    local integer cyclA = 0
	    
	    loop
	        exitwhen cyclA > 2
	        if udg_logic[43] == false and udg_Multiboard_Sets[udg_Multiboard_Position[index] * 3 - 2 + cyclA] == setType then
	            set udg_Multiboard_Sets[udg_Multiboard_Position[index] * 3 - 2 + cyclA] = null
	            call MultiSetIcon( udg_multi, udg_Multiboard_Position[index] * 3 - 1 + cyclA, 15, "ReplaceableTextures\\CommandButtons\\BTNCancel.blp" )
	            set cyclA = 2
	        endif
	        set cyclA = cyclA + 1
	    endloop
	endfunction
	
	function Multiboard_Condition takes integer i returns boolean
		if udg_Multiboard_Sets[udg_Multiboard_Position[i] * 3] == null then
			return true
		elseif udg_Multiboard_Sets[udg_Multiboard_Position[i] * 3 - 1] == null then
			return true
		elseif udg_Multiboard_Sets[( udg_Multiboard_Position[i] * 3 ) - 2] == null then
			return true
		endif
	    return false
	endfunction


endlibrary