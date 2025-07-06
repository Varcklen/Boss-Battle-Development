scope WrathCollectorQ initializer init

	globals
		private constant integer ABILITY_ID = 'A1GT'
	
		private constant integer CHARGE_ANIMATION = 'A0DV'
		private constant integer AREA = 300
		
		private constant real TICK_INTERVAl = 0.04
		private constant integer SPEED = R2I(600 * TICK_INTERVAl)
		private constant integer MAX_OF_TICKS = 300
		
		private constant integer DAMAGE_INITIAL = 60
		private constant integer DAMAGE_PER_LEVEL = 40
		
		private constant integer MAIN_KEY = StringHash("wrath_collector_q_push")
		
		private constant string ANIMATION = "Abilities\\Spells\\Human\\Thunderclap\\ThunderClapCaster.mdl"
		
		private constant integer WRATH_BONUS_REQUIRE = 50
		private constant real WRATH_BONUS_MULTIPIER = 2
		
		trigger WrathCollectorQ = null
	endglobals

	private function condition takes nothing returns boolean
        return GetSpellAbilityId() == ABILITY_ID and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )
    endfunction

    private function PushAction takes nothing returns nothing
        local integer id = GetHandleId( GetExpiredTimer() )
        local integer counter = LoadInteger( udg_hash, id, MAIN_KEY )
        local real damage 
        local unit caster = LoadUnitHandle( udg_hash, id, MAIN_KEY )
        local unit target = LoadUnitHandle( udg_hash, id, StringHash( "wrath_collector_q_push_target" ) )
        /*local real x = GetUnitX( caster )
        local real y = GetUnitY( caster )
        local real xc = GetUnitX( target )
        local real yc = GetUnitY( target )
        local real angle = Atan2( y - yc, x - xc )
        local real NewX = xc + 12 * Cos( angle )
        local real NewY = yc + 12 * Sin( angle )
        local real IfX = ( x - xc ) * ( x - xc )
        local real IfY = ( y - yc ) * ( y - yc )*/
        local location movePoint = null
        
        if DistanceBetweenUnits(caster, target) > 100 and counter < MAX_OF_TICKS and IsUnitAlive(target) and combat( caster, false, 0 ) and GetUnitDefaultMoveSpeed(target) != 0 then
        	set movePoint = LocationSystem_GetMovedBetweenUnits( target, caster, SPEED )
        	call SetUnitPositionLoc( target, movePoint )
            call SetUnitFacing( target, AngleBetweenUnits(caster, target ) )
            call SaveInteger( udg_hash, id, MAIN_KEY, counter + 1 )
        else
            if IsUnitAlive(target) then
            	set damage = LoadReal( udg_hash, id, MAIN_KEY )
                call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( target ), GetUnitY( target ) ) )
                call UnitDamageTarget( caster, target, damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            endif
            call SetUnitPathing( target, true )
            call pausest( target, -1 )
            call UnitRemoveAbility( target, CHARGE_ANIMATION )
            call FlushChildHashtable( udg_hash, id )
            call DestroyTimer( GetExpiredTimer() )
        endif
        
        call RemoveLocation(movePoint)
    	set movePoint = null
        set caster = null
        set target = null
    endfunction

    
    private function PushTarget takes unit caster, unit target, integer level, real damageMultiplier returns nothing
    	local real damage
    	local timer usedTimer
    	local integer id 
    	
    	if target == null then
    		return
		endif
		if GetUnitAbilityLevel( target, CHARGE_ANIMATION ) > 0 then
			return
		endif
		
        set damage = ( DAMAGE_INITIAL + ( DAMAGE_PER_LEVEL * level ) ) * damageMultiplier
        
        call pausest( target, 1 )
        call UnitAddAbility( target, CHARGE_ANIMATION )
        
        call SetUnitPathing( target, false )
        call SetUnitFacing( target, AngleBetweenUnits( caster, target ) )

        set id = GetHandleId( target )
        if LoadTimerHandle( udg_hash, id, MAIN_KEY ) == null  then
            call SaveTimerHandle( udg_hash, id, MAIN_KEY, CreateTimer() )
        endif
        set usedTimer = LoadTimerHandle( udg_hash, id, MAIN_KEY )
        set id = GetHandleId( usedTimer ) 
        call SaveUnitHandle( udg_hash, id, MAIN_KEY, caster )
        call SaveUnitHandle( udg_hash, id, StringHash( "wrath_collector_q_push_target" ), target )
        call SaveReal( udg_hash, id, MAIN_KEY, damage )
        call TimerStart( usedTimer, TICK_INTERVAl, true, function PushAction )
        
        set usedTimer = null
    endfunction

    private function action takes nothing returns nothing
        local integer id 
        local integer lvl
        local unit caster
        local real x
        local real y
        local group g
    	local unit u
    	local real area
    	local real damageMultiplier
        
        if CastLogic() then
            set caster = udg_Caster
            set x = GetSpellTargetX()
        	set y = GetSpellTargetY()
            set lvl = udg_Level
        elseif RandomLogic() then
            set caster = udg_Caster
            set x = GetUnitX( caster ) + GetRandomReal( -650, 650 )
        	set y = GetUnitY( caster ) + GetRandomReal( -650, 650 )
            set lvl = udg_Level
            call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )
        else
            set caster = GetSpellAbilityUnit()
            set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())
            set x = GetSpellTargetX()
        	set y = GetSpellTargetY()
        endif
        
        set area = AREA
        set damageMultiplier = 1
        if WrathBarEffect_GetValue(caster) >= WRATH_BONUS_REQUIRE then
        	set area = area * WRATH_BONUS_MULTIPIER
        	set damageMultiplier = damageMultiplier * WRATH_BONUS_MULTIPIER
        endif
        
        set g = CreateGroup()
        call GroupEnumUnitsInRange( g, x, y, area, null )
	    loop
	        set u = FirstOfGroup(g)
	        exitwhen u == null
	        if unitst( u, caster, "enemy" ) then
	            call PushTarget(caster, u, lvl, damageMultiplier)
	        endif
	        call GroupRemoveUnit(g,u)
	    endloop
    
	    call DestroyGroup( g )
	    set u = null
	    set g = null  
        set caster = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
    	set WrathCollectorQ = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )
    endfunction

endscope