scope TrollMageR initializer init

    globals
		trigger trg_TrollMageR = null
    endglobals
    
function Trig_TrollMageR_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A0BX'
endfunction

function Trig_TrollMageR_Actions takes nothing returns nothing
    local unit caster
    local unit target
    local real dmg 
    local integer lvl
	local group g = CreateGroup()
	local group h = CreateGroup()
    local unit u
	local unit f
	
    if CastLogic() then
        set caster = udg_Caster
        set target = udg_Target
        set lvl = udg_Level
    elseif RandomLogic() then
        set caster = udg_Caster
        set target = randomtarget( caster, 900, "enemy", 0, 0, 0 )
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName('A0BX'), caster, 64, 90, 10, 1.5 )
        if target == null then
            set caster = null
            return
        endif
    else
        set caster = GetSpellAbilityUnit()
        set target = GetSpellTargetUnit()
        set lvl = GetUnitAbilityLevel(caster, GetSpellAbilityId())
    endif
    
    set dmg = 30 + ( 30 * lvl )
    
	call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\NightElf\\MoonWell\\MoonWellCasterArt.mdl", GetUnitX(target), GetUnitY(target) ) )
	call UnitDamageTarget( caster, target, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
	set bj_livingPlayerUnitsTypeId = 'u000'
    call GroupEnumUnitsOfPlayer(g, GetOwningPlayer( caster ), filterLivingPlayerUnitsOfTypeId)
    loop
        set u = FirstOfGroup(g)
        exitwhen u == null
        if GetUnitAbilityLevel(u, 'A04J') > 0 then
			call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Other\\HowlOfTerror\\HowlCaster.mdl", GetUnitX( u ), GetUnitY( u ) ) )
			call GroupEnumUnitsInRange( h, GetUnitX( u ), GetUnitY( u ), 300, null )
			loop
				set f = FirstOfGroup(h)
				exitwhen f == null
				if unitst( f, caster, "enemy" ) then
					call UnitDamageTarget( bj_lastCreatedUnit, f, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
				endif
				call GroupRemoveUnit(h,f)
			endloop
        endif
        call GroupRemoveUnit(g,u)
    endloop

    call DestroyGroup( g )
    call DestroyGroup( h )
    set f = null
	set h = null
    set u = null
	set g = null
    set caster = null
    set target = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    set trg_TrollMageR = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trg_TrollMageR, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trg_TrollMageR, Condition( function Trig_TrollMageR_Conditions ) )
    call TriggerAddAction( trg_TrollMageR, function Trig_TrollMageR_Actions )
endfunction

endscope

