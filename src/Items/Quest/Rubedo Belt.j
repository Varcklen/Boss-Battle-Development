scope RubedoBelt initializer init
	
	globals
		private constant integer ITEM_ID = 'I0EJ'
		private constant integer EFFECT_ID = 'A0VX'
		private constant integer BUFF_ID = 'B085'
	endglobals

	private function OnBattleStart_Condition takes nothing returns boolean
		return inv( BattleStart.TriggerUnit, ITEM_ID) > 0 and not(udg_fightmod[3])
	endfunction
	
	private function OnBattleStart takes nothing returns nothing
		local unit hero = BattleStart.GetDataUnit("caster")
		
		call UnitAddAbility( hero, EFFECT_ID )
		
		set hero = null
	endfunction
	
	//===========================================================================
	private function OnBattleEnd_Condition takes nothing returns boolean
		return GetUnitAbilityLevel(BattleEnd.TriggerUnit, BUFF_ID) > 0
	endfunction
	
	private function OnBattleEnd takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		
		call UnitRemoveAbility(hero, EFFECT_ID)
        call UnitRemoveAbility(hero, BUFF_ID)  
		
		set hero = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call BattleStart.AddListener(function OnBattleStart, function OnBattleStart_Condition)
		call BattleEnd.AddListener(function OnBattleEnd, function OnBattleEnd_Condition)
	endfunction
	
endscope