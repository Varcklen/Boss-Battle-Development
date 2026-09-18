scope Exchange1 initializer init

    globals
        integer array PutInExcanger[6]
        
        integer ExchangeCost = 125
    endglobals

    function Trig_Auction1_Conditions takes nothing returns boolean
        local integer i = 0
        local integer itemId = GetItemTypeId(GetManipulatedItem())
        
        loop
            exitwhen i > 5
            if itemId == PutInExcanger[i] then
                return true
            endif
            set i = i + 1
        endloop
        return false
    endfunction
    
    function GetSlotUsed takes nothing returns integer
        local integer i = 0
        local integer itemId = GetItemTypeId(GetManipulatedItem())
        
        loop
            exitwhen i > 5
            if itemId == PutInExcanger[i] then
                return i
            endif
            set i = i + 1
        endloop
        return -1
    endfunction

    private function Reset takes unit hero returns nothing
    	local integer i = 1
    	
        loop
            exitwhen i > PLAYERS_LIMIT
            if GetOwningPlayer( udg_artifzone[i] ) == GetOwningPlayer( hero ) and udg_auctionlogic[i] then
                set udg_auctionlogic[i] = false
                call SetUnitOwner( udg_artifzone[i], Player(PLAYER_NEUTRAL_PASSIVE), true )
                call DisplayTimedTextToPlayer( Player(i - 1), 0, 0, 5, "|cffffcc00Exchanger:|r color reset. Another player posted an artifact from the exchanger." )
            endif
            set i = i + 1
        endloop
    endfunction
    
    private function RewardAttention takes unit hero, player owner returns nothing
    	local integer  j = ( GetPlayerId(owner) * 3 ) + 2
    	
	    call PanCameraToTimedLocForPlayer(owner, udg_itemcentr[j], 0.5 )
	    call PingMinimapLocForForceEx( GetForceOfPlayer(owner), udg_itemcentr[j], 10., bj_MINIMAPPINGSTYLE_FLASHY, 100, 0, 0 )
    endfunction
    
    /*private function PutItem takes unit hero, integer slotUsed returns nothing

    	local item itemUsed = GetManipulatedItem()
    	local integer itemType = GetItemTypeId(itemUsed)
    	local item itemSlot
    	
            if itemType == PutInExcanger[i] and itemSlot != null then
                
            endif
            set i = i + 1
        endloop
        
        set itemUsed = null
        set itemSlot = null
    endfunction*/

    private function Trig_Auction1_Actions takes nothing returns nothing
        local unit hero = GetManipulatingUnit()
        local item oldItem = null
        local item currentItem = null
        local player owner = GetOwningPlayer(hero)
        local integer index = GetPlayerId(owner) + 1
        local integer slotUsed
        
        set slotUsed = GetSlotUsed()
        set currentItem = UnitItemInSlot(hero, slotUsed)

        //if GetPlayerState(owner, PLAYER_STATE_RESOURCE_GOLD) >= ExchangeCost then
        
        if ItemRandomizerLib_IsRewardExist(owner) then
        	call RewardAttention(hero, owner)
        	call DisplayTimedTextToPlayer( owner, 0, 0, 5, "Select an artifact in the preparatory room before starting the exchange." )
        	set hero = null
        	set owner = null
        	set currentItem = null
        	return
        endif
        
        if GetItemType(currentItem) == ITEM_TYPE_POWERUP then
            call DisplayTimedTextToPlayer(owner, 0, 0, 5, "Only artifacts can be exchanged.")
            set hero = null
        	set owner = null
        	set currentItem = null
        	return
        endif
        
        if GetItemTypeId(currentItem) == 'I05J' or GetItemTypeId(UnitItemInSlot(GetManipulatingUnit(), slotUsed)) == 'I030' then
            call DisplayTimedTextToPlayer(owner, 0, 0, 5, "This artifact cannot be put into the exchanger.")
            set hero = null
        	set owner = null
        	set currentItem = null
        	return
        endif
        
        if GetItemType(UnitItemInSlot(GetManipulatingUnit(), slotUsed)) == ITEM_TYPE_PURCHASABLE then
            call DisplayTimedTextToPlayer(owner, 0, 0, 5, "|cffffcc00Quests|r cannot be exchanged.")
            set hero = null
        	set owner = null
        	set currentItem = null
        	return
    	endif
    	
    	set udg_auctionlogic[index] = false
    	call Reset(hero)
    	
        if udg_auctionartif[index] != null then
            set oldItem = udg_auctionartif[index]
            call SetItemPosition( oldItem, GetUnitX(hero), GetUnitY(hero))
            set udg_auctionartif[index] = null
        endif
            
        //call PutItem(hero)
        set udg_auctionartif[index] = currentItem
        call SetItemPosition( currentItem, GetLocationX(udg_point[index]), GetLocationY(udg_point[index]))
        
        if oldItem != null and IsItemOwned( oldItem ) == false then
            call UnitAddItem( hero, oldItem )
        endif
        
        set hero = null
        set owner = null
        set oldItem = null
        set currentItem = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set gg_trg_Auction1 = CreateTrigger(  )
        call TriggerRegisterAnyUnitEventBJ( gg_trg_Auction1, EVENT_PLAYER_UNIT_PICKUP_ITEM ) 
        call TriggerAddCondition( gg_trg_Auction1, Condition( function Trig_Auction1_Conditions ) )
        call TriggerAddAction( gg_trg_Auction1, function Trig_Auction1_Actions )
        
        set PutInExcanger[0] = 'I0GX'
        set PutInExcanger[1] = 'I0GW'
        set PutInExcanger[2] = 'I0GV'
        set PutInExcanger[3] = 'I0GU'
        set PutInExcanger[4] = 'I0GT'
        set PutInExcanger[5] = 'I0GS'
    endfunction

endscope