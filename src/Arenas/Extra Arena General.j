library ExtraArenaGeneral requires ItemRandomizerLib

	public function ReviveHeroes takes nothing returns nothing
	    local unit hero
	    local real locX
	    local real locY
	    local player owner
	    local integer i
		
		set i = 1
		loop
	        exitwhen i > PLAYERS_LIMIT
	        set owner = Player(i - 1)
	        if GetPlayerSlotState(owner) == PLAYER_SLOT_STATE_PLAYING then
	            set hero = udg_hero[i]
	            set locX = GetLocationX( ExtraArenaSpawn[i] )
	            set locY = GetLocationY( ExtraArenaSpawn[i] )
	            
	            call ReviveHero( hero, locX, locY, true )
	            call SetUnitPosition( hero, locX, locY )
	            call SetUnitFacing( hero, 270 )
	            if GetLocalPlayer() == owner then
	                call PanCameraToTimed(locX, locY, 0)
	            endif
	        endif
	        set i = i + 1
	    endloop
	    
	    set owner = null
	    set hero = null
	endfunction
	
	public function MoveHeroesIntoArena takes nothing returns nothing
		local integer i
		local player owner
		local unit hero
		local real x
		local real y
		
		set i = 1
		loop
            exitwhen i > PLAYERS_LIMIT
            call CreateUnitAtLoc( Player(10), 'h00J', udg_point[i + 43], ( 90 * i ) - 45 )
            set owner = Player(i - 1)
            if GetPlayerSlotState(owner) == PLAYER_SLOT_STATE_PLAYING then
            	set x = GetLocationX(udg_point[i + 17])
            	set y = GetLocationY(udg_point[i + 17])
            	set hero = udg_hero[i]
            
                call SetUnitPosition( hero, x, y )
                call PanCameraToTimedForPlayer( owner, x, y, 0 )
                call DestroyEffect( AddSpecialEffect( "Void Teleport Caster.mdx" , x, y ) )
            endif
            set i = i + 1
        endloop
        
        set owner = null
        set hero = null
	endfunction
	
	public function RemovePortals takes nothing returns nothing
		local group g = CreateGroup()
	    local unit u
	    
	    set bj_livingPlayerUnitsTypeId = 'h00J'
	    call GroupEnumUnitsOfPlayer(g, Player( 10 ), filterLivingPlayerUnitsOfTypeId)
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        call RemoveUnit( u )
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    call DestroyGroup( g )
	    set u = null
	    set g = null
	endfunction
	
	public function PingPlayerWithRewards takes nothing returns nothing
		local integer i 
		local player owner
		
		set i = 0
        loop
            exitwhen i >= PLAYERS_LIMIT
            set owner = Player(i)
            if GetPlayerSlotState(owner) == PLAYER_SLOT_STATE_PLAYING and ItemRandomizerLib_IsRewardExist(owner) then
                call PingMinimapLocForForceEx( bj_FORCE_ALL_PLAYERS, udg_itemcentr[i * 3 + 1], 5, bj_MINIMAPPINGSTYLE_ATTACK, 50.00, 100.00, 50.00 )
            endif
            set i = i + 1
        endloop
        set owner = null
	endfunction
	
	private function SpawnRune takes nothing returns nothing
        set bj_lastCreatedItem = CreateItem( 'I03J' + GetRandomInt(1, 6), GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect)), GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect)) )
        call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", GetItemX( bj_lastCreatedItem ), GetItemY( bj_lastCreatedItem ) ) )
    endfunction
	
	public function CreateRunes takes nothing returns nothing
		call SpawnRune()
    endfunction

endlibrary