library PotionShopUI initializer init requires TextLib, PotionShopDatabase

    globals 
        private constant integer ROWS = 4
        private constant integer COLUMNS = 3
        private constant real SPACE_LINE = 0.06 
    
        private framehandle Backdrop = null 
        private framehandle CloseButton = null 
        private framehandle CloseBackdrop = null  
    endglobals 
    
    private function IsInvalidToBuy takes player triggerPlayer, unit hero, integer cost, integer itemType returns boolean
		if GetPlayerState(triggerPlayer, PLAYER_STATE_RESOURCE_GOLD) < cost then
			call ErrorMessage(triggerPlayer, "You can't purchase the potion. You don't have enough gold.")
			return true
		elseif ItemManipulation_IsInventoryFull(hero) and inv(hero, itemType) == 0 then
			call ErrorMessage(triggerPlayer, "You can't purchase the potion. Your inventory is full.")
			return true
		elseif hero == null then
			return true
		endif
	 	return false
	endfunction
	
	private function GetItemSlot takes unit hero, item itemFound returns integer
		local integer i = 0
		loop
			exitwhen i > 5
			if UnitItemInSlot(hero, i) == itemFound then
				return i
			endif
			set i = i + 1
		endloop
		call BJDebugMsg("PotionShopUI_GetItemSlot: Error! Item not found in the slot! Hero: " + GetUnitName(hero) + ", Item: " + GetItemName(itemFound))
		return 0
	endfunction
    
    private function PotionClick takes nothing returns nothing 
    	local player triggerPlayer = GetTriggerPlayer()
	    local unit hero = udg_hero[GetPlayerId( triggerPlayer ) + 1]
    	local integer index = LoadInteger(udg_hash, GetHandleId(BlzGetTriggerFrame()), StringHash("potion_shop_button_index") )
    	local PotionSlot slot = PotionShopDatabase_Slot[index]
    	local integer potionType = slot.sizeType
    	local integer cost = PotionShopDatabase_PotionSizeCost[potionType]
    	local integer itemType = slot.itemId
    	local item itemFound
    	local integer itemSlot
    
        if GetLocalPlayer() == triggerPlayer then
            call BlzFrameSetVisible(BlzGetTriggerFrame(), false) 
            call BlzFrameSetVisible(BlzGetTriggerFrame(), true)
        endif
        
        if IsInvalidToBuy(triggerPlayer, hero, cost, itemType) then
			set triggerPlayer = null
	    	set hero = null
			return
		endif
		
		set itemFound = GetItemOfTypeFromUnitBJ( hero, itemType)
		if itemFound != null then
			call BlzSetItemIntegerFieldBJ( itemFound, ITEM_IF_NUMBER_OF_CHARGES, BlzGetItemIntegerField( itemFound, ITEM_IF_NUMBER_OF_CHARGES) + 1 )
			
			set itemSlot = GetItemSlot( hero, itemFound )
        	call UnitRemoveItem( hero, itemFound )
        	call UnitAddItem( hero, itemFound )
        	call UnitDropItemSlot( hero, itemFound, itemSlot )
		else
			call UnitAddItem( hero, CreateItem( itemType, GetUnitX(hero), GetUnitY(hero) ) )
		endif

        call SetPlayerState( triggerPlayer, PLAYER_STATE_RESOURCE_GOLD, IMaxBJ( 0, GetPlayerState(triggerPlayer, PLAYER_STATE_RESOURCE_GOLD) - cost ) )
        
        set triggerPlayer = null
	    set hero = null
	    set itemFound = null
    endfunction 
    
    // ====================================================
    public function ShowBackdrop takes player user, boolean toShow returns nothing 
        if GetLocalPlayer() == user then
            call BlzFrameSetVisible(Backdrop, toShow)
        endif
    endfunction 
     
    private function Close takes nothing returns nothing 
        if GetLocalPlayer() == GetTriggerPlayer() then
            call BlzFrameSetVisible( BlzGetTriggerFrame(),false)
            call BlzFrameSetVisible( BlzGetTriggerFrame(),true)
        endif
        
        call ShowBackdrop(GetTriggerPlayer(), false)
        //call BJDebugMsg("Close")
    endfunction 

	// ====================================================
    private function GetPotionCostText takes PotionSlot slotUsed returns string
    	local integer potionType = slotUsed.sizeType
    	local integer cost = PotionShopDatabase_PotionSizeCost[potionType]
        return I2S(cost) + " G"
    endfunction
    
    private function MakeShopButton takes integer row, integer column, integer number returns nothing
        local framehandle backdrop
        local framehandle buttonFrame
        local framehandle icon
        local framehandle textFrame
        local trigger trig
        local real x_tl
        local real x_br
        local real y_tl
        local real y_br
        local PotionSlot slot = PotionShopDatabase_Slot[number]
        local item it
        
        set it = CreateItem( slot.itemId, 0, 0 )
        
        //Backdrop
        set x_tl = 0.0125 + SPACE_LINE * ( row - 1 )
        set y_tl = -0.0148 - SPACE_LINE * ( column - 1 )
        
        set x_br = -0.19803 + SPACE_LINE * ( row - 1 )
        set y_br = 0.1316 - SPACE_LINE * ( column - 1 )
  
        set backdrop = BlzCreateFrameByType("FRAME", "BACKDROP", Backdrop, "", 1)
        call BlzFrameSetPoint(backdrop, FRAMEPOINT_TOPLEFT, Backdrop, FRAMEPOINT_TOPLEFT, x_tl, y_tl )
        call BlzFrameSetPoint(backdrop, FRAMEPOINT_BOTTOMRIGHT, Backdrop, FRAMEPOINT_BOTTOMRIGHT, x_br, y_br )
        
        //Button
        set buttonFrame = BlzCreateFrameByType("GLUEBUTTON", "", backdrop, "ScoreScreenTabButtonTemplate", 0)
        call BlzFrameSetPoint(buttonFrame, FRAMEPOINT_TOPLEFT, backdrop, FRAMEPOINT_TOPLEFT, 0.0075, 0.0)
        call BlzFrameSetPoint(buttonFrame, FRAMEPOINT_BOTTOMRIGHT, backdrop, FRAMEPOINT_BOTTOMRIGHT, -0.0075, 0.015)
        call SaveInteger(udg_hash, GetHandleId( buttonFrame ), StringHash("potion_shop_button_index"), number )

        set icon = BlzCreateFrameByType("BACKDROP", "BackdropPSSlotButton1", buttonFrame, "", 0)
        call BlzFrameSetAllPoints(icon, buttonFrame)
        call BlzFrameSetTexture(icon, BlzGetItemIconPath(it), 0, true)
        
        set trig = CreateTrigger() 
        call BlzTriggerRegisterFrameEvent(trig, buttonFrame, FRAMEEVENT_CONTROL_CLICK) 
        call TriggerAddAction(trig, function PotionClick) 
         
        call SetStableTool( buttonFrame, GetItemName(it), BlzGetItemDescription(it) )

        //TextFrame
        set textFrame = BlzCreateFrameByType("TEXT", "name", backdrop, "", 0)
        call BlzFrameSetSize(textFrame, 0.06, 0.015)
        call BlzFrameSetPoint( textFrame, FRAMEPOINT_BOTTOM, backdrop, FRAMEPOINT_BOTTOM, 0, 0 )
        call BlzFrameSetText(textFrame, GetPotionCostText(slot) )
        call BlzFrameSetScale(textFrame, 1.0)
        call BlzFrameSetTextAlignment(textFrame, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_MIDDLE)
    
    	call RemoveItem(it)
    
        set backdrop = null
        set buttonFrame = null
        set icon = null
        set textFrame = null
        set trig = null
        set it = null
    endfunction
     
    private function Start takes nothing returns nothing 
        local trigger trig = null
        local integer i
        local integer k
        local integer number

        //Backdrop
        set Backdrop = BlzCreateFrame("QuestButtonBaseTemplate", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        call BlzFrameSetSize( Backdrop, 0.27, 0.205 )
        call BlzFrameSetAbsPoint(Backdrop, FRAMEPOINT_TOPRIGHT, 0.75, 0.53)
        call BlzFrameSetVisible(Backdrop, false) 

        //Close Button
        set CloseButton = BlzCreateFrameByType("GLUEBUTTON", "", Backdrop, "ScoreScreenTabButtonTemplate", 0)
        call BlzFrameSetSize( CloseButton, 0.02, 0.02 )
        call BlzFrameSetPoint( CloseButton, FRAMEPOINT_CENTER, Backdrop, FRAMEPOINT_TOPRIGHT, -0.01, -0.01 )
        
        set CloseBackdrop = BlzCreateFrameByType("BACKDROP", "BackdropPotionShopClose", CloseButton, "", 0)
        call BlzFrameSetAllPoints(CloseBackdrop, CloseButton)
        call BlzFrameSetTexture(CloseBackdrop, "war3mapImported\\BTNExit.blp", 0, true)
        set trig = CreateTrigger() 
        
        call BlzTriggerRegisterFrameEvent(trig, CloseButton, FRAMEEVENT_CONTROL_CLICK) 
        call TriggerAddAction(trig, function Close) 

        //ShopSlots
        set i = 1
        set number = 0
        loop
            exitwhen i > COLUMNS
            set k = 1
            loop
                exitwhen k > ROWS
                call MakeShopButton(k, i, number)
                set number = number + 1
                set k = k + 1
            endloop
            set i = i + 1
        endloop
        
        set trig = null
    endfunction 
    
    // ====================================================
    private function OnBattleStartGlobal takes nothing returns nothing 
        call BlzFrameSetVisible(Backdrop, false)
    endfunction 

    // ====================================================
    private function init takes nothing returns nothing 
    	call TimerStart( CreateTimer(), 0.1, false, function Start )
    	call BattleStartGlobal.AddListener(function OnBattleStartGlobal, null)
	endfunction

endlibrary