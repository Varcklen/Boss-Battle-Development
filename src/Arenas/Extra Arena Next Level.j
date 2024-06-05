library ExtraArenaNextLevel initializer init requires Multiboard, Trigger

	/*private function CheckArenaType takes integer arenaType returns boolean
		if arenaType == 0 then
			return IsDisabled_InfiniteArena == false
		elseif arenaType == 1 then
			return IsDisabled_OverlordArena == false
		endif
		call BJDebugMsg("Error! ExtraArenaNextLevel_CheckArenaType: wrong arenaType: " + I2S(arenaType))
		return false
	endfunction

	public function HardcoreCheck takes integer arenaType returns boolean
		return IsHardcoreEnabled == false or CheckArenaType(arenaType)
	endfunction*/

	/*private function IsAddAbility takes integer arenaType returns boolean
		return  //and HardcoreCheck(arenaType)
	endfunction*/

	private function SetGreenColorMulti takes integer slot returns nothing
		call MultiSetColor( udg_multi, slot, 2, 20, 100, 20, 25 )
	endfunction

	private function RefreshIA takes nothing returns nothing
		call SetGreenColorMulti(4)
        set udg_Arena_LvL[0] = 1
        
        if IsHardcoreEnabled then
        	return
        endif
        
        set IsDisabled_InfiniteArena = false
        if IsExtraArenasAutomatic == false then
            call UnitAddAbility(udg_UNIT_CUTE_BOB, 'A08B')
        endif
	endfunction
	
	private function RefreshOA takes nothing returns nothing
		call SetGreenColorMulti(5)
        set udg_Arena_LvL[1] = 1
        
        if IsHardcoreEnabled then
        	return
        endif
        
        set IsDisabled_OverlordArena = false 
        if IsExtraArenasAutomatic == false then
            call UnitAddAbility(udg_UNIT_CUTE_BOB, 'A0JQ')
        endif
	endfunction
	
	private function ArenaWarning takes integer slot, boolean booleanCheck returns nothing
		if booleanCheck then
            call MultiSetColor( udg_multi, slot, 2, 100, 100, 20, 25 )
        endif
	endfunction

	private function action takes nothing returns nothing
	    if udg_Boss_LvL == 2 then
	    	call SetGreenColorMulti(4)
	    	call SetGreenColorMulti(5)
	    elseif udg_Boss_LvL == 4 then
	    	call ArenaWarning(4, IsDisabled_InfiniteArena == false)
	    elseif udg_Boss_LvL == 5 then
	        call RefreshIA()
	    elseif udg_Boss_LvL == 6 then
	    	call ArenaWarning(5, IsDisabled_OverlordArena == false)
        elseif udg_Boss_LvL == 7 then
	        call RefreshOA()
	    elseif udg_Boss_LvL == 10 then
	    	call ArenaWarning(4, IsDisabled_InfiniteArena == false)
	    	call ArenaWarning(5, IsDisabled_OverlordArena == false)
	    endif
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateEventTrigger( "Event_MainBattleWin", function action, null )
	endfunction

endlibrary