scope FrozenBlood initializer init

	globals
		private constant integer ITEM_ID = 'I07K'
		
		private constant integer STAT_GAIN = 1
		private constant string ANIMATION = "Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl"
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false and combat( AnyHeroDied.TriggerUnit, false, 0 ) and IsUnitAlive(AnyHeroDied.TriggerUnit) and AnyHeroDied.TriggerUnit != AnyHeroDied.TargetUnit
	endfunction

	private function action takes nothing returns nothing
		local unit caster = AnyHeroDied.GetDataUnit("caster")
		local integer index = GetUnitUserData(caster)
	    
	    call statst( caster, STAT_GAIN, STAT_GAIN, STAT_GAIN, 0, true )
        set udg_Data[index + 4] = udg_Data[index + 4] + STAT_GAIN
        call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( caster ), GetUnitY( caster ) ) )
        
        set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AnyHeroDied, function action, function condition, "caster" )
	endfunction

endscope