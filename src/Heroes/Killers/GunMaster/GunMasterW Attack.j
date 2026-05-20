scope GunMasterWAttack initializer init

	/*function CommandoWAtCast takes nothing returns nothing
	    local integer id = GetHandleId( GetExpiredTimer() )
	    local integer counter = LoadInteger( udg_hash, id, StringHash( "codw" ) ) + 1
	    local unit dummy = LoadUnitHandle( udg_hash, id, StringHash( "codw" ) )
	    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "codwc" ) )
	    local unit u
	    local real NewX = GetUnitX( dummy ) + 90 * Cos( 0.017 * GetUnitFacing( dummy ) )
	    local real NewY = GetUnitY( dummy ) + 90 * Sin( 0.017 * GetUnitFacing( dummy ) )
	    local real dmg = LoadReal( udg_hash, id, StringHash( "codw" ) )
	    local group g = CreateGroup()
	    local boolean l = false
	
	    if counter >= 8 or GetUnitState( dummy, UNIT_STATE_LIFE) <= 0.405 then
	        call RemoveUnit( dummy )
	        call FlushChildHashtable( udg_hash, id )
	        call DestroyTimer( GetExpiredTimer() )
	    else
	        call SetUnitPosition( dummy, NewX, NewY )
	        call SaveInteger( udg_hash, id, StringHash( "codw" ), counter )
	        call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), 100, null )
	        loop
	            set u = FirstOfGroup(g)
	            exitwhen u == null
	            if unitst( u, dummy, "enemy" ) then
	                set l = true
	            endif
	            call GroupRemoveUnit(g,u)
	        endloop
	
	        if l then
	            call GroupEnumUnitsInRange( g, GetUnitX( dummy ), GetUnitY( dummy ), 150, null )
	            loop
	                set u = FirstOfGroup(g)
	                exitwhen u == null
	                if unitst( u, dummy, "enemy" ) then
	                    call UnitDamageTarget( dummy, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
	                endif
	                call GroupRemoveUnit(g,u)
	            endloop
	            call RemoveUnit( dummy )
	            call FlushChildHashtable( udg_hash, id )
	            call DestroyTimer( GetExpiredTimer() )
	        endif
	    endif
	    
	    call GroupClear( g )
	    call DestroyGroup( g )
	    set u = null
	    set g = null
	    set caster = null
	    set dummy = null
	endfunction
	
	function CommandoWAt takes unit caster, real dmg, integer lvl returns nothing
	    local integer id
	    local integer cyclA = 1
	    local integer b = lvl + 4
	    local real x = GetUnitX( caster ) + 90 * Cos( 0.017 * GetUnitFacing( caster ) )
	    local real y = GetUnitY( caster ) + 90 * Sin( 0.017 * GetUnitFacing( caster ) )
	
	    loop
	        exitwhen cyclA > b
	        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( caster ), 'u000', x, y, GetUnitFacing( caster ) + GetRandomReal( -40, 40 ) ) 
	        call UnitAddAbility( bj_lastCreatedUnit, 'A0N5')
	        call UnitAddAbility( bj_lastCreatedUnit, 'A19G')
	        
	        set id = GetHandleId( bj_lastCreatedUnit )
	        call SaveTimerHandle( udg_hash, id, StringHash( "codw" ), CreateTimer() )
	        set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "codw" ) ) ) 
	        call SaveUnitHandle( udg_hash, id, StringHash( "codw" ), bj_lastCreatedUnit )
	        call SaveUnitHandle( udg_hash, id, StringHash( "codwc" ), caster )
	        call SaveReal( udg_hash, id, StringHash( "codw" ), dmg )
	        call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( bj_lastCreatedUnit ), StringHash( "codw" ) ), 0.04, true, function CommandoWAtCast )
	        set cyclA = cyclA + 1
	    endloop
	endfunction
	
	if GetUnitAbilityLevel(udg_DamageEventSource, 'B02O') > 0 and not( udg_IsDamageSpell ) then
        call CommandoWAt( udg_DamageEventSource, 0.2*udg_DamageEventAmount, GetUnitAbilityLevel(udg_DamageEventSource, 'A19F') )
        set udg_DamageEventAmount = 0
    endif*/
    

    globals
    	private constant integer BUFF_USED = 'B02O'
    	private constant integer ABILITY_ID = 'A19F'
    	
    	private constant real EXTRA_DAMAGE_INITIAL = 0.75
		private constant real EXTRA_DAMAGE_PER_LEVEL = 0.25
		
		private constant integer AOE_AREA = 300
    endglobals
    
    //===========================================================================
    private function OnDealDamage_Conditions takes nothing returns boolean
        return udg_IsDamageSpell == false and GetUnitAbilityLevel( udg_DamageEventSource, BUFF_USED) > 0
    endfunction
    
    private function AoE_Delay takes nothing returns nothing
    	local integer id = GetHandleId( GetExpiredTimer() )
    	local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "gun_master_w_delay" ) )
    	local unit target = LoadUnitHandle( udg_hash, id, StringHash( "gun_master_w_delay_target" ) )
    	local real x = LoadReal( udg_hash, id, StringHash( "gun_master_w_delay_x" ) )
    	local real y = LoadReal( udg_hash, id, StringHash( "gun_master_w_delay_y" ) )
    	local real damage = LoadReal( udg_hash, id, StringHash( "gun_master_w_delay_damage" ) )
    	local group g = CreateGroup()
    	local unit u

    	call GroupEnumUnitsInRange( g, x, y, AOE_AREA, null )
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            if unitst( u, caster, "enemy" ) and u != target then
                call UnitDamageTarget( caster, u, damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
            endif
            call GroupRemoveUnit(g,u)
        endloop
    	call FlushChildHashtable( udg_hash, id )
 
	    call DestroyGroup( g )
	    set u = null
	    set g = null
    	set caster = null
		set target = null
    endfunction
    
    private function OnDealDamage takes nothing returns nothing
		local unit hero = udg_DamageEventSource
		local unit target = udg_DamageEventTarget
		local integer level = GetUnitAbilityLevel( hero, ABILITY_ID)
		local real extraDamage = EXTRA_DAMAGE_INITIAL + EXTRA_DAMAGE_PER_LEVEL * level
		local integer id

        set udg_DamageEventAmount = udg_DamageEventAmount + extraDamage * udg_DamageEventAmount
		set udg_IsDamageSpell = true
		
		set id = InvokeTimerWithUnit( hero, "gun_master_w_delay", 0.04, false, function AoE_Delay )
		call SaveUnitHandle( udg_hash, id, StringHash( "gun_master_w_delay_target" ), target )
		call SaveReal( udg_hash, id, StringHash( "gun_master_w_delay_x" ), GetUnitX(target) )
		call SaveReal( udg_hash, id, StringHash( "gun_master_w_delay_y" ), GetUnitY(target) )
		call SaveReal( udg_hash, id, StringHash( "gun_master_w_delay_damage" ), udg_DamageEventAmount )

		set hero = null
		set target = null
    endfunction

	//===========================================================================
	private function init takes nothing returns nothing
	    call CreateEventTrigger( "udg_DamageModifierEvent", function OnDealDamage, function OnDealDamage_Conditions )
	endfunction

endscope