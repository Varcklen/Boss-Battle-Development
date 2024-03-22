scope Exchange3 initializer init
	
	globals
	    real Event_ItemExchange_Real = 0
	    item Event_ItemExchange_Item
	    item Event_ItemExchange_OldItem
	    unit Event_ItemExchange_Hero
	    unit Event_ItemExchange_Friend
	endglobals
	
	private function condition takes nothing returns boolean
	    return GetItemTypeId(GetManipulatedItem()) == 'I0BJ' or GetItemTypeId(GetManipulatedItem()) == 'I07Y'
	endfunction
	
	private function MakeExchange takes player owner, unit hero, integer index, player friendPlayer, unit friendHero, integer friendIndex returns nothing
		local item itemToGet = udg_auctionartif[friendIndex]
		local integer rand
		local item itemToLost
	
		call SetItemPosition( itemToGet, GetUnitX(hero), GetUnitY(hero))
        if UnitInventoryCount(hero) >= UnitInventorySize(hero) then
            set rand = GetRandomInt(0, 5)
            set itemToLost = UnitItemInSlot( hero, rand )
            call DisplayTimedTextToPlayer( owner, 0, 0, 10., "|cffffcc00WARNING!|r There is not enough space in the inventory to exchange. Artifact |cffffcc00" + GetItemName( itemToLost ) + "|r was removed." )
            call RemoveItem( itemToLost )
        endif
        
        set Event_ItemExchange_Hero = hero
        set Event_ItemExchange_Item = udg_auctionartif[friendIndex]
        
        set Event_ItemExchange_Friend = friendHero
        set Event_ItemExchange_OldItem = udg_auctionartif[index]
        
        set Event_ItemExchange_Real = 1.00
        set Event_ItemExchange_Real = 0.00
        
        set udg_auctionartif[friendIndex] = Event_ItemExchange_Item
        
        if udg_auctionartif[friendIndex] != null then
            call UnitAddItem( hero, udg_auctionartif[friendIndex] )
        endif
        
        set udg_auctionlogic[index] = false
        call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", hero, "origin" ) )
        call SetUnitOwner( udg_artifzone[index], Player(PLAYER_NEUTRAL_PASSIVE), true )
        
        call SetPlayerState( owner, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState( owner, PLAYER_STATE_RESOURCE_GOLD) - ExchangeCost)
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		local unit friendHero
		local player owner = GetOwningPlayer(hero)
		local player friendPlayer
	    local integer index = GetPlayerId(owner) + 1
	    local integer friendIndex = -1
	    local integer i 
	
	    set i = 0
	    loop
	        exitwhen i > 3 or friendIndex != -1
	        set friendPlayer = Player(i)
	        if GetOwningPlayer(udg_artifzone[index]) == friendPlayer then
	            set friendIndex = GetPlayerId(friendPlayer) + 1
	            set friendHero = udg_hero[friendIndex]
	        endif
	        set i = i + 1
	    endloop
	    
	    if friendIndex == -1 then
	    	call DisplayTimedTextToPlayer( owner, 0, 0, 5, "You don't exchange with anyone. Select an ally to exchange." )
	    	
	    	set friendPlayer = null
	    	set hero = null
	    	set owner = null
	    	return
	    endif
	    
	    if udg_auctionlogic[index] then
	        call DisplayTimedTextToPlayer( owner, 0, 0, 5, "You have already clicked |cffffcc00\"Make an Exchange\"|r. Wait for another player." )
	        
	        set friendHero = null
	        set friendPlayer = null
	    	set hero = null
	    	set owner = null
	    	return
	    endif
	    
	    if IsUnitLoaded( hero ) or IsUnitLoaded( friendHero ) then
	        call DisplayTimedTextToPlayer( owner, 0, 0, 5, "Get out of the vehicle to continue (another player too)." )
	        
	        set friendHero = null
	        set friendPlayer = null
	    	set hero = null
	    	set owner = null
	    	return
	    endif
	    
	    if udg_auctionartif[index] == null then
	        call DisplayTimedTextToPlayer( owner, 0, 0, 5., "You do not have an artifact in the exchanger." )
	        
	        set friendHero = null
	        set friendPlayer = null
	    	set hero = null
	    	set owner = null
	    	return
	    endif
	    
	    if udg_auctionartif[friendIndex] == null then
	        call DisplayTimedTextToPlayer( owner, 0, 0, 5, "The friend does not have the artifact in the exchanger." )
	        
	        set friendHero = null
	        set friendPlayer = null
	    	set hero = null
	    	set owner = null
	    	return
	    endif
	    
	    if GetPlayerState(owner, PLAYER_STATE_RESOURCE_GOLD) < ExchangeCost then
	    	call DisplayTimedTextToPlayer( owner, 0, 0, 5, "You don't have enough gold. You need " + I2S(ExchangeCost) + " gold." )
	        
	        set friendHero = null
	        set friendPlayer = null
	    	set hero = null
	    	set owner = null
	    	return
	    endif

        set udg_auctionlogic[index] = true
        if udg_auctionlogic[friendIndex] then
        	call MakeExchange( owner, hero, index, friendPlayer, friendHero, friendIndex )
        	call MakeExchange( friendPlayer, friendHero, friendIndex, owner, hero, index )
        	
        	set udg_auctionartif[index] = null
        	set udg_auctionartif[friendIndex] = null
        else
            call DisplayTimedTextToPlayer( owner, 0, 0, 5, "Wait for " + GetPlayerName(friendPlayer) + " player to click |cffffcc00\"Make an Exchange\"|r." )
            call DisplayTimedTextToPlayer( friendPlayer, 0, 0, 5, GetPlayerName(owner) + " player is ready to complete the exchange. Click |cffffcc00'Make an exchange'|r." )
        endif
	        
	    set friendHero = null
        set friendPlayer = null
    	set hero = null
    	set owner = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction
endscope