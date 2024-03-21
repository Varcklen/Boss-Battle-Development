scope SealOfRevenge initializer init

	globals
		private constant integer ITEM_ID = 'I06W'
		
		private constant integer RANGE = 600
		private constant integer DAMAGE = 50
		private constant string ANIMATION = "Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl"
	endglobals
	
	private function condition takes nothing returns boolean
		return  IsUnitAlive( AnyUnitDied.TriggerUnit) and GetOwningPlayer(AnyUnitDied.TriggerUnit) == GetOwningPlayer(AnyUnitDied.TargetUnit)
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = AnyUnitDied.GetDataUnit("caster")
		local unit unitDied = AnyUnitDied.GetDataUnit("unit_died")
		local unit target
		
        set target = randomtarget( unitDied, RANGE, "enemy", "", "", "", "" )
        if target != null then
            call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( target ), GetUnitY( target ) ) )
            call UnitDamageTarget( caster, target, DAMAGE, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
        endif

		set target = null
        set caster = null
        set unitDied = null
	endfunction

	private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, AnyUnitDied, function action, function condition, "caster")
	endfunction

endscope