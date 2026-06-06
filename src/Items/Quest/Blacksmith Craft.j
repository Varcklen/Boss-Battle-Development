scope BlacksmithCraft initializer init

	private function OnRewardRefuse takes nothing returns nothing
		local player playerUsed = Event_RewardsRefuse_Player
		local integer i = Event_RewardsRefuse_Index
		local unit hero = udg_hero[i]
		local integer s
		local item questItem
		local integer isCompleted
		
		/*call BJDebugMsg("OnRewardRefuse")
		
		if inv(hero, 'I0EU' ) > 0 then
			call BJDebugMsg("inv(hero, 'I0EU' ) > 0")
		endif
		if udg_ItemGetChoosed[i] == false then
			call BJDebugMsg("udg_ItemGetChoosed[i] == false")
		endif
		if udg_ItemGetActive[i] then
			call BJDebugMsg("udg_ItemGetActive[i]")
		endif*/
    
    	if inv(hero, 'I0EU' ) > 0 and udg_ItemGetChoosed[i] == false and udg_ItemGetActive[i] then
    		//call BJDebugMsg("Add!")
    	
    		set questItem = GetItemOfTypeFromUnitBJ( hero, 'I0EU')
	        set s = LoadInteger( udg_hash, GetHandleId(hero), StringHash( udg_QuestItemCode[14] ) ) + 1
	        call SaveInteger( udg_hash, GetHandleId(hero), StringHash( udg_QuestItemCode[14] ), s )
	        call BlzSetItemExtendedTooltip( questItem, words( hero, BlzGetItemDescription(questItem), "|cFF959697(", ")|r", I2S(s) + "/" + I2S(udg_QuestNum[14]) ) )
			call Quest_QuestCondition( hero, 'I0EU', 'I0EV', s, udg_QuestNum[14] )
	    endif
	    
	    set playerUsed = null
	    set hero = null
	    set questItem = null
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
    	call CreateEventTrigger( "Event_RewardsRefuse_Real", function OnRewardRefuse, null )
    endfunction
    
endscope