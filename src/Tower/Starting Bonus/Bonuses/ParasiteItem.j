scope ParasiteItem initializer init

	globals
		private constant integer ITEM_TYPE = 'IV37'
	endglobals

	//===========================================================================
	private function OnEnd_Condition takes nothing returns boolean
		return ExtraArenaGeneral_IsPvPActive() == false and inv(BattleEnd.GetDataUnit("caster"), ITEM_TYPE) > 0
	endfunction

	private function OnEnd takes nothing returns nothing
		local unit hero = BattleEnd.GetDataUnit("caster")
		local item itemToDestroy = GetItemOfTypeFromUnitBJ( hero, ITEM_TYPE)
		
		call RemoveItem(itemToDestroy)

		set itemToDestroy = null
		set hero = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call BattleEnd.AddListener(function OnEnd, function OnEnd_Condition)
	endfunction

endscope