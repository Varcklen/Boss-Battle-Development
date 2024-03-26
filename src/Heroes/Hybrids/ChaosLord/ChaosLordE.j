scope ChaosLordE initializer init

	globals
		private constant integer ABILITY_ID = 'A0LK'
	endglobals

	private function sheepCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "sheepmad" ) )
	    local rect r = LoadRectHandle( udg_hash, id, StringHash( "sheepm" ) )
	    
	    if not( udg_combatlogic[GetPlayerId( GetOwningPlayer( caster ) ) + 1] ) then
	        call DestroyTimer( GetExpiredTimer() )
	    else
	        set bj_lastCreatedUnit = CreateUnitAtLoc( GetOwningPlayer( caster ), ID_SHEEP, Location(GetRandomReal(GetRectMinX(r), GetRectMaxX(r)), GetRandomReal(GetRectMinY(r), GetRectMaxY(r))), GetRandomReal( 0, 360 ) )
	        call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )
	    endif
	    
	    set r = null
	    set caster = null
	endfunction
	
	private function RemorseCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "remmad" ) )
	    local integer lvl = LoadInteger( udg_hash, id, StringHash( "remmad" ) )
	    local group g = CreateGroup()
	    local unit u
	    
	    call GroupEnumUnitsInRect( g, udg_Boss_Rect, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if unitst( u, caster, "all" ) then
	            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl", GetUnitX( u ), GetUnitY( u ) ) )
	            call SetUnitState( u, UNIT_STATE_LIFE, RMaxBJ(0,GetUnitState( u, UNIT_STATE_LIFE) - ( GetUnitState( u, UNIT_STATE_MAX_LIFE) * (0.05*lvl) ) ) )
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    call DestroyGroup( g )
	    set g = null
	    set u = null
	    set caster = null
	endfunction
	
	private function madness takes unit caster, integer lvl returns nothing
	    local integer rand
	    local integer cyclA = 1
	    local integer cyclAEnd
	    local integer cyclB
	    local integer i
	    local integer id = GetHandleId( caster )
	    local string txt
	    local group g = CreateGroup()
	    local unit u
	
	    if not(udg_fightmod[3]) then
	        set rand = GetRandomInt( 1,10 )
	    else
	        set rand = GetRandomInt( 4,10 )
	    endif
	
	    if rand == 1 then
	        call textst( "|c00FF6000 Resurrection!", caster, 64, 90, 15, 3 )
	        if lvl == 1 or lvl == 2 then
	            set i = 1
	        elseif lvl == 3 or lvl == 4 then
	            set i = 2
	        elseif lvl == 5 then
	            set i = 3
	        endif
	        call RessurectionPoints( i, false )
	    elseif rand == 2 then
	        call textst( "|c00FF6000 Chests!", caster, 64, 90, 15, 3 )
	        set cyclA = 1
	        set cyclAEnd = lvl
	        loop
	            exitwhen cyclA > cyclAEnd
	            call CreateNUnitsAtLoc( 1, 'h01L', Player(PLAYER_NEUTRAL_AGGRESSIVE), GetRandomLocInRect(udg_Boss_Rect), 270 )
	            set cyclA = cyclA + 1
	        endloop
	    elseif rand == 3 then
	        call textst( "|c00FF6000 Legendary gifts!", caster, 64, 90, 15, 3 )
	        
	        set cyclB = 1
	        loop
	            exitwhen cyclB > 4
	            set cyclA = 1
	            set cyclAEnd = lvl
	            loop
	                exitwhen cyclA > cyclAEnd 
	                if GetUnitState( udg_hero[cyclB], UNIT_STATE_LIFE) > 0.405 then
	                    if UnitInventoryCount(udg_hero[cyclB]) < 6 then
	                        call ItemRandomizer( udg_hero[cyclB], "legendary" )
	                        call BlzSetItemExtendedTooltip( bj_lastCreatedItem, "|cffC71585Cursed|r|n" + BlzGetItemExtendedTooltip(bj_lastCreatedItem) ) // sadtwig
	                        //call BlzSetItemIconPath( bj_lastCreatedItem, "|cffC71585Cursed|r|n" + BlzGetItemExtendedTooltip(bj_lastCreatedItem) )
	                    else
	                        set cyclA = cyclAEnd
	                    endif
	                endif 
	                set cyclA = cyclA + 1
	            endloop
	            set cyclB = cyclB + 1
	        endloop
	    elseif rand == 4 then
	        call textst( "|c00FF6000 Wrath!", caster, 64, 90, 15, 3 )
	        call UnitAddAbility( caster, 'A0QM' )
	        call SetUnitAbilityLevel( caster, 'A0NB', lvl )
	    elseif rand == 5 then
	        call textst( "|c00FF6000 Remorse!", caster, 64, 90, 15, 3 )
	                
	        if LoadTimerHandle( udg_hash, id, StringHash( "remmad" ) ) == null  then
	            call SaveTimerHandle( udg_hash, id, StringHash( "remmad" ), CreateTimer() )
	        endif
	        set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "remmad" ) ) ) 
	        call SaveUnitHandle( udg_hash, id, StringHash( "remmad" ), caster )
	        call SaveInteger( udg_hash, id, StringHash( "remmad" ), lvl )
	        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "remmad" ) ), 1, false, function RemorseCast )
	    elseif rand == 6 then
	        call textst( "|c00FF6000 Apocalypse of Magic!", caster, 64, 90, 15, 3 )
	        set udg_logic[34] = true
	    elseif rand == 7 then
	        call textst( "|c00FF6000 Runes!", caster, 64, 90, 15, 3 )
	        if udg_fightmod[3] then
	            set i = 5
	        else
	            set i = 1
	        endif
	        set cyclAEnd = 7 * lvl
	        loop
	            exitwhen cyclA > cyclAEnd
	            call CreateItem( 'I03J' + GetRandomInt( i, 6 ), GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect)), GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect)) )
	            set cyclA = cyclA + 1
	        endloop
	    elseif rand == 8 then
	        call textst( "|c00FF6000 Superbot!", caster, 64, 90, 15, 3 )
	        if lvl == 1 or lvl == 2 then
	            set i = 1
	        elseif lvl == 3  then
	            set i = 2
	        elseif lvl == 4 then
	            set i = 3
	        elseif lvl == 5 then
	            set i = 4
	        endif
	        if i > udg_Heroes_Amount then
	            set i = udg_Heroes_Amount
	        endif
	        set g = DeathSystem_GetAliveHeroGroupCopy()
	        loop
	            set u = GroupPickRandomUnit(g)
	            exitwhen u == null
	            if i > 0 and GetUnitState( u, UNIT_STATE_LIFE) > 0.405 and IsUnitAlly( u, GetOwningPlayer( caster ) ) then
	                call Superbot( u )
	                set i = i - 1
	            endif
	            call GroupRemoveUnit(g,u)
	        endloop
	    elseif rand == 9 then
	        call textst( "|c00FF6000 Sheep landing!", caster, 64, 90, 15, 3 )
	        
	        if LoadTimerHandle( udg_hash, id, StringHash( "sheepmad" ) ) == null  then
	            call SaveTimerHandle( udg_hash, id, StringHash( "sheepmad" ), CreateTimer() )
	        endif
	        set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "sheepmad" ) ) ) 
	        call SaveUnitHandle( udg_hash, id, StringHash( "sheepmad" ), caster )
	        call SaveRectHandle( udg_hash, id, StringHash( "sheepm" ), udg_Boss_Rect )
	        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "sheepmad" ) ), 10/lvl, true, function sheepCast )
	    elseif rand == 10 then
	        call textst( "|c00FF6000 Tentacles!", caster, 64, 90, 15, 3 )
	        set cyclAEnd = 10 * lvl
	        loop
	            exitwhen cyclA > cyclAEnd
	            set bj_lastCreatedUnit = CreateUnitAtLoc( GetOwningPlayer( caster ), 'n03F', Location(GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect)), GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect))), 270 )
	            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )
	            set cyclA = cyclA + 1
	        endloop
	    endif
	    
	    call DestroyGroup( g )
	    set g = null
	    set u = null
	    set caster = null
	endfunction

	//===========================================================================
    private function condition takes nothing returns boolean
	    return GetUnitAbilityLevel( BattleStart.TriggerUnit, ABILITY_ID) > 0
	endfunction
	
	private function delay takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local unit caster = LoadUnitHandle( udg_hash, id, StringHash("chaos_lord_e_caster") )
		local integer level = GetUnitAbilityLevel( caster, ABILITY_ID)
		
		call madness( caster, level )
		call FlushChildHashtable( udg_hash, id )
		
		set caster = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = BattleStart.GetDataUnit("caster")
		local integer id
		
		set id = InvokeTimerWithUnit( caster, "chaos_lord_e", 0.5, false, function delay )
		call SaveUnitHandle( udg_hash, id, StringHash("chaos_lord_e_caster"), caster )
		
	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call BattleStart.AddListener(function action, function condition)
	endfunction

endscope