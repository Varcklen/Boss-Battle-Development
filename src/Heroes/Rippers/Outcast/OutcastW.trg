{
  "Id": 50333068,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_OutcastW_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A07Y'\r\nendfunction\r\n\r\nfunction Trig_OutcastW_Actions takes nothing returns nothing\r\n    local integer lvl\r\n    local unit caster\r\n    local real dmg \r\n    local real dmge\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    local group h = CreateGroup()\r\n    local unit n\r\n\r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set lvl = udg_Level\r\n        call textst( udg_string[0] + GetObjectName('A07Y'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set lvl = GetUnitAbilityLevel(GetSpellAbilityUnit(), GetSpellAbilityId())\r\n    endif\r\n    \r\n    set dmg = 40 + ( 40 * lvl )\r\n    set dmge = 10 + ( 20 * lvl )\r\n    call DestroyEffect( AddSpecialEffect( \"war3mapImported\\\\Singularity I Red.mdx\", GetUnitX(caster), GetUnitY(caster) ) )\r\n    call dummyspawn( caster, 1, 0, 0, 0 )\r\n    call GroupEnumUnitsInRange( g, GetUnitX( caster ), GetUnitY( caster ), 300, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        if unitst( u, caster, \"enemy\" ) then\r\n            \tcall UnitDamageTarget( bj_lastCreatedUnit, u, dmg, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )\r\n\t\tif GetUnitState( u, UNIT_STATE_LIFE) <= 0.405 then\r\n    \t\t\tcall DestroyEffect( AddSpecialEffect( \"war3mapImported\\\\Singularity I Red.mdx\", GetUnitX(u), GetUnitY(u) ) )\r\n    \t\t\tcall GroupEnumUnitsInRange( h, GetUnitX( u ), GetUnitY( u ), 300, null )\r\n   \t\t\tloop\r\n        \t\t\tset n = FirstOfGroup(h)\r\n        \t\t\texitwhen n == null\r\n        \t\t\tif unitst( n, caster, \"enemy\" ) then\r\n            \t\t\t\tcall UnitDamageTarget( bj_lastCreatedUnit, n, dmge, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )\r\n       \t\t\t\tendif\r\n        \t\t\tcall GroupRemoveUnit(h,n)\r\n        \t\t\tset n = FirstOfGroup(h)\r\n    \t\t\tendloop\r\n\t\tendif\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n        set u = FirstOfGroup(g)\r\n    endloop\r\n\r\n    if GetUnitAbilityLevel(caster, 'A082') > 0 then\r\n\tif udg_outcast[2] then\r\n\t\tset udg_outcast[2] = false\r\n\t\tif not(udg_fightmod[3]) and combat( caster, false, 0 ) then\r\n            call statst( caster, 0, 2, 0, 236, true )\r\n            call textst( \"|c0020FF20 +2 agility\", caster, 64, 90, 10, 1 )\r\n\t\tendif\r\n\t\tif GetLocalPlayer() == GetOwningPlayer(caster) then\r\n            call BlzFrameSetVisible( outballframe[2], false )\r\n\t\tendif\r\n\tendif\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( caster ), StringHash( \"outew\" ) ), 55 - (5*GetUnitAbilityLevel(caster, 'A082')), true, function OutcastEWEnd )\r\n    endif\r\n    \r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    call GroupClear( h )\r\n    call DestroyGroup( h )\r\n    set h = null\r\n    set n = null\r\n    set u = null\r\n    set g = null\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_OutcastW takes nothing returns nothing\r\n    set gg_trg_OutcastW = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_OutcastW, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_OutcastW, Condition( function Trig_OutcastW_Conditions ) )\r\n    call TriggerAddAction( gg_trg_OutcastW, function Trig_OutcastW_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}