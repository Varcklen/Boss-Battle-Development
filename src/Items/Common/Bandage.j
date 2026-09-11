scope NAME initializer init
	
	globals
		private constant integer EFFECT_ID = 'A031'
	endglobals

	private function OnBattleEnd_Condition takes nothing returns boolean
		return GetUnitAbilityLevel(BattleEnd.TriggerUnit, EFFECT_ID) > 0
	endfunction
	
	private function OnBattleEnd takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		
		call UnitRemoveAbility( hero, EFFECT_ID ) 
		
		set hero = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call BattleEnd.AddListener(function OnBattleEnd, function OnBattleEnd_Condition)
	endfunction
	
endscope