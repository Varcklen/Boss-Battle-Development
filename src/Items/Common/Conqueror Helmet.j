scope ConquerorHelmet initializer init

	globals
		private constant integer ITEM_ID = 'I0BM'
		
		private constant real MAX_HEALTH = 0.1
	endglobals
	
    private function condition takes nothing returns boolean
		return inv( BeforeAttack.TargetUnit, ITEM_ID ) > 0 and BeforeAttack.GetDataReal("damage") > GetUnitState( BeforeAttack.TargetUnit, UNIT_STATE_MAX_LIFE) * MAX_HEALTH
	endfunction
	
	private function action takes nothing returns nothing
		local real newValue = GetUnitState( BeforeAttack.TargetUnit, UNIT_STATE_MAX_LIFE) * MAX_HEALTH
		call BeforeAttack.SetDataReal("damage", newValue)
	endfunction

	private function init takes nothing returns nothing
		call BeforeAttack.AddListener(function action, function condition)
	endfunction

endscope