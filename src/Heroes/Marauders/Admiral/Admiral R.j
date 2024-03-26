scope ArmiralR initializer init

	globals
		private constant integer REQUIRE_INITIAL = 8
		private constant integer REQUIRE_PER_LEVEL = -1
		
		private constant integer GOLD_PER_HIT = 5
		
		private constant integer RANGE = 500
	
		private constant integer STRING_HASH_COUNTER = StringHash( "admiral_r_counter" )
	endglobals

	private function condition takes nothing returns boolean
		return udg_IsDamageSpell == false and GetUnitAbilityLevel( udg_DamageEventSource, 'A0B7' ) > 0
	endfunction

	private function AdmWCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "admiral_r" ) )
	    local real dmg = LoadReal( udg_hash, id, StringHash( "admiral_r_damage" ) )
	    local group g = CreateGroup()
	    local unit u
	    local integer gold = 0
	    
	    call DestroyEffect( AddSpecialEffectTarget( "BarbarianSkinW.mdx", caster, "origin") )
	    call GroupEnumUnitsInRange( g, GetUnitX( caster ), GetUnitY( caster ), RANGE, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if unitst( u, caster, "enemy" ) then
	            call UnitDamageTarget( caster, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
	            set gold = gold + GOLD_PER_HIT
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    
	    if combat(caster, false, 0) and not(udg_fightmod[3]) then
	        call moneyst(caster, gold)
	    endif
	    
	    call FlushChildHashtable( udg_hash, id )
	    
	    call DestroyGroup( g )
	    set u = null
	    set g = null
	    set caster = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = udg_DamageEventSource
		local integer level = GetUnitAbilityLevel( caster, 'A0B7' )
		local integer id = GetHandleId(caster)
		local integer idUnit = GetHandleId(caster)
		local integer counter = LoadInteger( udg_hash, idUnit, STRING_HASH_COUNTER ) + 1
		local integer require = REQUIRE_INITIAL + (REQUIRE_PER_LEVEL * level)
		local real damage = udg_DamageEventAmount * 2
		
        if counter >= require then
        	set counter = 0
        	
            set id = InvokeTimerWithUnit( caster, "admiral_r", 0.01, false, function AdmWCast )
            call SaveReal( udg_hash, id, StringHash( "admiral_r_damage" ), damage )
        endif
        
        call SaveInteger( udg_hash, idUnit, STRING_HASH_COUNTER, counter )
        
        set caster = null
	endfunction

    private function init takes nothing returns nothing
		call CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
	endfunction

endscope