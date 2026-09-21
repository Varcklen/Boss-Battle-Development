scope SharpDeck initializer init
	
	globals
		private constant integer ITEM_ID = 'I0D2'
	endglobals

	private function condition takes nothing returns boolean
		return BattleData_CheckBattleType( BATTLE_TYPE_MAIN ) and BattleEnd.GetDataBoolean("is_win")
	endfunction
	
	private function action takes nothing returns nothing
		local player user = BattleEnd.GetDataPlayer("owner")
		
		call ItemRandomizerLib_AddRewardSelectionOption(user, 1)
		
		set user = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition, null)
	endfunction
	
endscope