scope Bear2 initializer init

	globals
		public trigger Trigger = null
	
		private constant integer EFFECT = 'A1JO'
		private constant integer BUFF = 'B0BA'
		
		private constant string ANIMATION = "Abilities\\Spells\\NightElf\\BattleRoar\\RoarCaster.mdl" 
		private constant real ANIMATION_SIZE = 2
		private constant real DURATION = 20
		private constant real AREA_SIZE = 2000
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitTypeId(udg_DamageEventTarget) == 'n010' and GetUnitLifePercent(udg_DamageEventTarget) <= 40
	endfunction
	
	private function action takes nothing returns nothing
		local unit boss = udg_DamageEventTarget
		local effect roarEffect 
		local group g = CreateGroup()
	    local unit u
		
		call DisableTrigger( GetTriggeringTrigger() )
    	set roarEffect = AddSpecialEffect( ANIMATION, GetUnitX(boss), GetUnitY(boss) )
    	call BlzSetSpecialEffectScale(roarEffect, ANIMATION_SIZE )
    	call DestroyEffect( roarEffect )
    	
    	call GroupEnumUnitsInRange( g, GetUnitX( boss ), GetUnitY( boss ), AREA_SIZE, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, boss, "enemy" ) then
                call bufallst( boss, u, EFFECT, 0, 0, 0, 0, BUFF, "boss_bear_roar", DURATION )
            endif
            call GroupRemoveUnit(g,u)
        endloop
	    
	    call DestroyGroup( g )
	    set boss = null
	    set u = null
	    set g = null
    	set roarEffect = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	    call DisableTrigger( Trigger )
	endfunction

endscope