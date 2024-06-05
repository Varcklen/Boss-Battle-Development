scope ExtraArenaBattleChange initializer init

    private function BattleStart takes nothing returns nothing
    	call UnitRemoveAbility( udg_UNIT_CUTE_BOB, 'A08B' ) 
	    call UnitRemoveAbility( udg_UNIT_CUTE_BOB, 'A10O' ) 
	    call UnitRemoveAbility( udg_UNIT_CUTE_BOB, 'A10N' ) 
	    call UnitRemoveAbility( udg_UNIT_CUTE_BOB, 'A0JQ' )
	endfunction
    
    private function BaseCheck takes nothing returns boolean
    	return IsVictory == false and IsExtraArenasAutomatic == false and udg_Boss_LvL != 1
    endfunction
    
    private function BattleEnd takes nothing returns nothing
    	if IsDisabled_InfiniteArena == false /*and ExtraArenaNextLevel_HardcoreCheck(0)*/ and BaseCheck() then
	        call UnitAddAbility( udg_UNIT_CUTE_BOB, 'A08B' )
	    endif
    	if IsDisabled_OverlordArena == false /*and ExtraArenaNextLevel_HardcoreCheck(1)*/ and BaseCheck() then
	        call UnitAddAbility( udg_UNIT_CUTE_BOB, 'A0JQ' )
	    endif
	    if IsVictory == false then
	        if IsExtraArenasAutomatic then
	            call UnitAddAbility( udg_UNIT_CUTE_BOB, 'A10O' ) 
	        else
	            call UnitAddAbility( udg_UNIT_CUTE_BOB, 'A10N' ) 
	        endif
	    endif
	endfunction

	private function init takes nothing returns nothing
		call BattleStartGlobal.AddListener(function BattleStart, null)
		call BattleEndGlobal.AddListener(function BattleEnd, null)
	endfunction

endscope