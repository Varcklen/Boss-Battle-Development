scope BlessTrade initializer init

	globals
		private constant integer DISCOUNT = 25
		private constant integer MANA_GAIN = 10
		private trigger Trigger = null
	endglobals
	
	//===========================================================================
	private function action takes nothing returns nothing
	    local unit hero = Event_ItemExchange_Hero
	    
	    call BlzSetUnitMaxMana( hero, BlzGetUnitMaxMana(hero) + MANA_GAIN )
	    call textst( "|cff00ccee+" + I2S(MANA_GAIN) + " mana|r", hero, 64, 90, 8, 2 )
	    
	    set hero = null
	endfunction

	//===========================================================================
	public function Enable takes nothing returns nothing
		set ExchangeCost = ExchangeCost - DISCOUNT
		call EnableTrigger( Trigger )
    endfunction
    
    public function Disable takes nothing returns nothing
		set ExchangeCost = ExchangeCost + DISCOUNT
		call DisableTrigger( Trigger )
    endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
		set Trigger = CreateEventTrigger( "Event_ItemExchange_Real", function action, null )
		call DisableTrigger( Trigger )
	endfunction

endscope