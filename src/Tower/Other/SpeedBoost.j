scope SpeedBoost initializer init

	private function RemoveBoost takes nothing returns nothing
		local integer i
		call UnitRemoveAbility( udg_UNIT_DUMMY_BUFF, 'A03U' )
		
		set i = 1
		loop 
			exitwhen i > 4
			if IsUnitAlive(udg_hero[i]) then
				call UnitRemoveAbility( udg_hero[i], 'B00J' )
			endif
			set i = i + 1
		endloop
	endfunction
	
	private function AddBoost takes nothing returns nothing
		call UnitAddAbility( udg_UNIT_DUMMY_BUFF, 'A03U' )
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call BattleStartGlobal.AddListener(function RemoveBoost, null )
		call BattleEndGlobal.AddListener(function AddBoost, null )
		call CreateEventTrigger( "Event_Start", function AddBoost, null )
		call CreateEventTrigger( "Event_Victory", function AddBoost, null )
	endfunction

endscope