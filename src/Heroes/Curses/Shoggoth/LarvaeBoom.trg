{
  "Id": 50333361,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_LarvaeBoom_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetDyingUnit()) == 'n02J'\r\nendfunction\r\n\r\nfunction Trig_LarvaeBoom_Actions takes nothing returns nothing\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    local effect fx\r\n\r\n    call ShowUnit(GetDyingUnit(), false)\r\n    set fx = AddSpecialEffect( \"Units\\\\Undead\\\\Abomination\\\\AbominationExplosion.mdl\", GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ) )\r\n    call BlzSetSpecialEffectOrientation( fx, Deg2Rad(GetUnitFacing(GetDyingUnit())), 0.0, 0.0 )\r\n    call DestroyEffect( fx )\r\n    \r\n    call dummyspawn( GetDyingUnit(), 1, 0, 0, 0 )\r\n    call GroupEnumUnitsInRange( g, GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ), 300, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        if unitst( u, GetDyingUnit(), \"enemy\" )  then\r\n            call UnitDamageTarget( bj_lastCreatedUnit, u, 125, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n    endloop\r\n\r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set g = null\r\n    set u = null\r\n    set fx = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_LarvaeBoom takes nothing returns nothing\r\n    set gg_trg_LarvaeBoom = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_LarvaeBoom, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_LarvaeBoom, Condition( function Trig_LarvaeBoom_Conditions ) )\r\n    call TriggerAddAction( gg_trg_LarvaeBoom, function Trig_LarvaeBoom_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}