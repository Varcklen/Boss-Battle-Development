scope ChaosLordE initializer init

	globals
		private constant integer ABILITY_ID = 'A0LK'
		
		private constant integer MAX_EFFECTS = 12
		
		private boolean array IsActive[5]
		private boolean Effect12_IsActive = false
		private integer Effect12_Amount = 0
		
		private constant string INFO_ICON_ID = "lord_of_chaos_e_"
		private constant string INFO_ICON = "war3mapImported\\PASChaosP.blp"
	endglobals

	private function sheepCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "sheepmad" ) )
	    local rect rectUsed = LoadRectHandle( udg_hash, id, StringHash( "sheepm" ) )
	    local integer pattern = LoadInteger( udg_hash, id, StringHash( "sheeppat" ) )
	    local location locSummon = null
	    
	    if combat(caster, false, 0) == false or pattern != udg_Pattern then
	        call DestroyTimer( GetExpiredTimer() )
	    else
	    	set locSummon = GetRandomLocInRect(rectUsed)
	        set bj_lastCreatedUnit = CreateUnitAtLoc( GetOwningPlayer( caster ), ID_SHEEP, locSummon, GetRandomReal( 0, 360 ) )
	        call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )
	    endif
	    
	    call RemoveLocation(locSummon)
	    set rectUsed = null
	    set caster = null
	    set locSummon = null
	endfunction
	
	private function RemorseUse takes unit caster, integer damage returns nothing
		local group g = CreateGroup()
	    local unit u
	    
	    call GroupEnumUnitsInRect( g, udg_Boss_Rect, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if unitst( u, caster, "enemy" ) then
	            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl", GetUnitX( u ), GetUnitY( u ) ) )
	            call UnitDamageTarget( caster, u, damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    call DestroyGroup( g )
	    set g = null
	    set u = null
	endfunction
	
	private function RemorseCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "remmad" ) )
	    local integer damage = LoadInteger( udg_hash, id, StringHash( "remmad" ) )
	    
	    if combat(caster, false, 0) == false then
	    	call DestroyTimer(GetExpiredTimer())
	    else
	    	call RemorseUse(caster, damage)
    	endif
	    
	    set caster = null
	endfunction
	
	private function Effect1 takes unit caster, integer lvl, integer index returns nothing
		local integer value
		
		set value = lvl / 2 + 1
        call RessurectionPoints( value, false )
        
        call textst( "|c00FF6000 Resurrection!", caster, 64, 90, 15, 3 )
        call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Resurrection", "Gives additional " + I2S(value) + " resurrections for this battle." )
	endfunction
	
	private function Effect2 takes unit caster, integer lvl, integer index returns nothing
		local integer i = 1
		local integer iMax = lvl
		
        loop
            exitwhen i > iMax
            call CreateNUnitsAtLoc( 1, 'h01L', Player(PLAYER_NEUTRAL_AGGRESSIVE), GetRandomLocInRect(udg_Boss_Rect), 270 )
            set i = i + 1
        endloop
        
        call textst( "|c00FF6000 Chests!", caster, 64, 90, 15, 3 )
        call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Chests", "Creates " + I2S(lvl) + " chests with loot in the arena." )
	endfunction
	
	private function Effect3 takes unit caster, integer lvl, integer index returns nothing  
		local integer i
		local integer iMax
		local integer k
		local unit hero
		
        set k = 1
        loop
            exitwhen k > 4
            set hero = udg_hero[k]
            set i = 1
            set iMax = lvl
            loop
                exitwhen i > iMax 
                if IsUnitAlive(hero) then
                    if UnitInventoryCount(hero) < UnitInventorySize(hero) then
                        call ItemRandomizer( hero, "legendary" )
                    else
                        set i = iMax
                    endif
                endif 
                set i = i + 1
            endloop
            set k = k + 1
        endloop
        
        call textst( "|c00FF6000 Legendary Gifts!", caster, 64, 90, 15, 3 )
        call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Legendary Gifts", "Gives each player up to " + I2S(lvl) + " Legendary Artifacts." )
        
        set hero = null
	endfunction
	
	private function Effect4 takes unit caster, integer lvl, integer index returns nothing
        call UnitAddAbility( caster, 'A0QM' )
        call SetUnitAbilityLevel( caster, 'A0NB', lvl )
        
        call textst( "|c00FF6000 Wrath!", caster, 64, 90, 15, 3 )
        call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Wrath", "Increases caster's Attack Damage by " + I2S(lvl*20) + "%." )
	endfunction
	
	private function Effect5 takes unit caster, integer lvl, integer index returns nothing
		local integer id
		local integer damage = lvl * 300
		
		call RemorseUse(caster, damage)
		
		set id = InvokeTimerWithUnit( caster, "remmad", 30, true, function RemorseCast )
		call SaveInteger( udg_hash, id, StringHash( "remmad" ), damage )
		call SaveInteger( udg_hash, id, StringHash( "remmap" ), udg_Pattern)
        
        call textst( "|c00FF6000 Remorse!", caster, 64, 90, 15, 3 )
        call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Remorse", "Deal " + I2S(damage) + " damage to all enemies immediately, and then every 30 seconds." )
	endfunction
	
	private function Effect6 takes unit caster, integer lvl, integer index returns nothing
        set udg_logic[34] = true
        call textst( "|c00FF6000 Apocalypse of Magic!", caster, 64, 90, 15, 3 )
        call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Apocalypse of Magic", "Any cast also uses a random ability." )
	endfunction
	
	private function Effect7 takes unit caster, integer lvl, integer index returns nothing
		local integer runeMin
		local integer i
		local integer spawnAmount = 7 * lvl
		local item itemCreated
		
        if udg_fightmod[3] then
            set runeMin = 5
        else
            set runeMin = 1
        endif
        
        set i = 1
        set spawnAmount = 7 * lvl
        loop
            exitwhen i > spawnAmount
            set itemCreated = CreateItem( 'I03J' + GetRandomInt( runeMin, 6 ), GetRandomReal(GetRectMinX(udg_Boss_Rect), GetRectMaxX(udg_Boss_Rect)), GetRandomReal(GetRectMinY(udg_Boss_Rect), GetRectMaxY(udg_Boss_Rect)) )
            call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", GetItemX( itemCreated ), GetItemY( itemCreated ) ) )
            set i = i + 1
        endloop
        
        call textst( "|c00FF6000 Runes!", caster, 64, 90, 15, 3 )
        call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Runes", "Creates " + I2S(spawnAmount) + " runes in the arena." )
        
        set itemCreated = null
	endfunction
	
	private function Effect8 takes unit caster, integer lvl, integer index returns nothing
		local integer summonAmount
		local group g
		local unit u
		local integer i
		
		set summonAmount = IMaxBJ(1, lvl - 1)
		set summonAmount = IMinBJ(summonAmount, udg_Heroes_Amount)

		set i = summonAmount
        set g = DeathSystem_GetAliveHeroGroupCopy()
        loop
            set u = GroupPickRandomUnit(g)
            exitwhen u == null or i <= 0
            if IsUnitAlive(u) and IsUnitAlly( u, GetOwningPlayer( caster ) ) then
                call Superbot( u )
                set i = i - 1
            endif
            call GroupRemoveUnit(g,u)
        endloop
        
        call textst( "|c00FF6000 Superbot!", caster, 64, 90, 15, 3 )
        call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Superbot", "Puts up to " + I2S(summonAmount) + " heroes in Superbot-5000." )
        
        call DestroyGroup(g)
        set u = null
        set g = null
	endfunction
	
	private function Effect9 takes unit caster, integer lvl, integer index returns nothing
		local integer id
		local real cooldown = 10./IMaxBJ( 1, lvl )
		
		set id = InvokeTimerWithUnit( caster, "sheepmad", cooldown, true, function sheepCast )
		call SaveRectHandle( udg_hash, id, StringHash( "sheepm" ), udg_Boss_Rect )
		call SaveInteger( udg_hash, id, StringHash( "sheeppat" ), udg_Pattern )
	
		call textst( "|c00FF6000 Sheep Landing!", caster, 64, 90, 15, 3 )
		call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Sheep Landing", "Every " + I2S(R2I(cooldown)) + " seconds summons a sheep in the arena." )
	endfunction
	
	private function Effect10 takes unit caster, integer lvl, integer index returns nothing
		local integer i
		local integer tentaclesSummoned = 10 * lvl
		local location locSummon = null

		set i = 1
        loop
            exitwhen i > tentaclesSummoned
            set locSummon = GetRandomLocInRect(udg_Boss_Rect)
	        set bj_lastCreatedUnit = CreateUnitAtLoc( GetOwningPlayer( caster ), 'n03F', locSummon, GetRandomReal( 0, 360 ) )
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )
            call RemoveLocation(locSummon)
            set i = i + 1
        endloop
        
        call textst( "|c00FF6000 Tentacles!", caster, 64, 90, 15, 3 )
        call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Tentacles", "Summons " + I2S(tentaclesSummoned) + " Tentacles to the arena." )
        
        set locSummon = null
	endfunction
	
	private function goldCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "lord_gold_rain" ) )
	    local item itemCreated
	    local location locSummon = null
	    
	    if combat(caster, false, 0) == false  then
	        call DestroyTimer( GetExpiredTimer() )
	    else
	    	set locSummon = GetRandomLocInRect(udg_Boss_Rect)
	        set itemCreated = CreateItemLoc( 'I0HB', locSummon )
	        call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", GetItemX( itemCreated ), GetItemY( itemCreated ) ) )
	    endif
	    
	    call RemoveLocation(locSummon)
	    set itemCreated = null
	    set caster = null
	    set locSummon = null
	endfunction
	
	private function Effect11 takes unit caster, integer lvl, integer index returns nothing
		local integer id
		local real cooldown = 2.5/RMaxBJ( 1, lvl )
		
		call InvokeTimerWithUnit( caster, "lord_gold_rain", cooldown, true, function goldCast )
	
		call textst( "|c00FF6000 Gold Rain!", caster, 64, 90, 15, 3 )
		call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Gold Rain", "Every " + R2SW(cooldown, 1, 1) + " seconds summons a small gold coin in the arena." )
	endfunction
	
	private function Effect12End takes nothing returns nothing
		local integer k
		local unit hero
		
        set k = 1
        loop
            exitwhen k > 4
            set hero = udg_hero[k]
            if hero != null then
            	call StatSystem_Add( hero, STAT_COOLDOWN, Effect12_Amount)
        	endif
            set k = k + 1
        endloop
        set Effect12_IsActive = false
        set Effect12_Amount = 0
		set hero = null
	endfunction
	
	private function Effect12 takes unit caster, integer lvl, integer index returns nothing
		local integer k
		local unit hero
		local integer toReduce = 10 * lvl
		
    	set k = 1
        loop
            exitwhen k > 4
            set hero = udg_hero[k]
            if hero != null then
            	call StatSystem_Add( hero, STAT_COOLDOWN, -toReduce)
        	endif
            set k = k + 1
        endloop
        set Effect12_Amount = Effect12_Amount + toReduce
        set Effect12_IsActive = true
        
		call textst( "|c00FF6000 Overload!", caster, 64, 90, 15, 3 )
		call IconFrame( INFO_ICON_ID + I2S(index), INFO_ICON, "Overload", "Reduces the cooldown of abilities and items of all heroes by " + I2S(toReduce) + "%." )
		
		set hero = null
	endfunction
	
	private function madness takes unit caster, integer lvl returns nothing
	    local integer rand
	    local integer index = CorrectPlayer(caster)

	    if udg_fightmod[3] then
	        set rand = GetRandomInt( 5,MAX_EFFECTS )
	    else
	        set rand = GetRandomInt( 1,MAX_EFFECTS )
	    endif
	    
	    set IsActive[index] = true
	
	    if rand == 1 then
	    	call Effect1(caster, lvl, index)
	    elseif rand == 2 then
	    	call Effect2(caster, lvl, index)
	    elseif rand == 3 then
	    	call Effect3(caster, lvl, index)
	    elseif rand == 4 then
	    	call Effect11(caster, lvl, index)
	    elseif rand == 5 then
	    	call Effect4(caster, lvl, index)
	    elseif rand == 6 then
	    	call Effect6(caster, lvl, index)
	    elseif rand == 7 then
	    	call Effect7(caster, lvl, index)
	    elseif rand == 8 then
	    	call Effect8(caster, lvl, index)
	    elseif rand == 9 then
	    	call Effect9(caster, lvl, index)
	    elseif rand == 10 then
	    	call Effect10(caster, lvl, index)
    	elseif rand == 11 then
    		call Effect5(caster, lvl, index)
		elseif rand == 12 then
    		call Effect12(caster, lvl, index)
	    endif
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
    private function condition_end takes nothing returns boolean
	    return IsActive[CorrectPlayer(BattleEnd.TriggerUnit)]
	endfunction
	
	private function action_end takes nothing returns nothing
		local unit caster = BattleEnd.GetDataUnit("caster")
		local integer i = CorrectPlayer(caster)
		
		set IsActive[i] = false
		call IconFrameDel( INFO_ICON_ID + I2S(i) )
		
		if Effect12_IsActive then
			call Effect12End()
		endif
		
	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call BattleStart.AddListener(function action, function condition)
	    call BattleEnd.AddListener(function action_end, function condition_end)
	endfunction

endscope