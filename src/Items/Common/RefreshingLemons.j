scope Lemons initializer init

globals
	private constant integer COEF = 100
	private constant integer ITEM = 'IZ10'
endglobals

private function conditions takes nothing returns boolean
    return combat( GetTriggerUnit(), false, 0 ) and not(udg_fightmod[3])
endfunction

private function actions takes nothing returns nothing
	local unit u
	local unit rev = GetTriggerUnit()
    local group g
    local integer amount
    local real health = GetUnitState( rev, UNIT_STATE_LIFE )
    
    set health = health * COEF / 100
    set g = DeathSystem_GetAliveHeroGroupCopy()
    loop
    set u = FirstOfGroup(g)
    exitwhen u == null
    	set amount = inv( u, ITEM )
    	if amount > 0 then
            call shield( u, rev, R2I(amount * health) )
    	endif
    	call GroupRemoveUnit( g, u )
    endloop
    set u = null
    set rev = null
    call GroupClear( g )
    call DestroyGroup( g )
    set g = null
endfunction
//===========================================================================
private function init takes nothing returns nothing
    local trigger trig = CreateTrigger(  )
    //call RegisterDuplicatableItemType(ITEM, EVENT_PLAYER_UNIT_SPELL_EFFECT, function actions, function conditions)
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_HERO_REVIVE_FINISH )
    call TriggerAddCondition( trig, Condition( function conditions ) )
    call TriggerAddAction( trig, function actions )
    set trig = null
endfunction

endscope