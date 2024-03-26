scope NaturalDeselection initializer init

globals
	private constant integer COEF = 100
	private constant integer ITEM = 'IZ09'
        
    private constant string ANIMATION = "Abilities\\Spells\\Items\\RitualDagger\\RitualDaggerTarget.mdl"
        
    private integer array Stealed_SpellPower[PLAYERS_LIMIT_ARRAYS]//YourHero
    private integer array Stealed_Luck[PLAYERS_LIMIT_ARRAYS]//YourHero
    private boolean array IsStealed[PLAYERS_LIMIT_ARRAYS]//YourHero
endglobals


private function Steal takes unit hero, unit diedHero, integer amount returns nothing
    local integer diedIndex = GetUnitUserData(diedHero)
    local integer index = GetUnitUserData(hero)
    local integer luck = R2I( udg_lucky[diedIndex] * amount * COEF / 100 )
    local integer spellPower = R2I( (GetUnitSpellPower(diedHero) - 1) * amount * COEF )
    
    set IsStealed[index] = true
    call PlaySpecialEffect(ANIMATION, hero)
        
    call spdst( hero, spellPower )
    call luckyst( hero, luck )
    set Stealed_SpellPower[index] = Stealed_SpellPower[index] + spellPower
    set Stealed_Luck[index] = Stealed_Luck[index] + luck
        
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
    
    
private function FightEnd_Conditions takes nothing returns boolean
    return IsStealed[GetUnitUserData(udg_FightEnd_Unit)]
endfunction
    
private function FightEnd takes nothing returns nothing
    local unit hero = udg_FightEnd_Unit
    local integer index = GetUnitUserData(hero)
        
    set IsStealed[index] = false
    call spdst( hero, -Stealed_SpellPower[index] )
    call luckyst (hero, -Stealed_Luck[index] )
    set Stealed_SpellPower[index] = 0
    set Stealed_Luck[index] = 0
    set hero = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    local trigger trig = CreateTrigger(  )
    //call RegisterDuplicatableItemType(ITEM, EVENT_PLAYER_UNIT_SPELL_EFFECT, function actions, function conditions)
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_HERO_REVIVE_FINISH )
    call TriggerAddCondition( trig, Condition( function conditions ) )
    call TriggerAddAction( trig, function actions )
    call CreateEventTrigger( "udg_FightEnd_Real", function FightEnd, function FightEnd_Conditions )
    set trig = null
endfunction

endscope