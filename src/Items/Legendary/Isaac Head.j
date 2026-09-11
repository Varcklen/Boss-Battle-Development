scope IsaacHead initializer init
	
	globals
		private constant integer ITEM_ID = 'I0F8'
		private constant integer EFFECT_ID = 'A05W'
		private constant integer BUFF_ID = 'B09J'
		private constant integer DURATION = 30
	endglobals

	private function condition takes nothing returns boolean
		return inv( BattleStart.TriggerUnit, ITEM_ID) > 0
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = BattleStart.GetDataUnit("caster")
		local real duration = timebonus( hero, DURATION )
	
		call bufst( hero, hero, EFFECT_ID, BUFF_ID, "issc", duration )
		
		set hero = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
		call BattleStart.AddListener(function action, function condition)
	endfunction
	
endscope