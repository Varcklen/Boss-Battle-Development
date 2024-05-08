scope ExchangeBattleStart initializer init

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false or ExtraArenaGeneral_IsPvPFighter(BattleStart.TriggerUnit)
	endfunction

    private function action takes nothing returns nothing
		local integer index = BattleStart.GetDataInteger("index")
		local unit hero = BattleStart.GetDataUnit("caster")
		local player owner = BattleStart.GetDataPlayer("owner")
		local integer rand
		local item itemRemoved
		
		call SetUnitOwner( udg_artifzone[index], Player(PLAYER_NEUTRAL_PASSIVE), true )
	    // Держать вместе
	    set udg_auctionlogic[index] = false
	    if udg_auctionartif[index] != null then
	        if UnitInventoryCount( hero ) >= 6 then
	            set rand = GetRandomInt(0, 5)
	            set itemRemoved = UnitItemInSlot( hero, rand )
	            call DisplayTimedTextToPlayer( owner, 0, 0, 10., "|cffffcc00WARNING!|r There is not enough space in the inventory for the artifact from the exchanger. Artifact |cffffcc00" + GetItemName( itemRemoved ) + "|r was removed." )
	        	call RemoveItem( itemRemoved )
	        endif
	        call SetItemPosition( udg_auctionartif[index], GetUnitX(hero), GetUnitY(hero) )
	        call UnitAddItem( hero, udg_auctionartif[index] )
	        set udg_auctionartif[index] = null
	    endif
		
		set itemRemoved = null
		set hero = null
		set owner = null
	endfunction
    
    //===========================================================================
	private function init takes nothing returns nothing
		call BattleStart.AddListener(function action, function condition)
	endfunction
    
endscope