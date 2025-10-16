scope NaturalDeselection initializer init

globals
	private constant integer COEF = 100
	private constant integer ITEM = 'IZ09'
        
    private constant string ANIMATION = "Abilities\\Spells\\Items\\RitualDagger\\RitualDaggerTarget.mdl"
        
    private integer array Stealed_SpellPower[PLAYERS_LIMIT_ARRAYS][PLAYERS_LIMIT_ARRAYS]//YourHero/DeadHero
    private integer array Stealed_Luck[PLAYERS_LIMIT_ARRAYS][PLAYERS_LIMIT_ARRAYS]//YourHero/DeadHero
    private boolean array IsStealed[PLAYERS_LIMIT_ARRAYS][PLAYERS_LIMIT_ARRAYS]//YourHero
endglobals


private function Steal takes unit hero, unit diedHero, integer amount returns nothing
    local integer diedIndex = GetUnitUserData(diedHero)
    local integer index = GetUnitUserData(hero)
    local integer luck = R2I( GetUnitLuckFlat(diedHero) * amount * COEF / 100 )
    local integer spellPower = R2I( (GetUnitSpellPower(diedHero) - 1) * amount * COEF )
    //local integer oldSP = Stealed_SpellPower[index][diedIndex]
    //local integer oldLUCK = Stealed_Luck[index][diedIndex]
    
    set luck = IMaxBJ(0 , luck )
    set spellPower = IMaxBJ(0 , spellPower )
    
    set IsStealed[index][diedIndex] = true
    call PlaySpecialEffect(ANIMATION, hero)
        
    call spdst( hero, spellPower )
    call luckyst( hero, luck )
    set Stealed_SpellPower[index][diedIndex] = spellPower
    set Stealed_Luck[index][diedIndex] = luck
        
    set hero = null
    set diedHero = null
endfunction


private function conditions takes nothing returns boolean
    return combat( GetTriggerUnit(), false, 0 ) and not(udg_fightmod[3])
endfunction

private function actions takes nothing returns nothing
	local unit u
	local unit rev = GetTriggerUnit()
    local group g
    local integer amount
    set g = DeathSystem_GetAliveHeroGroupCopy()
    call GroupRemoveUnit( g, rev )
    loop
    	set u = FirstOfGroup(g)
    	exitwhen u == null
    	set amount = inv( u, ITEM )
    	if amount > 0 then
            call Steal( u, rev, amount )
    	endif
    	call GroupRemoveUnit( g, u )
    endloop
    set u = null
    set rev = null
    call GroupClear( g )
    call DestroyGroup( g )
    set g = null
endfunction
    

private function GetIsStealed takes unit hero, boolean reversed returns boolean
    local boolean isWork = false
    local integer i = 1
    local integer index = GetUnitUserData(hero)
    if reversed then
        loop
            exitwhen i > PLAYERS_LIMIT or isWork
            if IsStealed[i][index] then
                set isWork = true
            endif
            set i = i + 1
        endloop
    else
        loop
            exitwhen i > PLAYERS_LIMIT or isWork
            if IsStealed[index][i] then
                set isWork = true
            endif
            set i = i + 1
        endloop
    endif
    set hero = null
    return isWork
endfunction  

private function FightEnd_Conditions takes nothing returns boolean
    return GetIsStealed(udg_FightEnd_Unit, false)
endfunction
    
private function FightEnd takes nothing returns nothing
    local unit hero = udg_FightEnd_Unit
    local integer index = GetUnitUserData(hero)
    local integer i 
        
    set i = 1
    loop
        exitwhen i > PLAYERS_LIMIT
        if IsStealed[index][i] then
            set IsStealed[index][i] = false
            call spdst( hero, -Stealed_SpellPower[index][i] )
            call luckyst (hero, -Stealed_Luck[index][i] )
            set Stealed_SpellPower[index][i] = 0
            set Stealed_Luck[index][i] = 0
        endif
        set i = i + 1
    endloop

    set hero = null
endfunction
    
//---------


private function conditionsDeath takes nothing returns boolean
    return combat(AnyHeroDied.GetDataUnit("unit_died"), false, 0 ) and not(udg_fightmod[3]) and GetIsStealed(udg_FightEnd_Unit, true)
endfunction

private function actionsDeath takes nothing returns nothing
	local unit u  = AnyHeroDied.GetDataUnit("unit_died")
	local integer index = GetUnitUserData(u)
    local integer i
    
    set i = 1
    loop
        exitwhen i > PLAYERS_LIMIT
        if IsStealed[i][index] then
            set IsStealed[i][index] = false
            set u = udg_hero[i]
            call spdst( u, -Stealed_SpellPower[i][index] )
            call luckyst (u, -Stealed_Luck[i][index] )
            set Stealed_SpellPower[i][index] = 0
            set Stealed_Luck[i][index] = 0
        endif
        set i = i + 1
    endloop
    
    set u = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    local trigger trig = CreateTrigger(  )
    //call RegisterDuplicatableItemType(ITEM, EVENT_PLAYER_UNIT_SPELL_EFFECT, function actions, function conditions)
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_HERO_REVIVE_FINISH )
    call TriggerAddCondition( trig, Condition( function conditions ) )
    call TriggerAddAction( trig, function actions )
    call CreateEventTrigger( "udg_FightEnd_Real", function FightEnd, function FightEnd_Conditions )
    
    /*local trigger trigDead = CreateTrigger(  )
    //call RegisterDuplicatableItemType(ITEM, EVENT_PLAYER_UNIT_SPELL_EFFECT, function actions, function conditions)
    call TriggerRegisterAnyUnitEventBJ( trigDead, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition( trigDead, Condition( function conditionsDeath ) )
    call TriggerAddAction( trigDead, function actionsDeath )*/
    
    call AnyHeroDied.AddListener(function actionsDeath, function conditionsDeath)
    
    set trig = null
    //set trigDead = null
endfunction

endscope