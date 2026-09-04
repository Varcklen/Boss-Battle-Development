library SetIconActivation requires Multiboard

	globals
		private constant integer KEY_SET_LIMIT = StringHash("message_cooldown_set_limit")
	endglobals

	function iconon takes integer index, string setType, string icon returns nothing
	    local integer cyclA = 0
	    
	    loop
	        exitwhen cyclA > 2
	        if udg_Multiboard_Sets[udg_Multiboard_Position[index] * 3 - 2 + cyclA] == null then
	            set udg_Multiboard_Sets[ udg_Multiboard_Position[index] * 3 - 2 + cyclA] = setType
	            call Multiboard_MultiSetIcon( udg_multi, 15, udg_Multiboard_Position[index] * 3 - 1 + cyclA, icon )
	            set cyclA = 2
	        endif
	        set cyclA = cyclA + 1
	    endloop
	endfunction
	
	function iconoff takes integer index, string setType returns nothing
	    local integer cyclA = 0
	    
	    loop
	        exitwhen cyclA > 2
	        if IsVictory == false and udg_Multiboard_Sets[udg_Multiboard_Position[index] * 3 - 2 + cyclA] == setType then
	            set udg_Multiboard_Sets[udg_Multiboard_Position[index] * 3 - 2 + cyclA] = null
	            call Multiboard_MultiSetIcon( udg_multi, 15, udg_Multiboard_Position[index] * 3 - 1 + cyclA, "ReplaceableTextures\\CommandButtons\\BTNCancel.blp" )
	            set cyclA = 2
	        endif
	        set cyclA = cyclA + 1
	    endloop
	endfunction
	
	private function EndCooldown takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer( ) )
    	local integer i = LoadInteger( udg_hash, id, KEY_SET_LIMIT )
	
		call SaveBoolean(udg_hash, i, KEY_SET_LIMIT, false )
	endfunction
	
	private function CheckLimitError takes integer i returns nothing
		local integer id
		local timer timerUsed
	
		if LoadBoolean(udg_hash, i, KEY_SET_LIMIT ) then
			return
		endif
		call ErrorMessage( Player(i-1), "A hero cannot have more than three sets.")
		call SaveBoolean(udg_hash, i, KEY_SET_LIMIT, true )
		
		set timerUsed = CreateTimer()
		call SaveTimerHandle( udg_hash, i, KEY_SET_LIMIT, timerUsed )
		call SaveInteger( udg_hash, GetHandleId(timerUsed), KEY_SET_LIMIT, i )
	    call TimerStart( timerUsed, 5, false, function EndCooldown )
	    
	    set timerUsed = null
	endfunction
	
	function Multiboard_Condition takes integer i returns boolean
		if udg_Multiboard_Sets[udg_Multiboard_Position[i] * 3] == null then
			return true
		elseif udg_Multiboard_Sets[udg_Multiboard_Position[i] * 3 - 1] == null then
			return true
		elseif udg_Multiboard_Sets[( udg_Multiboard_Position[i] * 3 ) - 2] == null then
			return true
		endif
		call CheckLimitError(i)
		
	    return false
	endfunction


endlibrary