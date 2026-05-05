scope FancyDrink initializer init

	globals
		private constant integer ITEM_TYPE = 'IV01'
		private constant integer STAT_INCREASE = 12
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		local integer rand 
		local integer mainStat
		local integer k

		set mainStat = BlzGetUnitIntegerField(hero, UNIT_IF_PRIMARY_ATTRIBUTE) 
        if mainStat == 1 then
            call statst( hero, -STAT_INCREASE, STAT_INCREASE, STAT_INCREASE, 0, false )
        elseif mainStat == 2  then
            call statst( hero, STAT_INCREASE, STAT_INCREASE, -STAT_INCREASE, 0, false )
        elseif mainStat == 3  then
            call statst( hero, STAT_INCREASE, -STAT_INCREASE, STAT_INCREASE, 0, false )
        endif
        
        set k = GetPlayerId( GetOwningPlayer( hero ) ) + 1
        loop
	        set rand = GetRandomInt( 1, 8 ) //Only basic ones, so not udg_Database_NumberItems[13]
	        exitwhen udg_DB_Hero_SpecAb[rand] != udg_Ability_Uniq[k] and udg_DB_Hero_SpecAbPlus[rand] != udg_Ability_Uniq[k]
	    endloop
	    call NewUniques( hero, udg_DB_Hero_SpecAb[rand] )
		
		set hero = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope