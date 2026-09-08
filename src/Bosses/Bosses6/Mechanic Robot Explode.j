scope MechanicRobotExplode initializer init

	globals
		private constant integer DAMAGE = 300
		private constant integer AREA = 300
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitTypeId(GetDyingUnit()) == 'n012'
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = GetDyingUnit()
		
	    call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Human\\HCancelDeath\\HCancelDeath.mdl", GetUnitX( caster ), GetUnitY( caster ) ) )
	    call GroupAoE( caster, GetUnitX( caster ), GetUnitY( caster ), DAMAGE, AREA, "enemy", null, null )
	    
		set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
	endfunction

endscope