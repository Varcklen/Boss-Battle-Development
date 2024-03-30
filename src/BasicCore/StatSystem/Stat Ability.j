library StatAbility requires StatSystem, Trigger

	globals
		private constant integer STRING_HASH = StringHash("stat_ability")
		private constant integer STRING_HASH_STAT = StringHash("stat_ability_stat")
	endglobals

	private function condition takes nothing returns boolean
		/*call BJDebugMsg("Check: " + GetItemName(GetManipulatedItem()))
		call BJDebugMsg("Ability: " + I2S(LoadInteger(udg_hash, GetHandleId(GetTriggeringTrigger()), STRING_HASH )))*/
		return udg_logic[36] == false and BlzGetItemAbility( GetManipulatedItem(), LoadInteger(udg_hash, GetHandleId(GetTriggeringTrigger()), STRING_HASH ) ) != null
	endfunction
	
	private function Add takes nothing returns nothing
		local integer id = GetHandleId(GetTriggeringTrigger())
		local integer stat = LoadInteger(udg_hash, id, STRING_HASH_STAT )
		local real value = LoadReal(udg_hash, id, STRING_HASH )
		
		//call BJDebugMsg("Add " + R2S(value))
		call StatSystem_Add(GetManipulatingUnit(), stat, value)
	endfunction
	
	private function Remove takes nothing returns nothing
		local integer id = GetHandleId(GetTriggeringTrigger())
		local integer stat = LoadInteger(udg_hash, id, STRING_HASH_STAT )
		local real value = LoadReal(udg_hash, id, STRING_HASH )
		
		//call BJDebugMsg("Remove " + R2S(value))
		call StatSystem_Add(GetManipulatingUnit(), stat, -value)
	endfunction
	
	function ConnectAbilityToStat takes integer abilityId, integer stat, real value returns nothing
		local trigger trig
		local integer id
		set trig = CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function Add, function condition )
		set id = GetHandleId(trig)
		call SaveInteger(udg_hash, id, STRING_HASH, abilityId )
		call SaveInteger(udg_hash, id, STRING_HASH_STAT, stat )
		call SaveReal(udg_hash, id, STRING_HASH, value )
		
		set trig = CreateNativeEvent( EVENT_PLAYER_UNIT_DROP_ITEM, function Remove, function condition )
		set id = GetHandleId(trig)
		call SaveInteger(udg_hash, id, STRING_HASH, abilityId )
		call SaveInteger(udg_hash, id, STRING_HASH_STAT, stat )
		call SaveReal(udg_hash, id, STRING_HASH, value )

		set trig = null
	endfunction
	
endlibrary