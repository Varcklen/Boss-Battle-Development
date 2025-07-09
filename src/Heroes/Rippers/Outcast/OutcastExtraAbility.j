scope OutcastExtraAbility initializer init

	globals
		private constant integer ABILITY_ID = 'A1H8'
		private constant integer KEY_TIMER = StringHash("outcast_extra")
		private constant real CHECK_INTERVAL = 1
	endglobals
	
	private function CheckStats takes nothing returns nothing
		local integer id = GetHandleId( GetExpiredTimer() )
		local unit hero = LoadUnitHandle( udg_hash, id, StringHash("outcast_extra_hero") )
		local integer agiCheck = LoadInteger(udg_hash, id, StringHash("outcast_extra_agi") )
		local integer intCheck = LoadInteger(udg_hash, id, StringHash("outcast_extra_int") )
		local integer agi = GetHeroAgi(hero, true)
		local integer int = GetHeroInt(hero, true)
		local integer attackToAdd = 0
		local integer attackAdded = LoadInteger(udg_hash, id, StringHash("outcast_extra_added") )
		
		set attackToAdd = attackToAdd + (agi - agiCheck)
		set attackToAdd = attackToAdd + (int - intCheck)
		if attackToAdd != 0 then
			call BlzSetUnitBaseDamage( hero, BlzGetUnitBaseDamage(hero, 0) + attackToAdd, 0 )
		endif
		call SaveInteger(udg_hash, id, StringHash("outcast_extra_agi"), agi )
		call SaveInteger(udg_hash, id, StringHash("outcast_extra_int"), int )
		call SaveInteger(udg_hash, id, StringHash("outcast_extra_added"), attackAdded + attackToAdd )
		
		set hero = null
	endfunction
	
	private function Enable_Check takes nothing returns boolean
	    return GetUnitAbilityLevel( Event_HeroChoose_Hero, ABILITY_ID) > 0
	endfunction
	
	private function Enable takes nothing returns nothing
		local unit hero = Event_HeroChoose_Hero
		local integer id
        local timer timerUsed = null
        
        set id = GetHandleId( hero )
        if LoadTimerHandle( udg_hash, id, KEY_TIMER ) == null then
            call SaveTimerHandle( udg_hash, id, KEY_TIMER, CreateTimer() )
        endif
        set timerUsed = LoadTimerHandle( udg_hash, id, KEY_TIMER )
        set id = GetHandleId( timerUsed ) 
        call SaveUnitHandle( udg_hash, id, StringHash("outcast_extra_hero"), hero )
        call TimerStart( timerUsed, CHECK_INTERVAL, true, function CheckStats )
        
        set timerUsed = null
		set hero = null
	endfunction
	
	private function Disable_Check takes nothing returns boolean
	    return GetUnitAbilityLevel( Event_HeroRepick_Hero, ABILITY_ID) > 0
	endfunction
	
	private function Disable takes nothing returns nothing
		local unit hero = Event_HeroRepick_Hero
		local timer timerUsed = LoadTimerHandle( udg_hash, GetHandleId( hero ), KEY_TIMER )
		local integer id = GetHandleId( timerUsed ) 
		local integer attackAdded = LoadInteger(udg_hash, id, StringHash("outcast_extra_added") )
		
		call BlzSetUnitBaseDamage( hero, BlzGetUnitBaseDamage(hero, 0) - attackAdded, 0 )
		call FlushChildHashtable( udg_hash, id )
        call DestroyTimer( timerUsed )
		
		set timerUsed = null
		set hero = null
	endfunction
	
	private function init takes nothing returns nothing
	    call CreateEventTrigger( "Event_HeroChoose_Real", function Enable, function Enable_Check )
		call CreateEventTrigger( "Event_HeroRepick_Real", function Disable, function Disable_Check )
	endfunction

endscope