library BattleIntersection requires BuffDeleteLib, BattleStart, BattleEnd

	globals
	    real Event_EndOfLostBattle_Real
	    unit Event_EndOfLostBattle_Hero
	    
	    real Event_BetweenUnit = 0
	    unit Event_BetweenUnit_Hero
	    integer Event_BetweenUnit_Index
	    
	    private boolean IsBattleEnded = false
	    
	    private constant string TELEPORTATION_ANIMATION = "Void Teleport Caster.mdx"
	endglobals
	
	public function IsBattleEnd takes nothing returns boolean
	    return IsBattleEnded
	endfunction

	private function DelItem takes nothing returns nothing
	    call RemoveItem( GetFilterItem() )
	endfunction
	
	private function KillTransport takes nothing returns nothing
		local group g = CreateGroup()
	    local unit u
	
		call GroupEnumUnitsInRect( g, udg_Boss_Rect, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if GetUnitAbilityLevel( u, 'A1JY') > 0 then
	            call KillUnit( u )
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    call DestroyGroup( g )
	    set u = null
	    set g = null
    endfunction

    private function PlayerAction takes unit hero, player owner, integer index, integer battleType returns nothing
    	local group g = CreateGroup()
	    local unit u
    
    	call ShowUnitShow( hero )

        if ExtraArenaGeneral_IsPvPActive() and ExtraArenaGeneral_IsPvPFighter(hero) == false then
        	return
        endif

        call ReviveHeroLoc( hero, udg_point[index + 21], true )
        call DestroyEffect( AddSpecialEffect( TELEPORTATION_ANIMATION, GetUnitX(hero), GetUnitY(hero) ) )
        call SetUnitState( hero, UNIT_STATE_LIFE, GetUnitState( hero, UNIT_STATE_MAX_LIFE) )
        call SetUnitState( hero, UNIT_STATE_MANA, GetUnitState(hero, UNIT_STATE_MAX_MANA) )
        call UnitResetCooldown( hero )
        call IssueImmediateOrder( hero, "stop" )
        call DelBuff( hero, true )
        call SetUnitOwner( hero, owner, true )
        
        /*if LoadUnitHandle( udg_hash, GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( hero ), StringHash( "mad" ) ) ), StringHash( "mad" ) ) == hero then
            call DestroyTimer( LoadTimerHandle( udg_hash, GetHandleId( hero ), StringHash( "mad" ) ) )
            call FlushChildHashtable( udg_hash, GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( hero ), StringHash( "mad" ) ) ) )
        endif*/
        /*if LoadUnitHandle( udg_hash, GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( hero ), StringHash( "sheepmad" ) ) ), StringHash( "sheepmad" ) ) == hero then
            call DestroyTimer( LoadTimerHandle( udg_hash, GetHandleId( hero ), StringHash( "sheepmad" ) ) )
            call FlushChildHashtable( udg_hash, GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( hero ), StringHash( "sheepmad" ) ) ) )
        endif*/
        
        set bj_livingPlayerUnitsTypeId = 'u000'
        call GroupEnumUnitsOfPlayer(g, owner, filterLivingPlayerUnitsOfTypeId)
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call RemoveUnit( u )
            call GroupRemoveUnit(g,u)
        endloop
        
        call GroupEnumUnitsOfPlayer(g, owner, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if not( IsUnitType( u, UNIT_TYPE_HERO) ) and not( IsUnitType( u, UNIT_TYPE_STRUCTURE) ) and GetUnitAbilityLevel( u, 'A1ER') == 0 then
                call RemoveUnit( u )
            endif
            call GroupRemoveUnit(g,u)
        endloop
        
        if battleType == BATTLE_TYPE_INFINITE_ARENA or battleType == BATTLE_TYPE_OVERLORD_ARENA or battleType == BATTLE_TYPE_RESSURECTION then
            set Event_EndOfLostBattle_Hero = hero
            set Event_EndOfLostBattle_Real = 0.00
            set Event_EndOfLostBattle_Real = 1.00
            set Event_EndOfLostBattle_Real = 0.00
        endif
        
        call DestroyGroup( g )
	    set u = null
	    set g = null
    endfunction

	private function BetweenEnd takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local integer battleType = LoadInteger( udg_hash, id, StringHash( "intersection_battle_type" ) )
	    local integer i
	    local group g = CreateGroup()
	    local unit u
	    
	    set IsBattleEnded = false
	    call KillTransport()

	    set i = 1
	    loop
	        exitwhen i > 4
            if GetPlayerSlotState(Player(i - 1)) == PLAYER_SLOT_STATE_PLAYING then
                call PlayerAction(udg_hero[i], Player(i - 1), i, battleType)
            endif
	        set i = i + 1
	    endloop
	    
	    //Remove any non-hero on the battle arena
	    call GroupEnumUnitsInRect( g, udg_Boss_BigRect, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if not( IsUnitType( u, UNIT_TYPE_HERO) ) then
	            call RemoveUnit( u )
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    //Remove any friendly player (yellow) units.
	    call GroupEnumUnitsOfPlayer(g, Player(4), null )
	    call GroupRemoveUnit(g, udg_UNIT_DUMMY_BUFF)
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        call RemoveUnit( u )
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    //Remove dummy units (they unvisible in GroupEnumUnitsInRect)
	    set bj_livingPlayerUnitsTypeId = 'u000'
	    call GroupEnumUnitsOfPlayer(g, Player(10), filterLivingPlayerUnitsOfTypeId)
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        call RemoveUnit( u )
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    //Remove items on the arena
	    call EnumItemsInRect( udg_Boss_BigRect, null, function DelItem )
	
		call BetweenGlobal.Invoke()
	    
	    if battleType == BATTLE_TYPE_MAIN/*str == "end_boss"*/ then
	        call TriggerExecute( gg_trg_EndFightWork )
	    elseif battleType == BATTLE_TYPE_RESSURECTION/*str == "res_boss"*/ then
	        call TriggerExecute( gg_trg_Ressurect )
	    elseif battleType == BATTLE_TYPE_INFINITE_ARENA/*str == "end_IA"*/ then
	        call TriggerExecute( gg_trg_IA_EndWork )
	    elseif battleType == BATTLE_TYPE_OVERLORD_ARENA/*str == "end_AL"*/ then
	        call TriggerExecute( gg_trg_AL_EndWork )
	    elseif battleType == BATTLE_TYPE_PVP/*str == "end_PA"*/ then
	        call TriggerExecute( gg_trg_PA_EndWork )
	    endif
	    
	    call FlushChildHashtable( udg_hash, id )
	    
	    call DestroyGroup( g )
	    set u = null
	    set g = null
	endfunction
	
	private function PlayerIteration takes unit hero, player owner, integer index, integer battleType, integer state returns nothing
		local integer i
	
		call DelBuff( hero, true )
        call SetUnitOwner( hero, owner, true )
        if hero != null and BlzGetUnitMaxHP(hero) < 0.405 then
            call BlzSetUnitMaxHP( hero, 100 )
        endif
        if ExtraArenaGeneral_IsPvPActive() == false or ExtraArenaGeneral_IsPvPFighter(hero) then
            if state == STATE_BATTLE then
                call SetUnitState( hero, UNIT_STATE_LIFE, GetUnitState( hero, UNIT_STATE_MAX_LIFE) )
                call SetUnitState( hero, UNIT_STATE_MANA, GetUnitState( hero, UNIT_STATE_MAX_MANA) )
                call ReviveHeroLoc( hero, udg_point[index + 21], true )
                call UnitResetCooldown( hero )
                call IssueImmediateOrder( hero, "stop" )
            endif
            
            set Event_BetweenUnit_Index = index
	        set Event_BetweenUnit_Hero = hero
	        set Event_BetweenUnit = 1
	        set Event_BetweenUnit = 0
        endif
        set i = 0
        loop
            exitwhen i > 3
            if index-1 != i then
                call SetPlayerAllianceStateBJ( owner, Player(i), bj_ALLIANCE_ALLIED_VISION )
            endif
            set i = i + 1
        endloop
	endfunction

	function Between takes integer battleType, integer state returns nothing
	    local integer i
	    local integer id
	    local timer timerUsed
	    
		call BattleData_Set(battleType, state)

	    set udg_Player_Readiness = 0
	    set udg_Pattern = udg_Pattern + 1
	
	    call BetweenBattles.Invoke()
	    
	    call KillTransport()
	    
	    set i = 1
	    loop
	        exitwhen i > 4
	        if GetPlayerSlotState(Player(i - 1)) == PLAYER_SLOT_STATE_PLAYING then
	        	call PlayerIteration( udg_hero[i], Player(i - 1), i, battleType, state )
	        endif
	        set i = i + 1
	    endloop
	    
		if state == STATE_BATTLE then
	   		if battleType == BATTLE_TYPE_MAIN then
		        call TriggerExecute( gg_trg_StartFightWork )
		    elseif battleType == BATTLE_TYPE_INFINITE_ARENA then
		        call TriggerExecute( gg_trg_IA_StartWork )
		    elseif battleType == BATTLE_TYPE_OVERLORD_ARENA then
		        call TriggerExecute( gg_trg_AL_StartWork )
	   		endif
	    elseif state == STATE_REST then
	        call StartSound( gg_snd_ovations )
	        call DisplayTimedTextToForce( bj_FORCE_ALL_PLAYERS, 5, "|cffffcc00END OF BATTLE|r" )
	        
	        if battleType == BATTLE_TYPE_MAIN or battleType == BATTLE_TYPE_OVERLORD_ARENA /*str != "res_boss" or str != "end_LA"*/ then
		        call GroupClear( udg_Bosses )
		    endif
		    
		    set IsBattleEnded = true

		    set timerUsed = CreateTimer()
		    set id = GetHandleId( timerUsed )
		    call SaveInteger( udg_hash, id, StringHash( "intersection_battle_type" ), battleType )
		    call TimerStart( timerUsed, 2, false, function BetweenEnd )
	    endif

	    set timerUsed = null
	endfunction

endlibrary