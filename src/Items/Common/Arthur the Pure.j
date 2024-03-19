scope ArthurPure initializer init

	globals
		private constant integer ITEM_ID = 'I0AP'
		
		private constant integer COUNTER_REQUIRE = 9
		private constant real DAMAGE_INCREASE = 2
		
		private constant integer STRING_HASH = StringHash( "arthur_pure" )
		private constant string ANIMATION = "Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl"
	endglobals

	private function condition takes nothing returns boolean 
		return BeforeAttack.GetDataReal("damage") > 0
	endfunction

	private function action takes nothing returns nothing
		local unit target = BeforeAttack.GetDataUnit("target")
		local real damage = BeforeAttack.GetDataReal("damage") 
		local integer id = GetHandleId(target)
		local integer counter = LoadInteger( udg_hash, id, STRING_HASH ) + 1
	    
        if counter >= COUNTER_REQUIRE then
           	call healst( target, null, damage )
            call BeforeAttack.SetDataReal("damage", 0) 
            call DestroyEffect( AddSpecialEffectTarget(ANIMATION, target, "origin" ) )
	    	set counter = 0
        endif
        call SaveInteger( udg_hash, id, STRING_HASH, counter )
	    
	    set target = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BeforeAttack, function action, function condition )
	endfunction
	
endscope

