scope MoonOwl initializer init

	globals
		private constant integer ITEM_ID = 'I09I'
		
		private constant integer DAMAGE_REQUIRE = 300
		private constant real MANA_TO_RESTORE_PERC = 0.1
		private constant string ANIMATION = "Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl"
		
		private constant integer STRING_HASH = StringHash( "mana_berries" )
	endglobals

	private function condition takes nothing returns boolean
	    return AfterAttack.GetDataReal("damage") >= DAMAGE_REQUIRE
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = AfterAttack.GetDataUnit("caster")

	    call manast( hero, null, GetUnitState( hero, UNIT_STATE_MAX_MANA) * MANA_TO_RESTORE_PERC )
        call DestroyEffect( AddSpecialEffectTarget(ANIMATION, hero, "origin" ) )
	    
	    set hero = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition )
	endfunction

endscope