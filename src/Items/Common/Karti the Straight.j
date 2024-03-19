scope KartiStraight initializer init

	globals
		private constant integer ITEM_ID = 'I011'
		
		private constant integer COUNTER_REQUIRE = 7
		private constant real DAMAGE_INCREASE = 2
		
		private constant integer STRING_HASH = StringHash( "karti_straight" )
	endglobals

	private function condition takes nothing returns boolean 
		return udg_IsDamageSpell == false
	endfunction 

	private function action takes nothing returns nothing
		local unit caster = BeforeAttack.GetDataUnit("caster")
		local real extraDamage
		local real damage
		local integer id = GetHandleId(caster)
		local integer counter = LoadInteger( udg_hash, id, STRING_HASH ) + 1
	    
        if counter >= COUNTER_REQUIRE then
        	set extraDamage = BeforeAttack.GetDataReal("static_damage") * DAMAGE_INCREASE
        	set damage = BeforeAttack.GetDataReal("damage") 
           	set udg_DamageEventType = udg_DamageTypeCriticalStrike
	    	call BeforeAttack.SetDataReal("damage", damage + extraDamage )
	    	set counter = 0
        endif
        
        call SaveInteger( udg_hash, id, STRING_HASH, counter )
	    
	    set caster = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, BeforeAttack, function action, function condition )
	endfunction
	
endscope