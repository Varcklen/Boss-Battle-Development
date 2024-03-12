scope MepthistarExtra initializer init

	globals
		private framehandle array mephbut
	    private framehandle array mephicon
	    private framehandle array mephnum
	    private framehandle array inactiveFrame
	    private framehandle mephuse
	    private boolean array OnCooldown
	    
	    private constant real MEPHISTAR_E_BLOOD_DURATION = 15
	    
	    private constant real MEPHISTAR_E_MECH_DURATION = 15
	    
	    private constant real MEPHISTAR_E_MOON_DAMAGE = 150
	    private constant real MEPHISTAR_E_MOON_AREA = 400
	    
	    private constant integer MEPHISTAR_E_NATURE_TRIGGERS = 1
	    private constant real MEPHISTAR_E_NATURE_HEAL_PERC = 0.25
	    
	    private constant real MEPHISTAR_E_RING_DURATION = 15
	    private constant real MEPHISTAR_E_RING_DAMAGE_BONUS = 0.2
	    private constant integer MEPHISTAR_E_RING_EFFECT = 'A147'
	    private constant integer MEPHISTAR_E_RING_BUFF = 'B08L'
	    
	    private constant real MEPHISTAR_E_CRYSTAL_COOLDOWN_REDUCTION = 0.25
	    
	    private constant real MEPHISTAR_E_WEAPON_DURATION = 5
	    
	    private unit udg_Mephistar = null
	    
	    private constant integer COOLDOWN = 15
	    
	    private constant integer ABILITY_ID = 'A1EL'
	endglobals
	
	private function RingDamageBonus_Condition takes nothing returns boolean
		return GetUnitAbilityLevel(udg_DamageEventSource, MEPHISTAR_E_RING_BUFF) > 0
	endfunction
	
	private function RingDamageBonus takes nothing returns nothing
		set udg_DamageEventAmount = udg_DamageEventAmount + ( Event_OnDamageChange_StaticDamage * MEPHISTAR_E_RING_DAMAGE_BONUS)
	endfunction
	
	private function EndCooldown takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local integer index = LoadInteger( udg_hash, id, StringHash( "mephistar_extra_cooldown" ) )
		local integer stringHash = StringHash( "mephistar_extra_cooldown_" + I2S(index) )
		local player playerUsed = LoadPlayerHandle( udg_hash, id, stringHash )
		
		if GetLocalPlayer() == playerUsed then
			call BlzFrameSetVisible( inactiveFrame[index], false )
		endif
		set OnCooldown[index] = false
		call FlushChildHashtable( udg_hash, id )
	
		set playerUsed = null
	endfunction
	
	private function StartCooldown takes integer index returns nothing
		local unit caster = udg_Mephistar
		local player playerUsed = GetOwningPlayer(caster)
		local integer id = GetHandleId( caster )
		local timer timerUsed
		local integer stringHash = StringHash( "mephistar_extra_cooldown_" + I2S(index) )
		
		if GetLocalPlayer() == playerUsed then
			call BlzFrameSetVisible( inactiveFrame[index], true )
		endif
		set OnCooldown[index] = true
		
		set timerUsed = LoadTimerHandle( udg_hash, id, stringHash )
	    if timerUsed == null then
	    	set timerUsed = CreateTimer()
	        call SaveTimerHandle( udg_hash, id, stringHash, timerUsed )
	    endif
	    set id = GetHandleId( timerUsed )
	    call SavePlayerHandle( udg_hash, id, stringHash, GetOwningPlayer(caster) )
	    call SaveInteger( udg_hash, id, StringHash( "mephistar_extra_cooldown" ), index )
	    call TimerStart( timerUsed, COOLDOWN, false, function EndCooldown ) 

		set timerUsed = null
		set caster = null
		set playerUsed = null
	endfunction
	
	private function MephistarEFrameGeneral takes integer number returns nothing
	    set udg_MephistarUse[number] = udg_MephistarUse[number] - 1
	    call BlzFrameSetText( mephnum[number], I2S(udg_MephistarUse[number]) )
	    if udg_MephistarUse[number] <= 0 then
	        call BlzFrameSetTexture( mephicon[number], "ReplaceableTextures\\CommandButtons\\BTNCancel.blp", 0, true )
        else
        	call StartCooldown(number)
	    endif
	endfunction
	
	private function MephistarEAlchemy takes nothing returns nothing
	    local integer i
	    
	    call MephistarEFrameGeneral(1)
	    
	    set i = 1
	    loop
	        exitwhen i > PLAYERS_LIMIT
	        if unitst( udg_hero[i], udg_Mephistar, "ally" ) then 
	            set udg_Caster = udg_hero[i]
	            set udg_RandomLogic = true
	            call TriggerExecute( udg_DB_Trigger_Pot[GetRandomInt( 1, udg_Database_NumberItems[9] )] )
	        endif
	        set i = i + 1
	    endloop
	endfunction
	
	private function MephistarEBlood takes nothing returns nothing
	    local integer i
	    local real t
	    
	    call MephistarEFrameGeneral(2)
	    
	    set i = 1
	    loop
	        exitwhen i > PLAYERS_LIMIT
	        if unitst( udg_hero[i], udg_Mephistar, "ally" ) then 
	            set t = timebonus(udg_Mephistar, MEPHISTAR_E_BLOOD_DURATION)
	            call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Orc\\OrcSmallDeathExplode\\OrcSmallDeathExplode.mdl", GetUnitX( udg_hero[i] ), GetUnitY( udg_hero[i] ) ) )
	            call bufst( udg_Mephistar, udg_hero[i], 'A145', 'B08J', "mephb", t )
	        endif
	        set i = i + 1
	    endloop
	endfunction
	
	private function MephistarECrystal takes nothing returns nothing
	    local integer i
	    
	    call MephistarEFrameGeneral(3)
	    
	    set i = 1
	    loop
	        exitwhen i > PLAYERS_LIMIT
	        if unitst( udg_hero[i], udg_Mephistar, "ally" ) then 
	            call UnitReduceCooldownPercent( udg_hero[i], MEPHISTAR_E_CRYSTAL_COOLDOWN_REDUCTION )
	            call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl", GetUnitX(udg_hero[i]), GetUnitY(udg_hero[i]) ) )
	        endif
	        set i = i + 1
	    endloop
	endfunction
	
	private function MephistarEMech takes nothing returns nothing
	    local integer i
	    local real t
	    
	    call MephistarEFrameGeneral(4)
	    
	    set i = 1
	    loop
	        exitwhen i > PLAYERS_LIMIT
	        if unitst( udg_hero[i], udg_Mephistar, "ally" ) then 
	            set t = timebonus(udg_Mephistar, MEPHISTAR_E_MECH_DURATION)
	            call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", GetUnitX( udg_hero[i] ), GetUnitY( udg_hero[i] ) ) )
	            call bufst( udg_Mephistar, udg_hero[i], 'A146', 'B08K', "mephm", t )
	        endif
	        set i = i + 1
	    endloop
	endfunction
	
	private function MephistarEMoon takes nothing returns nothing
	    local integer i
	    
	    call MephistarEFrameGeneral(5)
	    
	    set i = 1
	    loop
	        exitwhen i > PLAYERS_LIMIT
	        if unitst( udg_hero[i], udg_Mephistar, "ally" ) then 
	            call GroupAoE( udg_Mephistar, null, GetUnitX( udg_hero[i] ), GetUnitY( udg_hero[i] ), MEPHISTAR_E_MOON_DAMAGE, MEPHISTAR_E_MOON_AREA, "enemy", "war3mapImported\\ArcaneExplosion.mdx", null )
	        endif
	        set i = i + 1
	    endloop
	endfunction
	
	private function MephistarENature takes nothing returns nothing
	    local integer i
	    local unit target
	    
	    call MephistarEFrameGeneral(6)
	    
	    set i = 1
	    loop
	        exitwhen i > MEPHISTAR_E_NATURE_TRIGGERS
	        set target = HeroLessHP(udg_Mephistar)
	        if target != null then
	            call healst( udg_Mephistar, target, GetUnitState( target, UNIT_STATE_MAX_LIFE) * MEPHISTAR_E_NATURE_HEAL_PERC )
	            call manast( udg_Mephistar, target, GetUnitState( target, UNIT_STATE_MAX_MANA) * MEPHISTAR_E_NATURE_HEAL_PERC )
	            set target = null
	        endif
	        set i = i + 1
	    endloop
	    
	    set target = null
	endfunction
	
	private function MephistarERing takes nothing returns nothing
	    local integer i
	    local real t
	    
	    call MephistarEFrameGeneral(7)
	    
	    set i = 1
	    loop
	        exitwhen i > PLAYERS_LIMIT
	        if unitst( udg_hero[i], udg_Mephistar, "ally" ) then 
	            set t = timebonus(udg_Mephistar, MEPHISTAR_E_RING_DURATION)
	            call bufst( udg_Mephistar, udg_hero[i], MEPHISTAR_E_RING_EFFECT, MEPHISTAR_E_RING_BUFF, "mephr", t )
	        endif
	        set i = i + 1
	    endloop
	endfunction
	
	private function MephistarERune takes nothing returns nothing
	    local integer i
	    local integer runeLimit
	    
	    if udg_fightmod[3] then
	        set runeLimit = Arena_Runes_NoDuel_Count
	    else
	        set runeLimit = Arena_Runes_Count
	    endif
	    
	    call MephistarEFrameGeneral(8)
	    
	    set i = 1
	    loop
	        exitwhen i > PLAYERS_LIMIT
	        if unitst( udg_hero[i], udg_Mephistar, "ally" ) then 
	            set bj_lastCreatedItem = CreateItem(Arena_Runes[GetRandomInt(1, runeLimit)], GetUnitX( udg_hero[i] ) + GetRandomReal( -300, 300 ), GetUnitY( udg_hero[i] ) + GetRandomReal( -300, 300 ) )
	            call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", GetItemX( bj_lastCreatedItem ), GetItemY( bj_lastCreatedItem ) ) )
	        endif
	        set i = i + 1
	    endloop
	endfunction
	
	private function MephistarEWeapon takes nothing returns nothing
	    local integer i
	    local real t
	    
	    call MephistarEFrameGeneral(9)
	    
	    set i = 1
	    loop
	        exitwhen i > PLAYERS_LIMIT
	        if unitst( udg_hero[i], udg_Mephistar, "ally" ) then 
	            set t = timebonus(udg_Mephistar, MEPHISTAR_E_WEAPON_DURATION)
	            call bufst( udg_Mephistar, udg_hero[i], 'A148', 'B08M', "mephw", t )
	        endif
	        set i = i + 1
	    endloop
	endfunction
	
	private function Cast takes nothing returns nothing
	    local unit caster = udg_Mephistar
	    local integer unitId = GetUnitUserData(caster)
	    
	    if GetLocalPlayer() == GetTriggerPlayer() then
	        call BlzFrameSetVisible( BlzGetTriggerFrame(),false)
			call BlzFrameSetVisible( BlzGetTriggerFrame(),true)
		endif
	
	    if GetUnitState( caster, UNIT_STATE_LIFE) > 0.405 and udg_combatlogic[unitId] then
	        //When optimizing, it is worth considering that the positions of the sets and Mephistar sets are different!
	        if mephbut[1] == BlzGetTriggerFrame() and udg_Set_Alchemy_Number[unitId] > 0 and udg_MephistarUse[1] > 0 and OnCooldown[1] == false then
	            call MephistarEAlchemy()
	        elseif mephbut[2] == BlzGetTriggerFrame() and udg_Set_Blood_Number[unitId] > 0 and udg_MephistarUse[2] > 0 and OnCooldown[2] == false then
	            call MephistarEBlood()
	        elseif mephbut[3] == BlzGetTriggerFrame() and udg_Set_Cristall_Number[unitId] > 0 and udg_MephistarUse[3] > 0 and OnCooldown[3] == false then
	            call MephistarECrystal()
	        elseif mephbut[4] == BlzGetTriggerFrame() and SetCount_GetPieces(caster, SET_MECH) > 0 and udg_MephistarUse[4] > 0 and OnCooldown[4] == false then
	            call MephistarEMech()
	        elseif mephbut[5] == BlzGetTriggerFrame() and udg_Set_Moon_Number[unitId] > 0 and udg_MephistarUse[5] > 0 and OnCooldown[5] == false then
	            call MephistarEMoon()
	        elseif mephbut[6] == BlzGetTriggerFrame() and udg_Set_Nature_Number[unitId] > 0 and udg_MephistarUse[6] > 0 and OnCooldown[6] == false then
	            call MephistarENature()
	        elseif mephbut[7] == BlzGetTriggerFrame() and udg_Set_Ring_Number[unitId] > 0 and udg_MephistarUse[7] > 0 and OnCooldown[7] == false then
	            call MephistarERing()
	        elseif mephbut[8] == BlzGetTriggerFrame() and udg_Set_Rune_Number[unitId] > 0 and udg_MephistarUse[8] > 0 and OnCooldown[8] == false then
	            call MephistarERune()
	        elseif mephbut[9] == BlzGetTriggerFrame() and udg_Set_Weapon_Number[unitId] > 0 and udg_MephistarUse[9] > 0 and OnCooldown[9] == false then
	            call MephistarEWeapon()
	        endif
	    endif
	    
	    set caster = null
	endfunction
	
	private function OnBattleStart_Condition takes nothing returns boolean
		return GetUnitAbilityLevel( udg_FightStart_Unit, ABILITY_ID) > 0
	endfunction
	
	private function OnBattleStart takes nothing returns nothing
		local unit caster = udg_FightStart_Unit
		local integer index = Event_FightStart_Index
		local integer i
		local integer amountToUse
        
        set udg_MephistarUse[1] = udg_Set_Alchemy_Number[index]
        set udg_MephistarUse[2] = udg_Set_Blood_Number[index]
        set udg_MephistarUse[3] = udg_Set_Cristall_Number[index]
        set udg_MephistarUse[4] = SetCount_GetPieces(udg_hero[index], SET_MECH)
        set udg_MephistarUse[5] = udg_Set_Moon_Number[index]
        set udg_MephistarUse[6] = udg_Set_Nature_Number[index]
        set udg_MephistarUse[7] = udg_Set_Ring_Number[index]
        set udg_MephistarUse[8] = udg_Set_Rune_Number[index]
        set udg_MephistarUse[9] = udg_Set_Weapon_Number[index]
        
        set i = 1
        loop
            exitwhen i > 9
            set amountToUse = udg_MephistarUse[i]
            call BlzFrameSetText( mephnum[i], I2S(amountToUse) )
            
            if amountToUse > 0 then
	            call BlzFrameSetTexture( mephicon[i], BlzGetAbilityIcon( udg_DB_SoulContract_Set[i]), 0, true )
	        else
	            call BlzFrameSetTexture( mephicon[i], "ReplaceableTextures\\CommandButtons\\BTNCancel.blp", 0, true )
	        endif
            set i = i + 1
        endloop
        
        set caster = null
    endfunction
	
	private function Enable_Condition takes nothing returns boolean
		return GetUnitAbilityLevel( Event_HeroChoose_Hero, ABILITY_ID) > 0
	endfunction
	
	private function Enable takes nothing returns nothing
		local unit caster = Event_HeroChoose_Hero
	    local integer i
	    
	    set udg_Mephistar = caster
	    
	    if GetLocalPlayer() == GetOwningPlayer( caster ) then
	        call BlzFrameSetVisible( mephuse, true )
	    endif
	    
	    set i = 1
	    loop
	        exitwhen i > 9
	        if udg_MephistarUse[i] > 0 then
	            call BlzFrameSetTexture( mephicon[i], BlzGetAbilityIcon( udg_DB_SoulContract_Set[i] ), 0, true )
	        else
	            call BlzFrameSetTexture( mephicon[i], "ReplaceableTextures\\CommandButtons\\BTNCancel.blp", 0, true )
	        endif
	        set i = i + 1
	    endloop
	    
	    set caster = null
	endfunction
	
	private function Disable_Condition takes nothing returns boolean
		return GetUnitAbilityLevel( Event_HeroRepick_Hero, ABILITY_ID) > 0
	endfunction
	
	private function Disable takes nothing returns nothing
		if GetLocalPlayer() == Event_HeroRepick_Player then
            call BlzFrameSetVisible( mephuse, false )
        endif
	endfunction
	
	private function createUI takes nothing returns nothing
	    local trigger trig
	    local integer i
	
	    set mephuse = BlzCreateFrameByType("BACKDROP", "", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI,0), "StandartFrameTemplate", 0)
	    call BlzFrameSetVisible( mephuse, false )
	    call BlzFrameSetLevel( mephuse, -2 )
	
	    set i = 1
	    loop
	        exitwhen i > udg_DB_SoulContract_SetNum
	        set mephicon[i] = BlzCreateFrameByType("BACKDROP", "",mephuse, "StandartFrameTemplate", 0)
	        call BlzFrameSetSize( mephicon[i], 0.02, 0.02 )
	        call BlzFrameSetAbsPoint(mephicon[i], FRAMEPOINT_CENTER, 0.018+(0.02*i), 0.17)
	        call BlzFrameSetTexture( mephicon[i], "ReplaceableTextures\\CommandButtons\\BTNCancel.blp", 0, true )
	        
	        set mephnum[i] = BlzCreateFrameByType("TEXT", "", mephuse, "StandartFrameTemplate", 0)
	        call BlzFrameSetSize( mephnum[i], 0.01, 0.01 )
	        call BlzFrameSetPoint(mephnum[i], FRAMEPOINT_BOTTOMLEFT, mephicon[i], FRAMEPOINT_BOTTOMLEFT, 0.001,0.001) 
	        call BlzFrameSetText( mephnum[i], "0" )
	        
	        set mephbut[i] = BlzCreateFrameByType("GLUEBUTTON", "", mephuse, "ScoreScreenTabButtonTemplate", 0)
	        call BlzFrameSetSize( mephbut[i], 0.02, 0.02 )
	        call BlzFrameSetPoint( mephbut[i], FRAMEPOINT_CENTER, mephicon[i], FRAMEPOINT_CENTER, 0,0)
	        
	        set trig = CreateTrigger()
	        call BlzTriggerRegisterFrameEvent(trig, mephbut[i], FRAMEEVENT_CONTROL_CLICK)
	        call TriggerAddAction(trig, function Cast)
	        
	        call SetStableTool( mephbut[i], BlzGetAbilityTooltip(udg_DB_SoulContract_Set[i], 0), BlzGetAbilityExtendedTooltip(udg_DB_SoulContract_Set[i], 0) )
	        
	        set inactiveFrame[i] = BlzCreateFrameByType("BACKDROP", "", mephuse, "StandartFrameTemplate", 0)
	        call BlzFrameSetSize( inactiveFrame[i], 0.02, 0.02 )
	        call BlzFrameSetPoint( inactiveFrame[i], FRAMEPOINT_CENTER, mephicon[i], FRAMEPOINT_CENTER, 0,0)
	        call BlzFrameSetTexture( inactiveFrame[i], "ReplaceableTextures\\CommandButtons\\BTNCancel.blp", 0, true )
	        call BlzFrameSetVisible( inactiveFrame[i], false )
	        
	        set i = i + 1
	    endloop
	    
	    set trig = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.5, false, function createUI ) 
	    
	    call CreateEventTrigger( "Event_HeroChoose_Real", function Enable, function Enable_Condition )
		call CreateEventTrigger( "Event_HeroRepick_Real", function Disable, function Disable_Condition )
		call CreateEventTrigger( "udg_FightStart_Real", function OnBattleStart, function OnBattleStart_Condition )
		
		call CreateEventTrigger( "Event_OnDamageChange_Real", function RingDamageBonus, function RingDamageBonus_Condition )
	endfunction

endscope