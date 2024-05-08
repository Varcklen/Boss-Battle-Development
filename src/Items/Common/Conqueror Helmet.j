scope ConquerorHelmet initializer init

	globals
		private constant integer ITEM_ID = 'I0BM'
		
		private constant real MAX_HEALTH = 0.1
	endglobals
	
    private function condition takes nothing returns boolean
		return inv( udg_DamageEventTarget, ITEM_ID ) > 0 and udg_DamageEventAmount > GetUnitState( udg_DamageEventTarget, UNIT_STATE_MAX_LIFE) * MAX_HEALTH
	endfunction
	
	private function action takes nothing returns nothing
		set udg_DamageEventAmount = GetUnitState( udg_DamageEventTarget, UNIT_STATE_MAX_LIFE) * MAX_HEALTH
	endfunction

	private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_DamageEventAfterArmor", function action, function condition )
	endfunction

endscope