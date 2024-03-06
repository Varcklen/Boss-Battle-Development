scope DoctorE initializer init

	globals
		unit Event_DoctorE_Hero = null
		real Event_DoctorE = 0	
		
		private constant integer ABILITY_ID = 'A04L'
		private constant string ANIMATION = "Abilities\\Spells\\Human\\Defend\\DefendCaster.mdl"
		
		private constant integer ATTACK_REDUCTION_INITIAL = 1
		private constant integer ATTACK_REDUCTION_PER_LEVEL = 1
		
		private constant integer RANGE = 500
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitAbilityLevel( Event_DoctorE_Hero, ABILITY_ID) > 0
	endfunction
    
    private function action takes nothing returns nothing
    	local unit caster = Event_DoctorE_Hero
        local integer level = GetUnitAbilityLevel( caster, ABILITY_ID)
        local integer attackReduction = ATTACK_REDUCTION_INITIAL + (ATTACK_REDUCTION_PER_LEVEL * level)
        local group g = CreateGroup()
        local unit u
        local integer attack

        call GroupEnumUnitsInRange( g, GetUnitX( caster ), GetUnitY( caster ), RANGE, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            set attack = BlzGetUnitBaseDamage(u, 0)
            if unitst( u, caster, "enemy" ) and attack > attackReduction and IsUnitType( u, UNIT_TYPE_HERO ) == false then
                call BlzSetUnitBaseDamage( u, attack - attackReduction, 0 )
                call DestroyEffect( AddSpecialEffectTarget( ANIMATION, u, "origin" ) )
            endif
            call GroupRemoveUnit(g,u)
        endloop

        call DestroyGroup( g )
        set u = null
        set g = null
        set caster = null
	endfunction
        
    private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterVariableEvent( trig, "Event_DoctorE", EQUAL, 1.00 )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope