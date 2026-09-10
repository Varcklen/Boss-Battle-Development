library BattleStart requires DeathSystem, ResLib, Inventory, TimebonusLib, TimePlayLib
	
	globals
		integer Event_FightStart_Index
	
		real Event_FightStart_DelayUnit = 0
		unit Event_FightStart_DelayUnit_Hero
		integer Event_FightStart_DelayUnit_Index 
		player Event_FightStart_DelayUnit_Player
	endglobals
	
	function AllDeadIdol takes nothing returns boolean
	    local integer cyclA = 1
	    local integer i = 0
	    local boolean l = false
	    
	    loop
	        exitwhen cyclA > 4
	        if GetUnitState(udg_hero[cyclA], UNIT_STATE_LIFE) <= 0.405 then
	            set i = i + 1
	        endif
	        set cyclA = cyclA + 1
	    endloop
	    if i >= 3 then
	        set l = true
	    endif
	    return l
	endfunction
	
	function PigSum takes nothing returns nothing
	    set bj_lastCreatedUnit = CreateUnitAtLoc( Player(4), 'n045', Location(GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect)), GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect))), GetRandomReal( 0, 360 ) )
	    call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )
	    call IssueTargetOrder( bj_lastCreatedUnit, "attackonce", GroupPickRandomUnit(GetUnitsInRectOfPlayer(udg_Boss_Rect, Player(10))) )
	    call FlushChildHashtable( udg_hash, GetHandleId( GetExpiredTimer() ) )
	endfunction
	
	function CCard takes nothing returns nothing
		local integer cyclA = 1
		local integer cyclAEnd = udg_Boss_LvL
	
		loop
			exitwhen cyclA > cyclAEnd
	    		set bj_lastCreatedUnit = CreateUnitAtLoc( Player(10), 'n04D', Location(GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect)), GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect))), GetRandomReal( 0, 360 ) )
	    		call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )
	    		call IssueTargetOrder( bj_lastCreatedUnit, "attackonce", DeathSystem_GetRandomAliveHero() )
			set cyclA = cyclA + 1
		endloop
	    call FlushChildHashtable( udg_hash, GetHandleId( GetExpiredTimer() ) )
	endfunction
	
	function FightStart_Delay takes nothing returns nothing
		local integer i = 1
		local player playerCheck
		
		set i = 1
	    loop
	        exitwhen i > 4
	        set playerCheck = Player( i - 1 )
	        if GetPlayerSlotState( playerCheck ) == PLAYER_SLOT_STATE_PLAYING then
				set Event_FightStart_DelayUnit_Hero = udg_hero[i]
				set Event_FightStart_DelayUnit_Index = i
				set Event_FightStart_DelayUnit_Player = playerCheck
				set Event_FightStart_DelayUnit = 1
				set Event_FightStart_DelayUnit = 0
	        endif
	        set i = i + 1
	    endloop
	    
	    set playerCheck = null
	endfunction
	
	function FightStart takes nothing returns nothing
	    local integer cyclA = 1
	    local integer cyclB
	    local integer cyclBEnd
	    local integer cyclC
	    local integer cyclCEnd
	    local integer lim
	    local integer id
	    local integer rand
	    local unit u
	    local group g = CreateGroup()
	    local unit n
	    local real x
	    local real y
	    local integer p
	    local integer m
	    local integer j
	
		if udg_Boss_LvL >= 10 and udg_fightmod[1] then
			call StopMusic(false)
			call ClearMapMusic()
			call PlayMusicBJ( gg_snd_PursuitTheme )
		else
			call StopMusic( false )
			call ClearMapMusic()
	        if GetRandomInt( 1, 2 ) == 1 then
	            call PlayMusicBJ( gg_snd_ArthasTheme )
	        else
	            call PlayMusicBJ( gg_snd_OrcX1 )
	        endif
			call VolumeGroupSetVolume( SOUND_VOLUMEGROUP_MUSIC, 0.7 )
		endif
	    
	    call GroupEnumUnitsInRect( g, bj_mapInitialPlayableArea, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if GetUnitTypeId( u ) == 'n01Z' or GetUnitTypeId( u ) == 'n059' then
	            call KillUnit( u )
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    if not(udg_fightmod[3]) then
	        set bj_livingPlayerUnitsTypeId = 'h009'
	        call GroupEnumUnitsOfPlayer(g, Player( PLAYER_NEUTRAL_AGGRESSIVE ), filterLivingPlayerUnitsOfTypeId)
	        loop
	            set n = FirstOfGroup(g)
	            exitwhen n == null
	            call SetUnitOwner( n, Player(PLAYER_NEUTRAL_PASSIVE), true )
	            call GroupRemoveUnit(g,n)
	        endloop
	        set bj_livingPlayerUnitsTypeId = 'h01F'
	        call GroupEnumUnitsOfPlayer(g, Player( PLAYER_NEUTRAL_AGGRESSIVE ), filterLivingPlayerUnitsOfTypeId)
	        loop
	            set n = FirstOfGroup(g)
	            exitwhen n == null
	            call SetUnitOwner( n, Player(PLAYER_NEUTRAL_PASSIVE), true )
	            call GroupRemoveUnit(g,n)
	        endloop
	    endif
	    
	    if not( udg_logic[53] ) then
	        call RessurectionPoints( -100, false )
	        if udg_Heroes_Ressurect > 0 then
	            call RessurectionPoints( udg_Heroes_Ressurect, false )
	            call BlzFrameSetVisible( resback, true )
	            call BlzFrameSetText( restext, I2S(udg_Heroes_Ressurect_Battle) )
	        endif
	        //set udg_Heroes_Ressurect_Battle = udg_Heroes_Ressurect
	    endif
	    call SetUnitOwner( udg_unit[32], Player(PLAYER_NEUTRAL_PASSIVE), true )
	    set udg_fightmod[0] = true
	    call UnitRemoveAbility( udg_UNIT_DUMMY_BUFF, 'A03U' )
	    if not(udg_logic[54]) then
	        call PauseTimer( udg_timer[3] )
	    endif
	    set udg_KillUnit = udg_KillInBattle
	
	    set cyclA = 1
	    loop
	        exitwhen cyclA > 4
	        call BlzFrameSetVisible( iconframe[cyclA],false)
	        if GetPlayerSlotState( Player( cyclA - 1 ) ) == PLAYER_SLOT_STATE_PLAYING then
	        
	        	set bj_livingPlayerUnitsTypeId = 'u000'
	            call GroupEnumUnitsOfPlayer(g, Player(cyclA - 1), filterLivingPlayerUnitsOfTypeId)
	            loop
	                set u = FirstOfGroup(g)
	                exitwhen u == null
	                call RemoveUnit( u )
	                call GroupRemoveUnit(g,u)
	            endloop
	            
	            call GroupEnumUnitsOfPlayer(g, Player(cyclA - 1), null )
	            loop
	                set u = FirstOfGroup(g)
	                exitwhen u == null
	                if not( IsUnitType( u, UNIT_TYPE_HERO) ) and not( IsUnitType( u, UNIT_TYPE_STRUCTURE) ) and GetUnitAbilityLevel( u, 'A1ER') == 0 then
	                    call RemoveUnit( u )
	                endif
	                call GroupRemoveUnit(g,u)
	            endloop
	        
	            call SaveBoolean( udg_hash, GetHandleId( udg_hero[cyclA] ), StringHash( "pheg" ), false )
	            call BlzSetUnitRealFieldBJ( udg_hero[cyclA], UNIT_RF_ACQUISITION_RANGE, 900 )
	            call SelectUnitForPlayerSingle( udg_hero[cyclA], Player(cyclA - 1) )
	            if GetUnitAbilityLevel(udg_hero[cyclA], 'B06Z') > 0 then
	                call UnitRemoveAbility( udg_hero[cyclA], 'A18E' )
	                call UnitRemoveAbility( udg_hero[cyclA], 'B06Z' )         
	            endif
	            call BlzFrameSetVisible( faceframe[cyclA],false)
	            call BlzFrameSetTexture( iconframe[cyclA], "ReplaceableTextures\\CommandButtons\\BTNDivineShieldOff.blp", 0, true )
	            
	            set udg_fightlogic[cyclA] = false
	            set udg_combatlogic[cyclA] = true
	            
	            set udg_FightStart_Unit = udg_hero[cyclA]
	            //set Trigger_GlobalEventUnit = udg_FightStart_Unit
	            set Event_FightStart_Index = cyclA
	            set udg_FightStart_Real = 1
	            set udg_FightStart_Real = 0
	            //set Trigger_GlobalEventUnit = null
	            
	            call BattleStart.SetDataUnit("caster", udg_hero[cyclA])
	            call BattleStart.SetDataInteger("index", cyclA)
	            call BattleStart.SetDataPlayer("owner", Player( cyclA - 1 ) )
	            call BattleStart.Invoke()
	            
	            if inv( udg_hero[cyclA], 'I0F8') > 0 then
	                call bufst( udg_hero[cyclA], udg_hero[cyclA], 'A05W', 'B09J', "issc", timebonus( udg_hero[cyclA], 30 ) )
	            endif
	            
	            
	            if inv(udg_hero[cyclA], 'I0AG') > 0 and not(udg_fightmod[3]) then
	                set cyclB = 1
	                set cyclBEnd = 6
	                loop
	                    exitwhen cyclB > cyclBEnd
	                    if UnitInventoryCount(udg_hero[cyclA]) < 6 then
	                        call UnitAddItem( udg_hero[cyclA], CreateItem('I0DW', GetUnitX(udg_hero[cyclA]), GetUnitY(udg_hero[cyclA]) ) )
	                    else
	                        set cyclB = cyclBEnd
	                    endif
	                    set cyclB = cyclB + 1
	                endloop
	            endif
	            
	            
	            if not(udg_fightmod[3]) then
	                set cyclB = 0
	                loop
	                    exitwhen cyclB > 5
	                    if SubString(BlzGetItemExtendedTooltip(UnitItemInSlot(udg_hero[cyclA], cyclB)), 0, 19) == "|cff00cceeChameleon" then
	                        call Inventory_ReplaceItemByNew(udg_hero[cyclA], UnitItemInSlot(udg_hero[cyclA], cyclB), udg_DB_Item_Activate[GetRandomInt(1,udg_Database_NumberItems[31])])
	                    endif
	                    set cyclB = cyclB + 1
	                endloop
	                
	                if inv( udg_hero[cyclA], 'I0EJ') > 0 then
	                    call UnitAddAbility( udg_hero[cyclA], 'A0VX' )
	                endif
	            endif
	        endif
	        set cyclA = cyclA + 1
	    endloop
	    
	    set udg_FightStartGlobal_Real = 0.00
	    set udg_FightStartGlobal_Real = 1.00
	    set udg_FightStartGlobal_Real = 0.00
	    
	    call BattleStartGlobal.Invoke()
	
	    if not( udg_fightmod[3] ) then
	        if udg_logic[5] then
	            set udg_logic[5] = false
	            set id = GetHandleId( udg_UNIT_CUTE_BOB )
	        
	            if LoadTimerHandle( udg_hash, id, StringHash( "ccard" ) ) == null  then
	                call SaveTimerHandle( udg_hash, id, StringHash( "ccard" ), CreateTimer() )
	            endif
	            set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "ccard" ) ) ) 
	            call SaveUnitHandle( udg_hash, id, StringHash( "ccard" ), udg_UNIT_CUTE_BOB )
	            call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_UNIT_CUTE_BOB ), StringHash( "ccard" ) ), 3, false, function CCard )
	        endif
	        if udg_logic[96] then
	            set udg_logic[96] = false
	            call SaveTimerHandle( udg_hash, GetHandleId( udg_UNIT_CUTE_BOB ), StringHash( "pigsum" ), CreateTimer() )
	            call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( udg_UNIT_CUTE_BOB ), StringHash( "pigsum" ) ), 1, false, function PigSum )
	        endif
	    endif
	
		call BlzFrameSetVisible( fon,false)
		call BlzFrameSetVisible( sklbk,false)
	    call BlzFrameSetVisible( refbk,false)
		call BlzFrameSetVisible( pvpbk,false)
		call BlzFrameSetVisible(unitfon, false)
		call BlzFrameSetVisible(fastbut, false)
		call BlzFrameSetVisible(itemfon, false)
	    //call BlzFrameSetVisible( juleIcon,false)
	
		call BlzFrameSetVisible(bgfrgfon[1], false)
		call BlzFrameSetVisible(bgfrgfon[2], false)
		call BlzFrameSetVisible(bgfrgfon[3], false)
		call BlzFrameSetVisible(forgebut, false)
	    call BlzFrameSetVisible( modeslight, false )
	    call BlzFrameSetVisible( quartback, false )
	    call BlzFrameSetVisible( juleback, false )
	
	    call BlzFrameSetTexture(pvpbk, "ReplaceableTextures\\CommandButtons\\BTNMassTeleport.blp", 0, true)
	
		call TimerStart(CreateTimer(), 0.1, false, function FightStart_Delay )
	
	    call DestroyGroup( g )
	    set n = null
	    set g = null
	    set u = null
	endfunction
	
	
	function RandHero takes nothing returns nothing
	    local integer cyclA = 1
	    local integer cyclAEnd = udg_Database_InfoNumberHeroes
	    
	    call resethero()
	    
	    call SetRandomHeroes.Invoke()
	    
	    call GroupClear( udg_heroinfo )
	    set cyclA = 1
	    loop
	        exitwhen cyclA > 4
	        if GetPlayerSlotState(Player(cyclA - 1)) == PLAYER_SLOT_STATE_PLAYING then
	            if udg_number[cyclA + 100] == 7 then
	                call spdst( udg_hero[cyclA], -10 )
	            endif
	            call delspellpas( udg_hero[cyclA + 1] )
	            if GetUnitTypeId(udg_hero[cyclA]) == udg_Database_Hero[1] then
	                call DestroyLeaderboard( udg_panel[1] )
	            elseif GetUnitTypeId(udg_hero[cyclA]) == 'O016' then
	                call DestroyLeaderboard( udg_panel[3] )
	            endif
	            call RemoveUnit( udg_hero[cyclA] )
	            set udg_hero[cyclA] = null
	        endif
	        set cyclA = cyclA + 1
	    endloop
	
	    set cyclA = 1
	    loop
	        exitwhen cyclA > cyclAEnd
	    	set udg_UnitHeroLogic[cyclA] = false
		set cyclA = cyclA + 1
	    endloop
	
	    set cyclA = 0
	    loop
	        exitwhen cyclA > 3
	        if GetPlayerSlotState(Player(cyclA)) == PLAYER_SLOT_STATE_PLAYING then
	            call RandomHero_GetRandomHero( Player(cyclA) )
	        endif
	        set cyclA = cyclA + 1
	    endloop
	endfunction
	
endlibrary