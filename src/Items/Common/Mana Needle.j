scope ManaNeedle initializer init

	globals
		private constant integer ITEM_ID = 'I0BN'
		
		private constant integer MANA_RESTORE = 2	
	endglobals

	private function OnAfterDamageEvent takes nothing returns nothing
	    if inv( udg_DamageEventTarget, ITEM_ID ) > 0 then
	        call manast( udg_DamageEventTarget, null, MANA_RESTORE )
	    endif
	endfunction

	private function init takes nothing returns nothing
	    call CreateEventTrigger( "udg_AfterDamageEvent", function OnAfterDamageEvent, null )
	endfunction
	
endscope