scope Tesseract initializer init

	globals
		private constant integer ITEM_ID = 'I04R'
		
		private constant real SPELL_POWER_GAIN = 0.3
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false and combat( UnitDied.TriggerUnit, false, 0 ) and IsUnitEnemy(UnitDied.TargetUnit, GetOwningPlayer(UnitDied.TriggerUnit))  
	endfunction

	private function action takes nothing returns nothing
		local unit caster = UnitDied.GetDataUnit("killer")
		local integer index = GetUnitUserData(caster)
	    
	    call spdst( caster, SPELL_POWER_GAIN)
        call textst( "|c00808080 +" + R2SW(SPELL_POWER_GAIN, 1, 1) + "%|r", caster, 64, GetRandomReal( 0, 360 ), 8, 1.5 )
        set udg_Data[index + 64] = udg_Data[index + 64] + 1 
        
        set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, UnitDied, function action, function condition, "killer" )
	endfunction

endscope