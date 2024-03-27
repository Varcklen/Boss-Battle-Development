scope LogoshShield initializer init
	
	globals
		public trigger Trigger = null
		
		private constant integer ITEM_ID = 'I04T'
	endglobals
	
	private function condition takes nothing returns boolean
	    return luckylogic( AfterAttack.TriggerUnit, 15, 1, 100 )
	endfunction
	
	private function Logosh_ShieldCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer( ) )
	    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( "lgsh" ) ), 'A0SF' )
	    call UnitRemoveAbility( LoadUnitHandle( udg_hash, id, StringHash( "lgsh" ) ), 'B02C' )
	    call FlushChildHashtable( udg_hash, id )
	endfunction
	
	private function action takes nothing returns nothing
	    local real t 
	    local unit caster = AfterAttack.GetDataUnit("target")
	    local integer id = GetHandleId(caster)
	    local integer charges = LoadInteger( udg_hash, id, StringHash( "lgsh" ) ) + 1
	    
	    set t = timebonus(caster, 30)
	    
	    set charges = IMinBJ(5, charges)
	    
	    call UnitAddAbility( caster, 'A0SF')
	    call SetUnitAbilityLevel( caster, 'A02C', charges )
	    call SetUnitAbilityLevel( caster, 'A0FA', charges )
	    if charges < 5 then
	        call DestroyEffect( AddSpecialEffectTarget("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", caster, "origin" ) )
	    endif
	    call SaveInteger( udg_hash, id, StringHash( "lgsh" ), charges )
	    
		call InvokeTimerWithUnit( caster, "lgsh",  t, false, function Logosh_ShieldCast )

	    set caster = null
	endfunction
	
	public function Enable takes nothing returns nothing
		
    endfunction
    
    public function Disable takes nothing returns nothing
		
    endfunction
    
	//===========================================================================
	private function init takes nothing returns nothing
	    set Trigger = RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function action, function condition, "target" )
	endfunction
	
endscope