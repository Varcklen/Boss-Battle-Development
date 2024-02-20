scope HeroesChoise initializer init

    globals
        unit array ChoosedHero[PLAYERS_LIMIT_ARRAYS]
    
        real Event_HeroChoose_Real = 0
        unit Event_HeroChoose_Hero = null
        
        private FirstPosition tempPosition
    endglobals
    
    struct FirstPosition
        real x
        real y
        real facing
    endstruct

    private function Trig_HeroesChoise_Conditions takes nothing returns boolean
        return IsUnitType(GetEnteringUnit(), UNIT_TYPE_HERO) and udg_hero[GetPlayerId(GetOwningPlayer(GetEnteringUnit())) + 1] == null
    endfunction
    
    private function GetFirstPositon takes unit hero, integer index returns FirstPosition
        if udg_Boss_LvL > 1 then
            call SetHeroLevel( hero, GetHeroLevel(hero) + 1, true)
            set tempPosition.x = GetLocationX( udg_point[index + 21] )
            set tempPosition.y = GetLocationY( udg_point[index + 21] )
            set tempPosition.facing = 90
        else
            set tempPosition.x = GetRectCenterX(gg_rct_HeroTp)
            set tempPosition.y = GetRectCenterY(gg_rct_HeroTp)
            set tempPosition.facing = 270
        endif
    
        set hero = null
        return tempPosition
    endfunction

    private function SetClassNumber takes unit hero returns nothing
        local integer i = 1
        local integer iEnd
        local boolean isFind = false
    
        loop
            exitwhen i > HeroesTableDatabase_CLASSES or isFind
            if IsUnitHasAbility( hero, udg_DB_Hero_SpecAb[i] ) then
                set udg_number[i + 100] = i
                set isFind = true
            endif
            set i = i + 1
        endloop
        if isFind == false then
            set udg_number[i + 100] = 4
        endif
        
        set i = 1
        set iEnd = udg_Database_NumberItems[13]
        loop
            exitwhen i > iEnd
            if IsUnitHasAbility( hero, udg_DB_Hero_SpecAb[i] ) then
                call NewUniques( hero, udg_DB_Hero_SpecAb[i] )
                set i = iEnd
            endif
            set i = i + 1
        endloop
        
        set hero = null
    endfunction
    
    private function AddBonusItems takes unit hero, integer index returns nothing
        local integer unitType = GetUnitTypeId(hero)
    
        call UnitAddItem(hero, CreateItem('I054', GetUnitX(hero), GetUnitY(hero)))
        if udg_logic[8] then
            call UnitAddItem(hero, CreateItem('I056', GetUnitX(hero), GetUnitY(hero)))
            set udg_logic[8] = false
        elseif unitType == udg_HeroBonusPotionHero[1] or unitType == udg_HeroBonusPotionHero[2] or unitType == udg_HeroBonusPotionHero[3] or unitType == udg_HeroBonusPotionHero[4] then
            call UnitAddItem(hero, CreateItem('I05B', GetUnitX(hero), GetUnitY(hero)))
        endif
        if udg_LvL[index] >= 15 then
            call UnitAddItem(hero, CreateItem('I055', GetUnitX(hero), GetUnitY(hero)))
        endif
        if udg_LvL[index] >= 20 then
            call UnitAddItem(hero, CreateItem('I0CX', GetUnitX(hero), GetUnitY(hero)))
        endif
    
        set hero = null
    endfunction

    private function HeroPicked takes nothing returns nothing
        local unit hero = Event_HeroPicked_Hero
        local player owner = Event_HeroPicked_Player
        local integer index = GetPlayerId(owner) + 1
        local integer heroKey = Event_HeroPicked_HeroKey
        local integer class = Event_HeroPicked_Class
        local FirstPosition position
        
        set udg_HeroNum[index] = heroKey
        set udg_UnitHeroLogic[heroKey] = true
        set udg_hero[index] = hero
        set ChoosedHero[index] = hero
        set position = GetFirstPositon(hero, index)
        set udg_UnitHero[heroKey] = hero
        set udg_number[index + 100] = class + 1
        
        call MultiSetIcon( udg_multi, ( udg_Multiboard_Position[index] * 3 ) - 1, 3, udg_DB_Hero_Icon[heroKey] )
        if udg_SkinUsed[index] == 0 then
            call BlzFrameSetTexture( faceframe[index], udg_DB_Hero_Icon[heroKey], 0, false)
        endif 
        call SetUnitOwner( hero, owner, true )
        //call MMD_UpdateValueString("hero",owner,GetUnitName(hero))
        call SetUnitUserData(hero, index)
        call SetClassNumber(hero)
        call GroupAddUnit( udg_otryad, hero )
        call GroupAddUnit( udg_heroinfo, hero )
        call FogModifierStop( udg_Visible[index] )
        call AddBonusItems(hero, index)
        /*if IsTimerResume() then
            call ResumeTimer(udg_timer[1])
            call ResumeTimer(udg_timer[3])
        endif */

        set Event_HeroChoose_Hero = hero
        set Event_HeroChoose_Real = 0.00
        set Event_HeroChoose_Real = 1.00
        set Event_HeroChoose_Real = 0.00
        
        if GetLocalPlayer() == owner then
            call ResetToGameCameraForPlayer( owner, 0 )
            if AnyHasLvL(2) then
                call BlzFrameSetVisible( modesbut, true )
                if owner == udg_Host then
                    call BlzFrameSetVisible( modeslight, true )
                endif
                if AnyHasLvL(10) == false then
                    call BlzFrameSetVisible( modebase, false )
                    call BlzFrameSetVisible( rotbase, false )
                endif
            endif
            if udg_LvL[index] <= 5 then
                call BlzFrameSetVisible( arrowframe, true )
            endif
            if not(udg_logic[77]) and not(udg_logic[9]) then
                call BlzFrameSetVisible( rpkmod,true)
            endif
            call BlzFrameSetVisible( fon,true)
            call BlzFrameSetVisible( butbk,true)
            call BlzFrameSetVisible( iconframe[1],true)
            call BlzFrameSetVisible( iconframe[2],true)
            call BlzFrameSetVisible( iconframe[3],true)
            call BlzFrameSetVisible( iconframe[4],true)
            if GetPlayerSlotState( Player( 0 ) ) == PLAYER_SLOT_STATE_PLAYING then
                call BlzFrameSetVisible( faceframe[1],true)
            endif
            if GetPlayerSlotState( Player( 1 ) ) == PLAYER_SLOT_STATE_PLAYING then
                call BlzFrameSetVisible( faceframe[2],true)
            endif
            if GetPlayerSlotState( Player( 2 ) ) == PLAYER_SLOT_STATE_PLAYING then
                call BlzFrameSetVisible( faceframe[3],true)
            endif
            if GetPlayerSlotState( Player( 3 ) ) == PLAYER_SLOT_STATE_PLAYING then
                call BlzFrameSetVisible( faceframe[4],true)
            endif
            call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, 2225, 0)
        endif
        if udg_number[index + 100] == 7 then
            call spdst( hero, 10 )
        elseif udg_number[index + 100] == 5 then
        	call luckyst( hero, 5 )
        endif

        call SetUnitPosition( hero, position.x, position.y )
        call SetUnitFacing( hero, position.facing )
        call PanCameraToTimedForPlayer( Player( GetPlayerId(GetOwningPlayer( hero ) ) ), position.x, position.y, 0 )
        
        if udg_combatlogic[index] == false and udg_Boss_LvL == 1 then
            call KillUnit( hero )
        endif
        call SetUnitState( hero, UNIT_STATE_MANA, GetUnitState( hero, UNIT_STATE_MAX_MANA ) )
        
        call position.destroy()
        set hero = null
        set owner = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local integer i = 1
        loop
            exitwhen i > PLAYERS_LIMIT
            set ChoosedHero[i] = null
            set i = i + 1
        endloop
        call CreateEventTrigger( "Event_HeroPicked_Real", function HeroPicked, null )
        
        set tempPosition = FirstPosition.create()
    endfunction

endscope