scope DifficultyOne initializer init

	globals
		private integer DIFFICULTY_REQUIRED = 1
		private real GOLD_GAIN_PERCENT_DECREASE = 0.3
		private boolean isActive = false
	endglobals

	private function condition takes nothing returns boolean
	    return isActive == false and Difficulty_GetIndex() >= DIFFICULTY_REQUIRED
	endfunction

	private function action takes nothing returns nothing
	    call ExtraArenaGeneral_AddGoldGainMultiplier(-GOLD_GAIN_PERCENT_DECREASE)
	    set isActive = true
	endfunction

	private function init takes nothing returns nothing
	    call OnModsAwake.AddListener(function action, function condition)
	endfunction

endscope