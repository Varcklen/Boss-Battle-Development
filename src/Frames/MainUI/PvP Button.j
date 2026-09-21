library PvPButton initializer init requires Trigger, SetStableToolLib

	globals
         real Event_PvPButtonClicked_Real
         player Event_PvPButtonClicked_Player

         private framehandle pvpbk
	endglobals
	
    private function PvPButton takes nothing returns nothing
        if GetLocalPlayer() == GetTriggerPlayer() then
            call BlzFrameSetVisible( pvpbk,false)
            call BlzFrameSetVisible( pvpbk,true)
        endif
        
        set Event_PvPButtonClicked_Player = GetTriggerPlayer() 
        set Event_PvPButtonClicked_Real = 0.00
        set Event_PvPButtonClicked_Real = 1.00
        set Event_PvPButtonClicked_Real = 0.00
    endfunction
    
    public function Get takes nothing returns framehandle
		return pvpbk
	endfunction
    
    //===========================================================================
    private function OnRewardRefuse_Condition takes nothing returns boolean
		return IsSinglePlayer == false and udg_number[69 + Event_RewardsRefuse_Index] > 0
	endfunction
	
	private function OnRewardRefuse takes nothing returns nothing
		if GetLocalPlayer() == Event_RewardsRefuse_Player then
			call BlzFrameSetVisible( pvpbk,true) 
        endif
	endfunction
	
	private function ButtonCondition takes player user returns boolean
		local integer index = GetPlayerId(user) + 1
		return IsSinglePlayer == false and udg_number[69 + index] > 0
	endfunction
	
	//===========================================================================
    private function EnableRefuseReward takes nothing returns nothing
    	local player user = Event_SpawnRewards_Player
    	local integer index = GetPlayerId(user) + 1
    
    	//call BJDebugMsg("udg_ItemGetActive[index]: " + B2S(udg_ItemGetActive[index]))
    	//call BJDebugMsg("EnableRefuseReward")
    
    	if udg_ItemGetActive[index] then
	        if GetLocalPlayer() == user then
	        	call BlzFrameSetVisible( pvpbk,false)
	            call BlzFrameSetVisible( sklbk, true )
	        endif
	    elseif udg_ItemGetActive[index] == false and ButtonCondition(user) then
	        if GetLocalPlayer() == user then
	            call BlzFrameSetVisible( pvpbk, true )
	        endif
	    endif

    	set user = null
    endfunction
	
	//===========================================================================
	public function CreateUI takes framehandle fon returns nothing
		local trigger trig
		local framehandle h
        local string text
	
		set pvpbk = BlzCreateFrameByType("BACKDROP", "", fon, "StandartFrameTemplate", 0)
        call BlzFrameSetSize(pvpbk, 0.04, 0.04)
        call BlzFrameSetTexture(pvpbk, "ReplaceableTextures\\CommandButtons\\BTNMassTeleport.blp", 0, true)
        call BlzFrameSetLevel( pvpbk, -1 )

        set h = BlzCreateFrameByType("GLUEBUTTON", "", pvpbk, "ScoreScreenTabButtonTemplate", 0)
        call BlzFrameSetSize( h, 0.04, 0.04 )
        call BlzFrameSetPoint( h, FRAMEPOINT_CENTER, fon, FRAMEPOINT_CENTER, 0.05, 0.0 )
        call BlzFrameSetPoint(pvpbk, FRAMEPOINT_CENTER, h, FRAMEPOINT_CENTER, 0.0,0.0)
        set trig = CreateTrigger()
        call BlzTriggerRegisterFrameEvent(trig, h, FRAMEEVENT_CONTROL_CLICK)
        call TriggerAddAction(trig, function PvPButton)

        set text = "You want to fight another player. When someone accepts your challenge, you'll be teleported to the arena for the battle."
        call SetStableTool( h, "Duel", text )
        
        call BlzFrameSetVisible( pvpbk, false )
        
        set trig = null
        set h = null
	endfunction
	
	//===========================================================================
    private function OnBattleEnd_Condition takes nothing returns boolean
		if IsSinglePlayer then
    		return false
    	endif
    	
    	if IsVictory then //Always shows if victory and not singleplayer
    		return true
    	endif
    	if udg_number[BattleEnd.GetDataInteger("index") + 69] <= 0 then
    		return false
    	endif
		return true
	endfunction
	
	private function OnBattleEnd takes nothing returns nothing
		local player user = BattleEnd.GetDataPlayer("owner")
	
		if GetLocalPlayer() == user then
            call BlzFrameSetVisible( pvpbk,true)
        endif
        
        set user = null
	endfunction
		
	//===========================================================================
	private function OnMatchEnd takes nothing returns nothing
        call BlzFrameSetVisible( pvpbk, false )
    endfunction
    
    private function OnFightStart takes nothing returns nothing
    	call BlzFrameSetTexture(pvpbk, "ReplaceableTextures\\CommandButtons\\BTNMassTeleport.blp", 0, true)
    	call BlzFrameSetVisible( pvpbk,false)
    endfunction
    
    private function OnPlayerLeave takes nothing returns nothing
    	if IsSinglePlayer then
            call BlzFrameSetVisible( pvpbk,false)
        endif
    endfunction
    
    private function OnRewardTaken takes nothing returns nothing
    	if ButtonCondition(Event_RewardTaken_Player) and GetLocalPlayer() == Event_RewardTaken_Player then
            call BlzFrameSetVisible( pvpbk,true)
        endif
    endfunction
    
    private function OnTimerExpire takes nothing returns nothing
		call BlzFrameSetVisible( pvpbk,false)
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
    	local trigger trig = CreateTrigger(  )
	    call TriggerRegisterTimerExpireEvent( trig, OutOfCombatTimer_TimerDisablePvP )
	    call TriggerAddAction( trig, function OnTimerExpire )
	    set trig = null
    
		call CreateEventTrigger( "Event_RewardsRefuse_Real", function OnRewardRefuse, function OnRewardRefuse_Condition )
		call CreateEventTrigger( "Event_SpawnRewards_Real", function EnableRefuseReward, null )
		
		call CreateEventTrigger( "Event_MatchEnd", function OnMatchEnd, null )
		call CreateEventTrigger( "udg_FightStartGlobal_Real", function OnFightStart, null )
		call CreateEventTrigger( "Event_PlayerLeave_Real", function OnPlayerLeave, null )
		call CreateEventTrigger( "Event_RewardTaken", function OnRewardTaken, null )
		
		call BattleEnd.AddListener(function OnBattleEnd, function OnBattleEnd_Condition)
	endfunction

endlibrary