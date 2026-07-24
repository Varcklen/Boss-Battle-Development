scope Blockade

	globals
		private constant integer VALUE_TO_ADD = -20
		private constant integer STAT_TYPE = STAT_DAMAGE_TAKEN_FROM_MINIONS
	endglobals

	public function Enable takes nothing returns nothing
		call StatSystem_Add( WeaponPieceSystem_WeaponData.TriggerUnit, STAT_TYPE, VALUE_TO_ADD)
    endfunction
    
    public function Disable takes nothing returns nothing
		call StatSystem_Add( WeaponPieceSystem_WeaponData.TriggerUnit, STAT_TYPE, -VALUE_TO_ADD)
    endfunction

endscope