scope RunestoneWach initializer init

	globals
		private constant integer ITEM_ID = 'I027'
		private constant integer DAMAGE_BONUS = 3
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleEnd.GetDataUnit("caster")
		local integer index = BattleEnd.GetDataInteger("index")
		local integer emptySlots = UnitInventorySize(caster) - UnitInventoryCount(caster)
		local integer attackToGain = ( 1 + emptySlots ) * DAMAGE_BONUS

        call BlzSetUnitBaseDamage( caster, BlzGetUnitBaseDamage(caster, 0) + attackToGain , 0 )
        set udg_Data[index + 8] = udg_Data[index + 8] + attackToGain
        call textst( "|c00808080 +" + I2S(attackToGain) + " Attack Damage", caster, 64, GetRandomReal( 45, 135 ), 10, 2.5 )
	    
	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition, null )
	endfunction

endscope