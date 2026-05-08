scope PumpkinPie initializer init

	globals
		private integer ITEM_TYPE = 'IV17'
		private integer ATTACK_GAIN = 15
		private integer SPELL_POWER_GAIN = 10
	endglobals

	private function condition takes nothing returns boolean
		return GetItemTypeId(GetManipulatedItem()) == ITEM_TYPE
	endfunction

	private function action takes nothing returns nothing
		local unit hero = GetManipulatingUnit()
		
		call BlzSetUnitBaseDamage( hero, BlzGetUnitBaseDamage(hero, 0) + ATTACK_GAIN, 0 )
		call spdst(hero, SPELL_POWER_GAIN)
		
		set hero = null
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	endfunction

endscope