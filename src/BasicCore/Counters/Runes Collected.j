library RunesCollected initializer init requires CombatLib, Trigger

	globals
		private constant integer TAG_CHECK = 'A1I2'
		private integer array Value[5]
	endglobals
	
	public function GetValue takes player user returns integer
		local integer index = GetPlayerId(user) + 1
		return Value[index]
	endfunction

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false and combat(udg_DamageEventTarget, false, 0) and BlzGetItemAbility( GetManipulatedItem(), TAG_CHECK ) != null
	endfunction

	private function action takes nothing returns nothing
		local integer index = GetUnitUserData(GetManipulatingUnit())

		set Value[index] = Value[index] + 1
	endfunction
	
	//===============================================================
	private function OnInfoButtonClicked takes nothing returns nothing
		local player user = InfoButtonClicked.GetDataPlayer("player")
		local integer value = GetValue(user)
		
		if value != 0 then
			call MessageShowInfo(user, "Runes Collected", I2S( value ) )
		endif

		set user = null
	endfunction
	
	//===============================================================
	private function init takes nothing returns nothing
	    call CreateNativeEvent( EVENT_PLAYER_UNIT_PICKUP_ITEM, function action, function condition )
	    call InfoButtonClicked.AddListener(function OnInfoButtonClicked, null)
	endfunction

endlibrary