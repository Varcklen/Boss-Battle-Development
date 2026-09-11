library BattleData

	globals
		constant integer BATTLE_TYPE_MAIN = 0
		constant integer BATTLE_TYPE_INFINITE_ARENA = 1
		constant integer BATTLE_TYPE_OVERLORD_ARENA = 2
		constant integer BATTLE_TYPE_PVP = 3
		constant integer BATTLE_TYPE_RESSURECTION = 4
		
		constant integer STATE_BATTLE = 0
		constant integer STATE_REST = 1
		
		private integer CurrentBattleType = -1
		private integer CurrentState = -1
	endglobals
	
	public function GetCurrentBattleType takes nothing returns integer
		return CurrentBattleType
	endfunction
	
	public function GetCurrentState takes nothing returns integer
		return CurrentState
	endfunction
	
	public function Set takes integer battleType, integer state returns nothing
		set CurrentBattleType = battleType
		set CurrentState = state
	endfunction

endlibrary