scope ManaNeedle initializer init

	globals
		private constant integer ITEM_ID = 'I0BN'
		
		private constant integer MANA_RESTORE = 2	
	endglobals

	private function OnAfterDamageEvent takes nothing returns nothing
		local unit target = AfterAttack.GetDataUnit("target")
	    //if inv( udg_DamageEventTarget, ITEM_ID ) > 0 then
	        call manast( target, null, MANA_RESTORE )
	    //endif
	    set target = null
	endfunction

	private function init takes nothing returns nothing
	    //call CreateEventTrigger( "udg_AfterDamageEvent", function OnAfterDamageEvent, null )
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function OnAfterDamageEvent, null, "target" )
	endfunction
	
endscope