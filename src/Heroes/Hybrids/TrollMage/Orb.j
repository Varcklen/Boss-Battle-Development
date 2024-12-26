scope Orb initializer init
globals
	trigger trg_Orb = null
	private constant real UNIQUE_VALUE = 2.
	private constant real STATIC_VALUE = 2.
	
endglobals

private function Trig_Orb_Conditions takes nothing returns boolean
    return GetUnitTypeId(GetEnteringUnit()) == 'u000' and GetUnitAbilityLevel(GetEnteringUnit(), 'A04J') > 0
endfunction

function OrbCast takes nothing returns nothing 
	local integer id = GetHandleId( GetExpiredTimer( ) )
    local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "orbc" ) )
    local unit orb = LoadUnitHandle( udg_hash, id, StringHash( "orb" ) )
    local group g = CreateGroup()
    local unit u
    local real damage = UNIQUE_VALUE * GetUniqueSpellPower(caster) + STATIC_VALUE

    if IsUnitAlive(orb) then
    	call GroupEnumUnitsInRange( g, GetUnitX( orb ), GetUnitY( orb ), 182, null )
    	loop
        	set u = FirstOfGroup(g)
        	exitwhen u == null
        	if unitst( u, orb, "enemy" ) then
        	    call UnitDamageTarget( caster, u, damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )
            elseif unitst( u, orb, "ally" ) then
                call healst(caster, u, damage)
        	endif
        	call GroupRemoveUnit(g,u)
    	endloop
    else
		call DestroyTimer( GetExpiredTimer() )
    endif

    call DestroyGroup( g )
    set u = null
    set orb = null
    set g = null
    set caster = null
endfunction 

private function Trig_Orb_Actions takes nothing returns nothing
	local unit u = GetEnteringUnit()
    local integer i = GetPlayerId(GetOwningPlayer(u)) + 1
	local integer id = GetHandleId( u )
    
	call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Human\\Invisibility\\InvisibilityTarget.mdl", GetUnitX(u), GetUnitY(u) ) )
    
    call UnitApplyTimedLife( u, 'BTLF', 25 )
    
	call SaveTimerHandle( udg_hash, id, StringHash( "orb" ), CreateTimer( ) ) 
	set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "orb" ) ) ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "orb" ), u ) 
	call SaveUnitHandle( udg_hash, id, StringHash( "orbc" ), udg_hero[i] ) 
	call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "orb" ) ), 1, true, function OrbCast ) 
	set u = null
endfunction 

//===========================================================================
private function init takes nothing returns nothing
    set trg_Orb = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( trg_Orb, GetWorldBounds() )
    call TriggerAddCondition( trg_Orb, Condition( function Trig_Orb_Conditions ) )
    call TriggerAddAction( trg_Orb, function Trig_Orb_Actions )
endfunction

endscope