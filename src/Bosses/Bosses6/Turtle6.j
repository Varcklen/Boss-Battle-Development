scope Turtle6 initializer init

	globals
		public trigger Trigger = null
	
		private constant real DAMAGE_BONUS = 0.15
		private constant string ANIMATION = "Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl"
	endglobals

	private function condition takes nothing returns boolean
	    return IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) and udg_fightmod[0] and combat(GetDyingUnit(), false, 0)
	endfunction
	
	private function action takes nothing returns nothing
		local unit boss = GroupPickRandomUnit( GetUnitsOfPlayerAndTypeId( Player(10), 'h01R' ) )
		local integer attackBonus
		
		if boss == null then
			return
		endif
		
		set attackBonus = R2I( BlzGetUnitBaseDamage(boss, 0) * DAMAGE_BONUS )

        call BlzSetUnitBaseDamage( boss, BlzGetUnitBaseDamage(boss, 0) + attackBonus, 0 )
        call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( boss ), GetUnitY( boss ) ) )
        
	    set boss = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = CreateTrigger(  )
	    call DisableTrigger( Trigger )
	    call TriggerRegisterAnyUnitEventBJ( Trigger, EVENT_PLAYER_UNIT_DEATH )
	    call TriggerAddCondition( Trigger, Condition( function condition ) )
	    call TriggerAddAction( Trigger, function action )
	endfunction

endscope