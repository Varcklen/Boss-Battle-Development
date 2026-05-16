scope DarkWarlock4 initializer init

	globals
		private constant integer HEALTH_BURN = 25
		private constant integer BUFF = 'B0AW'
		private constant string ANIMATION = "Abilities\\Spells\\Undead\\DeathCoil\\DeathCoilSpecialArt.mdl"
		
		public trigger Trigger = null
	endglobals

	private function condition takes nothing returns boolean
	    return UnitHasBuffBJ(GetSpellAbilityUnit(), BUFF)
	endfunction

	private function action takes nothing returns nothing
		local unit caster = GetSpellAbilityUnit()
		
        call DestroyEffect( AddSpecialEffectTarget( ANIMATION, caster, "origin" ) )
        call SetUnitState( caster, UNIT_STATE_LIFE, RMaxBJ(0, GetUnitState( caster, UNIT_STATE_LIFE ) - HEALTH_BURN ) )
        
        set caster = null
	endfunction

	private function init takes nothing returns nothing
	    set Trigger = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
	    call DisableTrigger( Trigger )
	endfunction

endscope