library BattleEnd requires Inventory, TextLib, UniquesLib, ItemRandomizerLib, SpecialLib
	
	globals
		real Event_FightEnd_Delay = 0
		
		real Event_FightEnd_DelayUnit = 0
		unit Event_FightEnd_DelayUnit_Hero
		integer Event_FightEnd_DelayUnit_Index 
		player Event_FightEnd_DelayUnit_Player
	endglobals
	
	function FightEnd_Delay takes nothing returns nothing
		local integer i = 1
		local player playerCheck
		
		set i = 1
	    loop
	        exitwhen i > 4
	        set playerCheck = Player( i - 1 )
	        if GetPlayerSlotState( playerCheck ) == PLAYER_SLOT_STATE_PLAYING then
				set Event_FightEnd_DelayUnit_Hero = udg_hero[i]
				set Event_FightEnd_DelayUnit_Index = i
				set Event_FightEnd_DelayUnit_Player = playerCheck
				set Event_FightEnd_DelayUnit = 1
				set Event_FightEnd_DelayUnit = 0
	        endif
	        set i = i + 1
	    endloop
	    
	    set Event_FightEnd_Delay = 1
	    set Event_FightEnd_Delay = 0
	    
	    set playerCheck = null
	endfunction
	
	private function IsWin takes integer battleType, integer state returns boolean
		if battleType == BATTLE_TYPE_MAIN then
			return true
		endif
		return false
	endfunction
	
	function FightEnd takes integer battleType, integer state returns nothing
	    local integer cyclA
	    local integer cyclB
	    local integer cyclBEnd
	    local integer rand 
	    local integer spec
	    local integer id
	    local integer i
	    local string text
	    local group g = CreateGroup()
	    local unit n
	    local integer array st
	    local integer array ag
	    local integer array in
	    local integer array lvl
	    local integer array t
	    local integer j
	    local item it
	    local unit u
	    local integer p
	    local boolean isWin = IsWin(battleType, state)
	
	    if not(udg_logic[43]) then
	    	call StopMusic( false )
	        set rand = GetRandomInt( 1, 3)
	        call ClearMapMusic()
	        if rand == 1 then
	            //call PlayThematicMusic( gg_snd_Human1 )
			call PlayMusicBJ( gg_snd_Human1 )
	        elseif rand == 2 then
	            //call PlayThematicMusic( gg_snd_Human2 )
			call PlayMusicBJ( gg_snd_Human2 )
	        else
	            //call PlayThematicMusic( gg_snd_Human3 )
		    call PlayMusicBJ( gg_snd_Human3 )
	        endif
		call VolumeGroupSetVolume( SOUND_VOLUMEGROUP_MUSIC, 0.7 )
	    endif
	    call ShowUnitShow( udg_UNIT_CUTE_BOB )

	    set bj_livingPlayerUnitsTypeId = 'h009'
	    call GroupEnumUnitsOfPlayer(g, Player( PLAYER_NEUTRAL_PASSIVE ), filterLivingPlayerUnitsOfTypeId)
	    loop
	        set n = FirstOfGroup(g)
	        exitwhen n == null
	        call SetUnitOwner( n, Player(PLAYER_NEUTRAL_AGGRESSIVE), true )
	        call GroupRemoveUnit(g,n)
	    endloop
	    set bj_livingPlayerUnitsTypeId = 'h01F'
	    call GroupEnumUnitsOfPlayer(g, Player( PLAYER_NEUTRAL_PASSIVE ), filterLivingPlayerUnitsOfTypeId)
	    loop
	        set n = FirstOfGroup(g)
	        exitwhen n == null
	        call SetUnitOwner( n, Player(PLAYER_NEUTRAL_AGGRESSIVE), true )
	        call GroupRemoveUnit(g,n)
	    endloop
	
	    set udg_fightmod[0] = false
	    call SetUnitOwner( udg_unit[32], Player(0), true )
	    call PauseTimer( LoadTimerHandle( udg_hash, GetHandleId( udg_UNIT_DUMMY_BUFF ), StringHash( "bssdtimer" ) ) )
	    call TimerDialogDisplay( udg_timerdialog[0], false )
	    call UnitRemoveAbility( udg_UNIT_CUTE_BOB, 'A0JQ' )
	    call UnitAddAbility( udg_UNIT_DUMMY_BUFF, 'A03U' )
	    /*if udg_real[1] > 0 and not( udg_logic[43] ) and not(udg_logic[97] ) and not( udg_logic[54] ) then
	        call TimerStart( udg_timer[1], udg_real[1], false, null )
	        call TimerStart( udg_timer[2], udg_real[1]-20, false, null )
	        set udg_timerdialog[2] = CreateTimerDialog(udg_timer[1])
	        call TimerDialogSetTitle(udg_timerdialog[2], "Start of the battle:" )
	        call TimerDialogDisplay(udg_timerdialog[2], true)
	    endif*/
	
	    set cyclA = 1
	    loop
	        exitwhen cyclA > 4
	        call BlzFrameSetVisible( iconframe[cyclA],true)
	        if GetPlayerSlotState( Player( cyclA - 1 ) ) == PLAYER_SLOT_STATE_PLAYING then
	            call SaveBoolean( udg_hash, GetHandleId( udg_hero[cyclA] ), StringHash( "kill" ), false )
	            call BlzSetUnitRealFieldBJ( udg_hero[cyclA], UNIT_RF_ACQUISITION_RANGE, 600 )
	            call SelectUnitForPlayerSingle( udg_hero[cyclA], Player(cyclA - 1) )
	            
	            call UnitRemoveAbility( udg_hero[cyclA], 'A031' )
	            if not(udg_logic[43]) then
	                call BlzFrameSetVisible( faceframe[cyclA],true)
	            endif
	            set i = GetPlayerId(GetOwningPlayer(udg_hero[cyclA])) + 1
	            set udg_combatlogic[cyclA] = false
	            set cyclB = 1
	            set cyclBEnd = deadminionlim[cyclA]
	            loop
	                exitwhen cyclB > cyclBEnd
	                set deadminion[cyclA][cyclB] = 0
	                set cyclB = cyclB + 1
	            endloop
	            set deadminionnum[cyclA] = 0
	            set deadminionlim[cyclA] = 0
	            if LoadInteger( udg_hash, GetHandleId( udg_hero[cyclA] ), StringHash( "spig" ) ) >= 5 and inv( udg_hero[cyclA], 'I097' ) > 0 then
	                call SetWidgetLife( GetItemOfTypeFromUnitBJ(udg_hero[cyclA], 'I097'), 0 )
	                set bj_lastCreatedItem = CreateItem( 'I03F', GetUnitX(udg_hero[cyclA]), GetUnitY(udg_hero[cyclA]))
	                call UnitAddItem(udg_hero[cyclA], bj_lastCreatedItem)
	                call textst( "|c00ffffff Ground comparison done!", udg_hero[cyclA], 64, GetRandomReal( 45, 135 ), 12, 1.5 )
	                call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\ReviveHuman\\ReviveHuman.mdl", GetUnitX(udg_hero[cyclA]), GetUnitY(udg_hero[cyclA]) ) )
	                set udg_QuestDone[GetPlayerId( GetOwningPlayer(udg_hero[cyclA]) ) + 1] = true
	            endif
	            
	            set udg_FightEnd_Unit = udg_hero[cyclA]
	            set udg_FightEnd_Real = 0
	            set udg_FightEnd_Real = 1
	            set udg_FightEnd_Real = 0
	            
	            call BattleEnd.SetDataUnit("caster", udg_hero[cyclA])
	            call BattleEnd.SetDataPlayer("owner", Player( cyclA - 1 ))
	            call BattleEnd.SetDataInteger("index", cyclA)
	            call BattleEnd.SetDataBoolean("is_win", isWin )
	            call BattleEnd.Invoke() 
	            
	            if GetUnitAbilityLevel( udg_hero[cyclA], 'A0IK' ) > 0 or GetUnitAbilityLevel( udg_hero[cyclA], 'A0IJ' ) > 0 or GetUnitAbilityLevel( udg_hero[cyclA], 'A0IL' ) > 0 or GetUnitAbilityLevel( udg_hero[cyclA], 'A0IM' ) > 0 or GetUnitAbilityLevel( udg_hero[cyclA], 'A0IN' ) > 0 or GetUnitAbilityLevel( udg_hero[cyclA], 'A0IO' ) > 0 then
	                set spec = udg_Ability_Uniq[cyclA]
	                set cyclB = 1
	                loop
	                    exitwhen cyclB > 1
	                    set rand = GetRandomInt( 1, 3 )
	                    if udg_DB_Hero_SpecAb[10 + rand] != spec and udg_DB_Hero_SpecAbPlus[10 + rand] != spec then
	                        call NewUniques( udg_hero[cyclA], udg_DB_Hero_SpecAb[10 + rand] )
	                    else
	                        set cyclB = cyclB - 1
	                    endif
	                    set cyclB = cyclB + 1
	                endloop
	            endif
	            if udg_logic[10] then
	                set cyclB = 0
	                loop
	                    exitwhen cyclB > 5
	                    set it = UnitItemInSlot(udg_hero[cyclA], cyclB)
	                    if it != null then
	                        if GetItemType(it) == ITEM_TYPE_PERMANENT then
	                            call RemoveItem(it)
	                            call ItemRandomizer( udg_hero[cyclA], "common" )
	                        elseif GetItemType(it) == ITEM_TYPE_CAMPAIGN then
	                            call RemoveItem(it)
	                            call ItemRandomizer( udg_hero[cyclA], "rare" )
	                        elseif GetItemType(it) == ITEM_TYPE_ARTIFACT then
	                            call RemoveItem(it)
	                            call ItemRandomizer( udg_hero[cyclA], "legendary" )
	                        endif
	                    endif
	                    set cyclB = cyclB + 1
	                endloop
	            endif
	            if GetUnitAbilityLevel(udg_hero[cyclA], 'A1BW') > 0 then
	                call NewSpecial( udg_hero[cyclA], 'A1BV' )
	            endif
	            if not( udg_fightmod[3] ) then
	                set cyclB = 0
	                loop
	                    exitwhen cyclB > 5
	                    if SubString(BlzGetItemExtendedTooltip(UnitItemInSlot(udg_hero[cyclA], cyclB)), 0, 18) == "|cffC71585Cursed|r" then
	                        call RemoveItem( UnitItemInSlot(udg_hero[cyclA], cyclB) )
	                    endif
	                    set cyclB = cyclB + 1
	                endloop
	                if udg_logic[51] and inv(udg_hero[cyclA], 'I0FB') == 0 then
	                    if UnitInventoryCount(udg_hero[cyclA]) >= 6 then
	                        call RemoveItem( UnitItemInSlot( udg_hero[cyclA], GetRandomInt(0, 5) ) )
	                    endif
	                    call UnitAddItem( udg_hero[cyclA], CreateItem( 'I0FB', GetUnitX( udg_hero[cyclA] ), GetUnitY( udg_hero[cyclA] ) ) )
	                endif
	                if udg_logic[80] then
	                    call skillst( cyclA, -1 )
	                endif
	                if GetUnitAbilityLevel(udg_hero[cyclA], 'B04J') > 0 then
	                    call UnitRemoveAbility(udg_hero[cyclA], 'A08Q')
	                    call UnitRemoveAbility(udg_hero[cyclA], 'B04J')  
	                endif
	                if GetUnitAbilityLevel(udg_hero[cyclA], 'B085') > 0 then
	                    call UnitRemoveAbility(udg_hero[cyclA], 'A0VX')
	                    call UnitRemoveAbility(udg_hero[cyclA], 'B085')  
	                endif
	                if inv(udg_hero[cyclA], 'I086') > 0 then
	                    set st[0] = 0
	                    set st[1] = 0
	                    set cyclB = 2
	                    loop
	                        exitwhen cyclB > 4
	                        set st[cyclB] = DB_SetItems[5][GetRandomInt( 1, udg_DB_SetItems_Num[5] )]
	                        if (st[cyclB] == st[cyclB-1] or st[cyclB] == st[cyclB-2]) then
	                            set cyclB = cyclB - 1
	                        endif
	                        set cyclB = cyclB + 1
	                    endloop
	                    call forge( udg_hero[cyclA], GetItemOfTypeFromUnitBJ( udg_hero[cyclA], 'I086'), st[4], st[2], st[3], true )
	                endif
			        /// Last
	                if GetHeroStr( udg_hero[cyclA], false) < 1 then
	                    call SetHeroStr( udg_hero[cyclA], 1, true)
	                endif
	                if GetHeroAgi( udg_hero[cyclA], false) < 1 then
	                    call SetHeroAgi( udg_hero[cyclA], 1, true)
	                endif
	                if GetHeroInt( udg_hero[cyclA], false) < 1 then
	                    call SetHeroInt( udg_hero[cyclA], 1, true)
	                endif
	            endif
	            set udg_Death[cyclA] = false
	            if udg_number[1] > 0 then
	                if inv(udg_hero[cyclA], 'I0CX') > 0 then
	                    call RemoveItem( GetItemOfTypeFromUnitBJ( udg_hero[cyclA], 'I0CX') )
	                    call UnitAddItem( udg_hero[cyclA], CreateItem(DB_Items[3][GetRandomInt( 1, udg_Database_NumberItems[3] )], GetUnitX(udg_hero[cyclA]), GetUnitY(udg_hero[cyclA]) ) )
	                endif
	            endif
	        endif
	        set cyclA = cyclA + 1
	    endloop
	
	    set udg_FightEndGlobal_Real = 0.00
	    set udg_FightEndGlobal_Real = 1.00
	    set udg_FightEndGlobal_Real = 0.00
	    
	    call BattleEndGlobal.SetDataBoolean("is_win", isWin )
	    call BattleEndGlobal.Invoke()
	
	    
	    call BlzFrameSetVisible( resback, false )
		call AUI_HpBarHide()
		call BlzFrameSetVisible( bonusframe[-1], false ) 
	
		if not( udg_logic[43] ) then
			call BlzFrameSetVisible( fon,true)
			call BlzFrameSetVisible( readyParent,true)
		endif
	    
	    /*if AnyHasLvL(3) then
	        call BlzFrameSetVisible( juleIcon,true)
	    endif*/
	    
	    call BlzFrameSetVisible( modesbut, false )
	    call BlzFrameSetVisible( modesback, false )
	    call BlzFrameSetVisible( gqfone, false )
	
	    //Держать здесь
	    set udg_number[1] = 0 
	    if udg_logic[4] and not(udg_fightmod[3]) then
	        set udg_logic[4] = false
	        call IconFrameDel( "Credit Card" )
	    endif
	    if udg_logic[80] and not(udg_fightmod[3]) then
	        set udg_logic[80] = false
	        call IconFrameDel( "World" )
	    endif
	    if udg_logic[34] and not(udg_fightmod[3]) then
	        set udg_logic[34] = false
	        call IconFrameDel( "Hermit" )
	    endif 
	
	    set udg_KillUnit = 0
	    
	    call TimerStart(CreateTimer(), 0.1, false, function FightEnd_Delay )
	
	    call DestroyGroup( g )
	    set n = null
	    set g = null
	endfunction
	
endlibrary