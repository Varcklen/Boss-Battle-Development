scope SetIconActivation

	globals
		private constant integer KEY_SET_LIMIT = StringHash("message_cooldown_set_limit")
		private integer array MultiboardSetType[5][3]
	endglobals

	function iconon takes integer index, integer setType, string icon returns nothing
	    local integer i
	    local integer columnPos = Multiboard_GetPlayerColumn(index)
	    
	    set i = 0
	    loop
	        exitwhen i > 2
	        if MultiboardSetType[index][i] == 0 then
	            set MultiboardSetType[index][i] = setType
	            call Multiboard_MultiSetIcon( 15, columnPos + i, icon )
	            exitwhen true
	        endif
	        set i = i + 1
	    endloop
	endfunction
	
	function iconoff takes integer index, integer setType returns nothing
	    local integer i = 0
	    local integer columnPos = Multiboard_GetPlayerColumn(index)
	    
	    loop
	        exitwhen i > 2
	        if MultiboardSetType[index][i] == setType then
	            set MultiboardSetType[index][i] = 0
	            call Multiboard_MultiSetIcon( 15, columnPos + i, "ReplaceableTextures\\CommandButtons\\BTNCancel.blp" )
	            exitwhen true
	        endif
	        set i = i + 1
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
	
	function Multiboard_Condition takes integer index returns boolean
		local integer i = 0

		loop
			exitwhen i > 2
			if MultiboardSetType[index][i] == 0 then
				return true
			endif
			set i = i + 1
		endloop
		call CheckLimitError(index)
		
	    return false
	endfunction


endscope