scope OrbHolyFire initializer init

	globals
		private constant integer ITEM_ID = 'I0FN'
		
		private constant real DAMAGE_FROM_HEAL_PERC = 0.4
		private constant integer RANGE = 300
		private constant string ANIMATION = "Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl"
	endglobals
	
	private function OrbHolyFire takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local unit target = LoadUnitHandle( udg_hash, id, StringHash( "orbhft" ) )
        local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "orbhfc" ) )
        local real dmg = LoadReal( udg_hash, id, StringHash( "orbhf" ) )

        call GroupAoE( caster, GetUnitX( target ), GetUnitY( target ), dmg, RANGE, "enemy", ANIMATION, null )

        call FlushChildHashtable( udg_hash, id )

        set target = null
        set caster = null
    endfunction

	private function action takes nothing returns nothing
		local unit caster = AfterHeal.GetDataUnit("caster")
		local unit target = AfterHeal.GetDataUnit("target")
		local real heal = AfterHeal.GetDataReal("heal") 
		local item itemUsed = Trigger_GetItemUsed()
		local integer id
		
	    set id = InvokeTimerWithItem( itemUsed, "orbhf", 0.01, false, function OrbHolyFire )
	    call SaveUnitHandle( udg_hash, id, StringHash( "orbhft" ), target )
        call SaveUnitHandle( udg_hash, id, StringHash( "orbhfc" ), caster )
        call SaveReal( udg_hash, id, StringHash( "orbhf" ), heal * DAMAGE_FROM_HEAL_PERC )
        
        set caster = null
        set target = null
	endfunction
	
	private function init takes nothing returns nothing
	    call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterHeal, function action, null, "caster" )
	endfunction

endscope