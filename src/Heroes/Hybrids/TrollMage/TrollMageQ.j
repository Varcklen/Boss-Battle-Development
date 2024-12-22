scope TrollMageQ initializer init

    globals
		trigger trg_TrollMageQ = null
    endglobals
    
function Trig_TrollMageQ_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A14U'
endfunction

function TrollMageQCast takes nothing returns nothing
    local integer id = GetHandleId( GetExpiredTimer() )
    local unit target = LoadUnitHandle( udg_hash, id, StringHash( "trlq" ) )
	local unit caster = LoadUnitHandle( udg_hash, id, StringHash( "trlqc" ) )
	local unit orb = LoadUnitHandle( udg_hash, id, StringHash( "trlqo" ) )
    local real dmg = LoadReal( udg_hash, id, StringHash( "trlq" ) )
	local real heal = LoadReal( udg_hash, id, StringHash( "trlqh" ) )
    local real x = LoadReal( udg_hash, id, StringHash( "trlqx" ) )
    local real y = LoadReal( udg_hash, id, StringHash( "trlqy" ) )
	local group g = CreateGroup()
    local unit u

	if DistanceBetweenPoints(GetUnitLoc(orb), GetUnitLoc(target)) > 100 and GetUnitState( target, UNIT_STATE_LIFE) > 0.405 and GetUnitState( orb, UNIT_STATE_LIFE) > 0.405 then
		call IssuePointOrder( orb, "move", GetUnitX( target ), GetUnitY( target ) )
	else
		if GetUnitState( target, UNIT_STATE_LIFE) > 0.405 and GetUnitState( orb, UNIT_STATE_LIFE) > 0.405 then
			call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Other\\HowlOfTerror\\HowlCaster.mdl", GetUnitX( target ), GetUnitY( target ) ) )
			call healst( caster, target, heal )
			call GroupEnumUnitsInRange( g, GetUnitX( target ), GetUnitY( target ), 300, null )
			loop
				set u = FirstOfGroup(g)
				exitwhen u == null
				if unitst( u, target, "enemy" ) then
					call UnitDamageTarget( caster, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
				endif
				call GroupRemoveUnit(g,u)
			endloop
		endif
		call RemoveUnit(orb)
		call FlushChildHashtable( udg_hash, id )
		call DestroyTimer( GetExpiredTimer() )
    endif
	
    call DestroyGroup( g )
    set u = null
	set g = null
	set orb = null
    set target = null
	set caster = null
endfunction

function Trig_TrollMageQ_Actions takes nothing returns nothing
    local unit caster
    local unit target
    local integer id
    local real dmg 
	local real heal
    local real x 
    local real y 
    local integer lvl
	local group g = CreateGroup()
    local unit u
	
    if CastLogic() then
        set caster = udg_Caster
        set target = udg_Target
        set lvl = udg_Level
    elseif RandomLogic() then
        set caster = udg_Caster
        set target = randomtarget( caster, 900, "ally", 0, 0, 0 )
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName('A14U'), caster, 64, 90, 10, 1.5 )
        if target == null then
            set caster = null
            return
        endif
    else
        set caster = GetSpellAbilityUnit()
        set target = GetSpellTargetUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    endif
    
    set x = GetUnitX( target )
    set y = GetUnitY( target )
    
    set dmg = 30 + ( 30 * lvl )
	set heal = 30 + ( 30 * lvl )
    
	set bj_livingPlayerUnitsTypeId = 'u000'
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer( caster ), filterLivingPlayerUnitsOfTypeId)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if GetUnitAbilityLevel(u, 'A04J') > 0 then
            call IssuePointOrder( u, "move", GetUnitX( target ), GetUnitY( target ) )
            set id = GetHandleId( u )
            if LoadTimerHandle( udg_hash, id, StringHash( "trlq" ) ) == null  then
                call SaveTimerHandle( udg_hash, id, StringHash( "trlq" ), CreateTimer() )
            endif
            set id = GetHandleId( LoadTimerHandle( udg_hash, id, StringHash( "trlq" ) ) ) 
            call SaveUnitHandle( udg_hash, id, StringHash( "trlq" ), target )
            call SaveUnitHandle( udg_hash, id, StringHash( "trlqc" ), caster )
            call SaveUnitHandle( udg_hash, id, StringHash( "trlqo" ), u )
            call SaveReal( udg_hash, id, StringHash( "trlq" ), dmg )
            call SaveReal( udg_hash, id, StringHash( "trlqh" ), heal )
            call SaveReal( udg_hash, id, StringHash( "trlqx" ), x )
            call SaveReal( udg_hash, id, StringHash( "trlqy" ), y )
            call TimerStart( LoadTimerHandle( udg_hash, GetHandleId( u ), StringHash( "trlq" ) ), 0.25, true, function TrollMageQCast )
            endif
        call GroupRemoveUnit(g,u)
    endloop
    
    call GroupClear( g )
    call DestroyGroup( g )
    set u = null
	set g = null
    set caster = null
    set target = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_TrollMageQ = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_TrollMageQ, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_TrollMageQ, Condition( function Trig_TrollMageQ_Conditions ) )
    call TriggerAddAction( trg_TrollMageQ, function Trig_TrollMageQ_Actions )
endfunction

endscope

