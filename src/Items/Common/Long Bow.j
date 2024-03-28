scope LongBow initializer init

	globals
		public trigger Trigger = null
	
		private constant integer ITEM_ID = 'I04Y'
	endglobals

	private function condition takes nothing returns boolean
	    return udg_IsDamageSpell == false and luckylogic( AfterAttack.TriggerUnit, 10, 1, 100 )
	endfunction
	
	private function ArcherCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( "arch" ) ), 'A0QU' )
	    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( "arch" ) ), 'B03H' )
	    call FlushChildHashtable( udg_hash, id )
	endfunction
	
	private function action takes nothing returns nothing
	    local unit caster = AfterAttack.GetDataUnit("caster")
	    local integer id = GetHandleId( caster )
	    local integer counter = LoadInteger(udg_hash, id, StringHash("long_bow_counter") )
	    local real t = timebonus(caster, 15)
	
	    set counter = IMinBJ(3, counter + 1)
	    call UnitAddAbility( caster, 'A0QU')
	    call SetUnitAbilityLevel( caster, 'A0FJ', counter )
	    call SaveInteger(udg_hash, id, StringHash("long_bow_counter"), counter )
	
	    call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl", caster, "origin" ) )
	    
		call InvokeTimerWithUnit( caster, "arch", t, false, function ArcherCast )

	    set caster = null
	endfunction
	
	public function Enable takes nothing returns nothing

    endfunction
    
    public function Disable takes nothing returns nothing

    endfunction
	
	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "caster" )
	endfunction
	
endscope