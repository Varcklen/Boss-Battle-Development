scope BloodyCoin initializer init

	globals
		private constant integer ITEM_ID = 'I074'
		
		private constant integer HEAL = 20
		private constant integer GOLD_GAIN = 20
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false and combat( UnitDied.TriggerUnit, false, 0 ) and IsUnitEnemy(UnitDied.TargetUnit, GetOwningPlayer(UnitDied.TriggerUnit))  
	endfunction

	private function action takes nothing returns nothing
		local unit caster = UnitDied.GetDataUnit("killer")
		local integer index = GetUnitUserData(caster)
	    call healst( caster, null, HEAL )
        call moneyst( caster, GOLD_GAIN )
        set udg_Data[index + 180] = udg_Data[index + 180] + GOLD_GAIN
        
        set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, UnitDied, function action, function condition, "killer" )
	endfunction

endscope