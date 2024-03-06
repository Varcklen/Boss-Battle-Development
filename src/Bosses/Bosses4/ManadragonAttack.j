scope ManadragonAttack initializer init
	
	globals
		private constant integer MANA_CONDITION = 30
		private constant integer EXTRA_DAMAGE = 100
		private constant integer MANA_BURN = 40
		
		private constant string ANIMATION = "Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveDamage.mdl"
	endglobals
	
	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell == false and GetUnitTypeId(udg_DamageEventSource) == 'e004' and IsUnitType( udg_DamageEventTarget, UNIT_TYPE_HERO)
	endfunction

	private function action takes nothing returns nothing
		local real targetMana = GetUnitState( udg_DamageEventTarget, UNIT_STATE_MANA )
		local real manaToBurn = MANA_BURN * GetUnitSpellPower(udg_DamageEventSource)
		
        if targetMana <= MANA_CONDITION then
            set udg_DamageEventAmount = udg_DamageEventAmount + EXTRA_DAMAGE 
            //call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX(udg_DamageEventTarget), GetUnitY(udg_DamageEventTarget) ) )
        endif
        call DestroyEffect( AddSpecialEffectTarget( ANIMATION, udg_DamageEventTarget, "origin" ) )
        call SetUnitState( udg_DamageEventTarget, UNIT_STATE_MANA, RMaxBJ(0, targetMana - manaToBurn  ) )
	endfunction

	private function init takes nothing returns nothing
	    local trigger trig = CreateTrigger(  )
	    call TriggerRegisterVariableEvent( trig, "udg_AfterDamageEvent", EQUAL, 1.00 )
	    call TriggerAddCondition( trig, Condition( function condition ) )
	    call TriggerAddAction( trig, function action )
	endfunction

endscope