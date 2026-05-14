scope DifficultyFive initializer init

	globals
		private integer DIFFICULTY_REQUIRED = 5
		private boolean isActive = false
	endglobals

	private function condition takes nothing returns boolean
	    return isActive == false and Difficulty_GetIndex() >= DIFFICULTY_REQUIRED
	endfunction

	private function action takes nothing returns nothing
		call JuleFrame_RefreshCostIncrease(200)
		call JuleFrame_UpgradeCostIncrease(200)
	    set isActive = true
	endfunction

	private function init takes nothing returns nothing
	    call OnModsAwake.AddListener(function action, function condition)
	endfunction

endscope