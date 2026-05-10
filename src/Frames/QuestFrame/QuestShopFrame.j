scope QuestShopFrame initializer init

	globals
	    framehandle quartback
	    framehandle quartbut
		framehandle array quartart
	    framehandle array quarticon
	    
	    private constant integer QUEST_AMOUNT = 12
	    private constant integer GOLD_COST = 100
	endglobals
	
	private function ButtonExitGuild takes nothing returns nothing
	    if GetLocalPlayer() == GetTriggerPlayer() then
	        call BlzFrameSetVisible( quartback,false)
		endif
	endfunction
	
	private function IsInvalidToBuy takes player triggerPlayer, unit hero, integer index returns boolean
		if GetPlayerState(triggerPlayer, PLAYER_STATE_RESOURCE_GOLD) < GOLD_COST then
			call ErrorMessage(triggerPlayer, "You can't purchase the quest. You don't have enough gold.")
			return true
		elseif hero == null then
			return true
		elseif ItemManipulation_IsInventoryFull(hero) then
			call ErrorMessage(triggerPlayer, "You can't purchase the quest. Your inventory is full.")
			return true
		elseif udg_QuestLimit[index] then
			return true
		endif
	 	return false
	endfunction

	private function QuartBuy takes nothing returns nothing
	    local player triggerPlayer = GetTriggerPlayer()
	    local integer index = GetPlayerId( triggerPlayer ) + 1
	    local unit hero = udg_hero[index]
	    local integer questIndex = LoadInteger(udg_hash, GetHandleId(BlzGetTriggerFrame()), StringHash("quest_sell_button_item_index") )
	    
	    if GetLocalPlayer() == triggerPlayer then
	        call BlzFrameSetVisible( BlzGetTriggerFrame(),false)
			call BlzFrameSetVisible( BlzGetTriggerFrame(),true)
		endif
		
		if IsInvalidToBuy(triggerPlayer, hero, index) then
			set triggerPlayer = null
	    	set hero = null
			return
		endif
		
		//call BJDebugMsg("questIndex: " + I2S(questIndex))

        call BlzFrameSetVisible( quartart[questIndex],false)
        call BlzFrameSetVisible( quarticon[questIndex],false)
        if inv(hero, udg_QuestItem[questIndex]) == 0 then
            call UnitAddItem( hero, CreateItem( udg_QuestItem[questIndex], GetUnitX(hero), GetUnitY(hero) ) )
            set udg_QuestLimit[index] = true
            call SetPlayerState( triggerPlayer, PLAYER_STATE_RESOURCE_GOLD, IMaxBJ( 0, GetPlayerState(triggerPlayer, PLAYER_STATE_RESOURCE_GOLD) - GOLD_COST ) )
            if GetLocalPlayer() == triggerPlayer then
                call BlzFrameSetVisible( quartback, false )
            endif
        endif
	    
	    set triggerPlayer = null
	    set hero = null
	endfunction
	
	private function SetQuestSellButton takes real width, integer index, ListInt possibleQuests, integer positionIndex returns nothing
		local trigger trig
		local item it
		local integer questIndex = possibleQuests.GetRandomCellAndRemove()
	
        set it = CreateItem(udg_QuestItem[questIndex], 0, 0 )
        
        //call BJDebugMsg("index: " + I2S(index))
        //call BJDebugMsg("questIndex: " + I2S(questIndex))
        
        set quarticon[index] = BlzCreateFrameByType("BACKDROP", "", quartback, "StandartFrameTemplate", 0)
        call BlzFrameSetSize(quarticon[index], 0.04, 0.04)
        call BlzFrameSetPoint( quarticon[index], FRAMEPOINT_CENTER, quartback, FRAMEPOINT_TOPLEFT, positionIndex * 0.04, -0.04+width )
        call BlzFrameSetTexture(quarticon[index], udg_QuestItemString[questIndex], 0, true)
        
        set quartart[index] = BlzCreateFrameByType("GLUEBUTTON", "", quartback, "ScoreScreenTabButtonTemplate", 0)
        call BlzFrameSetSize( quartart[index], 0.04, 0.04 )
        call BlzFrameSetPoint( quartart[index], FRAMEPOINT_CENTER, quarticon[index], FRAMEPOINT_CENTER, 0, 0 )
        call SaveInteger(udg_hash, GetHandleId(quartart[index]), StringHash("quest_sell_button_item_index"), questIndex)
        
        set trig = CreateTrigger()
        call BlzTriggerRegisterFrameEvent(trig, quartart[index], FRAMEEVENT_CONTROL_CLICK)
        call TriggerAddAction(trig, function QuartBuy)
        
        call SetStableTool( quartart[index], GetItemName(it), BlzGetItemDescription(it) )
        
        call RemoveItem(it)
        
        set it = null
        set trig = null
	endfunction
	
	private function start takes nothing returns nothing
		local trigger trig
	    local framehandle frame
	    local integer i
	    local integer positionIndex
	    local real width
	    local real height
	    local ListInt possibleQuests = ListInt.create()
	    
	    set quartback = BlzCreateFrame("QuestButtonBaseTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0), 0, 0)
	    call BlzFrameSetAbsPoint(quartback, FRAMEPOINT_TOPRIGHT, 0.75, 0.53)
	    call BlzFrameSetVisible( quartback, false )
	    call BlzFrameSetLevel( quartback, -1 )
	    
	    set frame = BlzCreateFrameByType("TEXT", "", quartback, "StandartFrameTemplate", 0)
		call BlzFrameSetSize( frame, 0.25, 0.03 )
		call BlzFrameSetPoint(frame, FRAMEPOINT_BOTTOMLEFT, quartback, FRAMEPOINT_BOTTOMLEFT, 0.01,0.005) 
		call BlzFrameSetText( frame, "|cffffcc00Cost:|r "+ I2S(GOLD_COST) +" gold|n|cffffcc00You can choose only 1 quest.|r" )
	    
	    set frame = BlzCreateFrameByType("BACKDROP", "", quartback, "StandartFrameTemplate", 0)
	    call BlzFrameSetSize(frame, 0.022, 0.022)
	    call BlzFrameSetPoint( frame, FRAMEPOINT_CENTER, quartback, FRAMEPOINT_TOPRIGHT, -0.01, -0.01 )
	    call BlzFrameSetTexture(frame, "war3mapImported\\BTNExit.blp", 0, true)
	    
	    set quartbut = BlzCreateFrameByType("GLUEBUTTON", "", quartback, "ScoreScreenTabButtonTemplate", 0)
		call BlzFrameSetSize( quartbut, 0.025, 0.025 )
		call BlzFrameSetPoint( quartbut, FRAMEPOINT_CENTER, frame, FRAMEPOINT_CENTER, 0, 0 )
	    
	    set trig = CreateTrigger()
		call BlzTriggerRegisterFrameEvent(trig, quartbut, FRAMEEVENT_CONTROL_CLICK)
		call TriggerAddAction(trig, function ButtonExitGuild)
	    
	    set i = 1
	    loop
	        exitwhen i > udg_QuestItemNum
	        call possibleQuests.Add(i)
	    	set i = i + 1
	    endloop
	    
	    set i = 1
	    set positionIndex = 0 
	    set width = 0
	    set height = 0
	    loop
	        exitwhen i > QUEST_AMOUNT
	        set positionIndex = positionIndex + 1
	        if positionIndex > 4 then
	            set positionIndex = 1
	            set width = width - 0.04
	            set height = height + 0.04
	        endif
	        
	        call SetQuestSellButton(width, i, possibleQuests, positionIndex)
	        set i = i + 1
	    endloop
	    
	    call BlzFrameSetSize(quartback, 0.2, 0.1+height)
	    call possibleQuests.destroy()
	    
		set trig = null
	    set frame = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterTimerExpireEvent( trig, udg_StartTimer )
	    call TriggerAddAction( trig, function start )
	    set trig = null
	endfunction

endscope