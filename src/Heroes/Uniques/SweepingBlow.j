scope SweepingBlow initializer init

	globals
	    private constant real ATTACK_MODIFIER = 0.4
		private constant real ATTACK_MODIFIER_UPGRADED = 0.8
		
		private constant real AREA_AFFECTED = 300
	
		private constant integer ABILITY_ID = 'A1ED'
		private constant integer UPGRADED_ABILITY_ID = 'A1EE'
		
		private boolean LoopBrake = false
	endglobals
	
	private function condition takes nothing returns boolean
		if udg_IsDamageSpell then
			return false
		endif
		if LoopBrake then
			return false
		endif
		if UnitHasBuffBJ(udg_DamageEventSource, ABILITY_ID) then
			return true
		endif
		if UnitHasBuffBJ(udg_DamageEventSource, UPGRADED_ABILITY_ID) then
			return true
		endif
	
	    return false
	endfunction
	
	private function result takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "sweeping_blow_target" ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "sweeping_blow_caster" ) )
	    local real damage = LoadReal( udg_hash, id, StringHash( "sweeping_blow_damage" ) )
	    local group g = CreateGroup()
	    local unit u
	
		set LoopBrake = true
	    call GroupEnumUnitsInRange( g, GetUnitX( target ), GetUnitY( target ), AREA_AFFECTED, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if target != u and unitst( u, caster, "enemy" ) then
	            call UnitDamageTarget( caster, u, damage, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS )
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
	    set LoopBrake = false

	    call DestroyGroup( g )
	    set u = null
	    set g = null
	    set caster = null
	    set target = null
	endfunction
	
	private function action takes nothing returns nothing
		local unit caster = udg_DamageEventSource
		local unit target = udg_DamageEventTarget
	    local integer id = GetHandleId( caster )
	    local real damageMultiplier
	    local real damage

		if IsUniqueUpgraded(caster) then
	        set damageMultiplier = ATTACK_MODIFIER_UPGRADED
	    else
	        set damageMultiplier = ATTACK_MODIFIER
	    endif
		set damageMultiplier = damageMultiplier * GetUnitSpellPower(caster) * GetUniqueSpellPower(caster)
		set damage = damageMultiplier * udg_DamageEventAmount
	    
	    if LoadTimerHandle( udg_hash, id, StringHash( "sweeping_blow" ) ) == null then
	        call SaveTimerHandle( udg_hash, id, StringHash( "sweeping_blow" ), CreateTimer() )
	    endif
	    set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "sweeping_blow" ) ) ) 
	    call SaveUnitHandle( udg_hash, id, StringHash( "sweeping_blow_target" ), target )
	    call SaveUnitHandle( udg_hash, id, StringHash( "sweeping_blow_caster" ), caster )
	    call SaveReal( udg_hash, id, StringHash( "sweeping_blow_damage" ), damage )
	    call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( "sweeping_blow" ) ), 0.01, false, function result )
	    
	    set caster = null
	    set target = null
	endfunction

	//===========================================================================
    private function init takes nothing returns nothing
        call CreateEventTrigger( "udg_AfterDamageEvent", function action, function condition )
    endfunction

endscope