scope AutomatromIncome initializer init

	globals
		private constant integer ITEM_ID = 'I08G'
		
		private constant integer GOLD_GAIN_INITIAL = 100
		private constant integer GOLD_GAIN_PER_OTHER_MECH = 50
	endglobals

	private function condition takes nothing returns boolean
		return udg_fightmod[3] == false
	endfunction

	private function action takes nothing returns nothing
		local unit caster = BattleEnd.GetDataUnit("caster")
		local integer index = BattleEnd.GetDataInteger("index")
	    local integer otherMechs = SetCount_GetPieces(caster, SET_MECH) - 1
	    local integer goldGain = GOLD_GAIN_INITIAL + GOLD_GAIN_PER_OTHER_MECH * otherMechs

        call moneyst( caster, goldGain )
        set udg_Data[index] = udg_Data[index] + goldGain
        call textst( "|c00FFFF00 +" + I2S( goldGain ) + " gold", caster, 64, GetRandomReal( 0, 360 ), 10, 2.5 )
	    
	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BattleEnd, function action, function condition )
	endfunction
	
endscope

