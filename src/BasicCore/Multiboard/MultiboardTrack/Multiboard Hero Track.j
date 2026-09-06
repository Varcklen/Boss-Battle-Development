scope MultiboardHeroTrack initializer init
	
	private function HeroChosen takes nothing returns nothing
		local player owner = Event_HeroChoose_Player
		local integer index = GetPlayerId(owner) + 1
		local integer columnPos = Multiboard_GetPlayerColumn(index)
		local integer heroKey = udg_HeroNum[index]
	
		call Multiboard_MultiSetIcon( 3, columnPos, udg_DB_Hero_Icon[heroKey] )
		
		set owner = null
	endfunction
	
	private function HeroRepick takes nothing returns nothing
		local player owner = Event_HeroRepick_Player
		local integer index = GetPlayerId(owner) + 1
		local integer columnPos = Multiboard_GetPlayerColumn(index)

		call Multiboard_MultiSetIcon( 3, columnPos, "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOn.blp" )
		
		set owner = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call CreateEventTrigger( "Event_HeroChoose_Real", function HeroChosen, null )
		call CreateEventTrigger( "Event_HeroRepick_Real", function HeroChosen, null )
	endfunction
	
endscope