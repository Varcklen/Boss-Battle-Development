scope GratefulDead initializer init

globals
	private constant integer BONUS = 200
	private constant integer ITEM = 'IZGD'
        
    private integer array Gained[PLAYERS_LIMIT_ARRAYS]//YourHero
endglobals

private function conditions takes nothing returns boolean
    return Gained[ GetUnitUserData( GetTriggerUnit() ) ] > 0
endfunction

private function actions takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local integer index = GetUnitUserData(u)

	call spdst( u, -Gained[index] )
    set Gained[index] = 0
    
    set u = null
endfunction

private function FightEnd_Conditions takes nothing returns boolean
    return Gained[ GetUnitUserData( udg_FightEnd_Unit ) ] > 0
endfunction
    
private function FightEnd takes nothing returns nothing
    local unit hero = udg_FightEnd_Unit
    local integer index = GetUnitUserData(hero)
        
    call spdst( hero, -Gained[index] )
    set Gained[index] = 0

    set hero = null
endfunction
    
//---------


private function conditionsDeath takes nothing returns boolean
    return combat(AnyHeroDied.GetDataUnit("unit_died"), false, 0 ) and not(udg_fightmod[3])
endfunction

private function actionsDeath takes nothing returns nothing
	local unit u  = AnyHeroDied.GetDataUnit("unit_died")
	local integer index = GetUnitUserData(u)
    local integer toAdd
    local integer amount
    
    set amount = inv( u, ITEM )
    if amount > 0 then
    	set toAdd = BONUS * amount
    	set Gained[index] = toAdd + Gained[index]
		call spdst( u, toAdd )
    endif
    
    set u = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    call CreateNativeEvent( EVENT_PLAYER_HERO_REVIVE_FINISH, function actions, function conditions )
    call AnyHeroDied.AddListener(function actionsDeath, function conditionsDeath)
    call CreateEventTrigger( "udg_FightEnd_Real", function FightEnd, function FightEnd_Conditions )
endfunction

endscope