scope BlessTrade initializer init

	globals
		private constant integer DISCOUNT = 75
	endglobals

	//===========================================================================
	public function Enable takes nothing returns nothing
		set ExchangeCost = ExchangeCost - DISCOUNT
		/*set ExchangerUnit[0] = ReplaceUnitBJ( ExchangerUnit[0], 'h00R', bj_UNIT_STATE_METHOD_RELATIVE )
        set ExchangerUnit[1] = ReplaceUnitBJ( ExchangerUnit[1], 'h00X', bj_UNIT_STATE_METHOD_RELATIVE )
        set ExchangerUnit[2] = ReplaceUnitBJ( ExchangerUnit[2], 'h00Y', bj_UNIT_STATE_METHOD_RELATIVE )
        set ExchangerUnit[3] = ReplaceUnitBJ( ExchangerUnit[3], 'h00W', bj_UNIT_STATE_METHOD_RELATIVE )*/
    endfunction
    
    public function Disable takes nothing returns nothing
		set ExchangeCost = ExchangeCost + DISCOUNT
		/*set ExchangerUnit[0] = ReplaceUnitBJ( ExchangerUnit[0], 'h00H', bj_UNIT_STATE_METHOD_RELATIVE )
        set ExchangerUnit[1] = ReplaceUnitBJ( ExchangerUnit[1], 'h00V', bj_UNIT_STATE_METHOD_RELATIVE )
        set ExchangerUnit[2] = ReplaceUnitBJ( ExchangerUnit[2], 'h00U', bj_UNIT_STATE_METHOD_RELATIVE )
        set ExchangerUnit[3] = ReplaceUnitBJ( ExchangerUnit[3], 'h00T', bj_UNIT_STATE_METHOD_RELATIVE )*/
    endfunction
	
	private function init takes nothing returns nothing

	endfunction

endscope