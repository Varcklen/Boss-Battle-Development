scope RedSugar initializer init

	globals
		private constant integer ITEM_ID = 'I0HE'
		private constant integer HEALTH_GAIN = 1
	endglobals
	
	private function condition takes nothing returns boolean
		//call BJDebugMsg("AfterHeal.GetDataUnit(\"target\"): " + GetUnitName( AfterHeal.GetDataUnit("target") ) )
		return udg_fightmod[3] == false and combat( Event_AfterHeal_Target/*AfterHeal.GetDataUnit("target")*/, false, 0 )
	endfunction
	
	private function action takes nothing returns nothing
		local unit target = Event_AfterHeal_Target//AfterHeal.GetDataUnit("target")
		local integer playerIndex = GetPlayerId(GetOwningPlayer(target)) + 1
		local integer saveIndex = playerIndex + 264
		
		//call BJDebugMsg("target: " + GetUnitName(target))
		call BlzSetUnitMaxHP( target, BlzGetUnitMaxHP(target) + HEALTH_GAIN )
		set udg_Data[saveIndex] = udg_Data[saveIndex] + HEALTH_GAIN
		
		set target = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		//call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterHeal, function action, function condition, "target" )
		call CreateEventTrigger("Event_AfterHeal_Real", function action, function condition )
	endfunction

endscope