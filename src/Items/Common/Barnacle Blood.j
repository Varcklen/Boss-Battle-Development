scope BarnacleBlood initializer init

	globals
		private constant integer ITEM_ID = 'I0B4'
		
		private constant real HEAL = 50
	endglobals

	private function action takes nothing returns nothing
	    call healst( GetSpellAbilityUnit(), null, HEAL )
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemType(ITEM_ID, EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, null)
	endfunction

endscope