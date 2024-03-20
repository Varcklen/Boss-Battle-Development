scope SludgeW initializer init

globals
	private constant integer COEF = 2
	private constant integer MIN = 10
	private constant integer HEALTH = 70
	private constant integer HEALTHLVL = 10
	private constant integer ATTACK = 2
	private constant integer DAMAGE = 120
	private constant integer DAMAGELVL = 40
	
	private constant integer ABILITY = 'A0R7'
	private constant integer ABILITYMINI = 'A0SO'
       
    private integer array ScalingW[PLAYERS_LIMIT_ARRAYS]//YourHero
endglobals


private function startActions takes nothing returns nothing
	local integer i = 1
	loop
	exitwhen i > 4
		set ScalingW[i] = 1
		set i = i + 1
	endloop
endfunction


private function castConditions takes nothing returns boolean
    return GetSpellAbilityId() == ABILITY or GetSpellAbilityId() == ABILITYMINI
endfunction

private function castActions takes nothing returns nothing
    local unit caster
    local unit target
    local integer lvl
    local real dmg
    local real scaling
    local integer d
    local integer pid
    local integer uid
    //local integer id = GetSpellAbilityId()
    
    if CastLogic() then
        set caster = udg_Caster
        set target = udg_Target
        set lvl = udg_Level
    elseif RandomLogic() then
        set caster = udg_Caster
        set target = randomtarget( caster, 300, "all", "notcaster", "", "", "" )
        set lvl = udg_Level
        call textst( udg_string[0] + GetObjectName(ABILITY), caster, 64, 90, 10, 1.5 )
        if target == null then
            set caster = null
            return
        endif
    else
        set caster = GetSpellAbilityUnit()
        set target = GetSpellTargetUnit()
        if GetSpellAbilityId() == ABILITYMINI then
            set lvl = LoadInteger( udg_hash, GetHandleId(caster), StringHash( "sldgw" ) )
        else
            set lvl = GetUnitAbilityLevel(caster, ABILITY)
        endif
    endif
    set dmg = DAMAGE + DAMAGELVL * lvl
    set pid = GetPlayerId( GetOwningPlayer( caster ) ) + 1

    call DestroyEffect( AddSpecialEffect( "Objects\\Spawnmodels\\Demon\\DemonLargeDeathExplode\\DemonLargeDeathExplode.mdl", GetUnitX(target), GetUnitY(target) ) )
    call UnitTakeDamage( caster, target, dmg, DAMAGE_TYPE_MAGIC)

    if GetUnitState( target, UNIT_STATE_LIFE) <= 0.405 and not(udg_fightmod[3]) and combat(caster, false, 0) then
    	set scaling = RMaxBJ( ( (HEALTH + HEALTHLVL * lvl) / ScalingW[pid] ), MIN )
		set udg_Data[pid + 212] = udg_Data[pid + 212] + R2I(scaling)
		set udg_Data[pid + 216] = udg_Data[pid + 216] + ATTACK
    	
        call BlzSetUnitMaxHP( caster, R2I( BlzGetUnitMaxHP(caster) + scaling ) )
		call BlzSetUnitBaseDamage( caster, R2I( BlzGetUnitBaseDamage(caster, 0) + ATTACK ), 0 )
		
    	set uid = GetUnitTypeId( caster )
		set d = udg_Data[pid + 216] / 2
		if d < 20 and ( uid == 'u00X' or uid == 'H01U' ) then
			call SetUnitScale( caster, 1 + (d * 0.03), 1 + (d * 0.03), 1 + (d * 0.03) )
		endif
    	set ScalingW[pid] = ScalingW[pid] * COEF
    endif
    
    set caster = null
    set target = null
endfunction

//===========================================================================
private function init takes nothing returns nothing
    local trigger trigCast = CreateTrigger(  )
    local trigger trigStart = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( trigCast, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trigCast, Condition( function castConditions ) )
    call TriggerAddAction( trigCast, function castActions )
    
    call TriggerRegisterVariableEvent( trigStart, "udg_FightStart_Real", EQUAL, 1.00 )
    call TriggerAddAction( trigStart, function startActions )
    
    set trigCast = null
    set trigStart = null
endfunction

endscope