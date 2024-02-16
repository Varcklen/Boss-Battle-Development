{
  "Id": 50332429,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Explosive_Moss_Conditions takes nothing returns boolean\r\n    return inv( GetDyingUnit(), 'I073') > 0\r\nendfunction\r\n\r\nfunction Trig_Explosive_Moss_Actions takes nothing returns nothing\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    \r\n    call dummyspawn( GetDyingUnit(), 1, 0, 0, 0 )\r\n    call DestroyEffect( AddSpecialEffect( \"Units\\\\Undead\\\\Abomination\\\\AbominationExplosion.mdl\", GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ) ) )\r\n    call GroupEnumUnitsInRange( g, GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ), 600, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        if unitst( u, GetDyingUnit(), \"enemy\" )  then\r\n            call UnitDamageTarget( bj_lastCreatedUnit, u, 750, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n        set u = FirstOfGroup(g)\r\n    endloop\r\n    call GroupClear( g )\r\n    call DestroyGroup( g )\r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Explosive_Moss takes nothing returns nothing\r\n    set gg_trg_Explosive_Moss = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Explosive_Moss, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Explosive_Moss, Condition( function Trig_Explosive_Moss_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Explosive_Moss, function Trig_Explosive_Moss_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}