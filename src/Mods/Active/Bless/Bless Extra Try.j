scope BlessExtraTry initializer init

	//===========================================================================
	public function Enable takes nothing returns nothing
        local integer i = 1
        loop
            exitwhen i > 4
            if GetPlayerSlotState(Player(i - 1)) == PLAYER_SLOT_STATE_PLAYING then
            	set udg_rollbase[i] = udg_rollbase[i] + 1
            endif
            set i = i + 1
        endloop
    endfunction
    
    public function Disable takes nothing returns nothing
		local integer i = 1
        loop
            exitwhen i > 4
            if GetPlayerSlotState(Player(i - 1)) == PLAYER_SLOT_STATE_PLAYING then
            	set udg_rollbase[i] = udg_rollbase[i] - 1
            endif
            set i = i + 1
        endloop
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope