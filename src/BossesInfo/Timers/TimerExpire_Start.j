scope TimerExpireStart initializer init

	private function action takes nothing returns nothing
	    /*loop
	        exitwhen cyclA > 4
	        if GetPlayerSlotState(Player(cyclA - 1)) == PLAYER_SLOT_STATE_PLAYING and IsRewardExist(Player(cyclA - 1)) then
	            set cyclB = 0
	            loop
	                exitwhen cyclB > 2
	                call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", GetItemX( udg_item[( 3 * cyclA ) - cyclB] ), GetItemY( udg_item[( 3 * cyclA ) - cyclB] ) ) )
	                call RemoveItem( udg_item[( 3 * cyclA ) - cyclB] )
	                set udg_item[( 3 * cyclA ) - cyclB] = null
	                set cyclB = cyclB + 1
	            endloop
			    
	        endif
	        set cyclA = cyclA + 1
	    endloop*/
	    
	    call ItemRandomizerLib_AllRemoveRewards()
	    
	    if udg_worldmod[1] and udg_Boss_LvL == 2 then
			call BlzFrameSetVisible(fastvis, false)
			call BlzFrameSetVisible(fastbut, false)
	    endif
	    
	    set udg_Player_Readiness = udg_Heroes_Amount
	    call TriggerExecute( gg_trg_StartFight )
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trig = CreateTrigger(  )
	    call TriggerRegisterTimerExpireEvent( trig, OutOfCombatTimer_Timer )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope