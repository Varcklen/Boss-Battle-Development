scope ManaBerries initializer init

	globals
		private constant integer ITEM_ID = 'I01W'
		
		private constant integer COUNTER_REQUIRE = 3
		private constant integer MANA_TO_RESTORE = 12
		private constant string ANIMATION = "Abilities\\Spells\\Undead\\ReplenishMana\\SpiritTouchTarget.mdl"
		
		private constant integer STRING_HASH = StringHash( "mana_berries" )
	endglobals

	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell == false //and inv(udg_DamageEventSource, ) > 0
	endfunction
	
	private function action takes nothing returns nothing
		local unit hero = AfterAttack.GetDataUnit("caster")
	    local integer id = GetHandleId( hero )
	    local integer counter = LoadInteger( udg_hash, id, STRING_HASH ) + 1
	    
	    if counter >= COUNTER_REQUIRE then
	        set counter = 0
	        call manast( hero, null, MANA_TO_RESTORE )
	        call DestroyEffect( AddSpecialEffectTarget( ANIMATION, hero, "origin" ) )
	    endif
	    call SaveInteger( udg_hash, id, STRING_HASH, counter )
	    
	    set hero = null
	endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    /*set gg_trg_Mana_Berries = CreateTrigger(  )
	    call TriggerRegisterVariableEvent( gg_trg_Mana_Berries, "udg_AfterDamageEvent", EQUAL, 1.00 )
	    call TriggerAddCondition( gg_trg_Mana_Berries, Condition( function Trig_Mana_Berries_Conditions ) )
	    call TriggerAddAction( gg_trg_Mana_Berries, function Trig_Mana_Berries_Actions )*/
	    
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction

endscope