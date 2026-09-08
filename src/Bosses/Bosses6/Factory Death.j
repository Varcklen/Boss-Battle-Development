scope FactoryDeath initializer init

	globals
		private constant integer ROBOT_TO_SUMMON = 2
		private constant integer ROBOT_SPAWN_DEVIATION = 200
		private constant integer ROBOT_TYPE = 'n012'
	endglobals

	private function condition takes nothing returns boolean
	    return GetUnitTypeId(GetDyingUnit()) == 'n05H'
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = GetDyingUnit()
	    local integer i
		local real x
		local real y
		local real angle
		
		set i = 1
		loop
	        exitwhen i > ROBOT_TO_SUMMON
	        set angle = 45 + 90 * i
	        set x = GetUnitX(caster) + ROBOT_SPAWN_DEVIATION * Cos( angle * bj_DEGTORAD ) 
	        set y = GetUnitY(caster) + ROBOT_SPAWN_DEVIATION * Sin( angle * bj_DEGTORAD ) 
	        call CreateUnit( GetOwningPlayer( caster ), ROBOT_TYPE, x, y, -angle )
	        set i = i + 1
	    endloop
	    
	    set caster = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		call CreateNativeEvent( EVENT_PLAYER_UNIT_DEATH, function action, function condition )
	endfunction

endscope