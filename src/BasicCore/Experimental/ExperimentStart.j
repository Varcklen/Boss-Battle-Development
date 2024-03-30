scope ExperimentStart initializer init

	private function condition takes nothing returns boolean
		return GetUnitAbilityLevel(BeforeAttack.TriggerUnit, 'A1G5') > 0
	endfunction

	private function action takes nothing returns nothing
		local real extraDamage = BeforeAttack.GetDataReal("static_damage") * 0.2
		local real damage = BeforeAttack.GetDataReal("damage") 
	    
	    call BeforeAttack.SetDataReal("damage", damage + extraDamage )
	endfunction
	
	private function Delay takes nothing returns nothing    	
    	call IconFrame( "Cataclysm", "war3mapImported\\BTNAbility_Druid_PredatoryInstincts.blp", "|cffffcc00Cat-aclysm|r", "- Cats deal 20% more damage.|n- Everyone is hidden under masks.|n- Every 20 seconds of combat, 3 blessings and curses change.|n- All players can buy more than 1 quest. All quests cost 50 gold. The Quest Store isn't going away." )
    	
    	call BeforeAttack.AddListener(function action, function condition)
	endfunction
	
	private function init takes nothing returns nothing
		call TimerStart( CreateTimer(), 0.5, false, function Delay )
	endfunction

endscope