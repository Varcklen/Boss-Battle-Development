{
  "Id": 50333619,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    unit heuz = null\r\nendglobals\r\n\r\nfunction Trig_Heuz1_Conditions takes nothing returns boolean\r\n    return heuz != null and GetUnitState( heuz, UNIT_STATE_LIFE) > 0.405 and GetUnitName(GetDyingUnit()) != \"dummy\"\r\nendfunction\r\n\r\nfunction Trig_Heuz1_Actions takes nothing returns nothing\r\n    local group g = CreateGroup()\r\n    local unit u\r\n    local unit dummy = dummyspawn( heuz, 1, 0, 0, 0 )\r\n    \r\n    call DestroyEffect( AddSpecialEffect( \"Acid Ex.mdx\", GetUnitX(heuz), GetUnitY(heuz) ) )\r\n    call GroupEnumUnitsInRange( g, GetUnitX(heuz), GetUnitY(heuz), 900, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        if unitst( u, heuz, \"enemy\" ) then\r\n            call DestroyEffect( AddSpecialEffect( \"Acid Ex.mdx\", GetUnitX(u), GetUnitY(u) ) )\r\n            call UnitDamageTarget( heuz, u, 50, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS )\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n    endloop\r\n    \r\n    call DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\n    set dummy = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Heuz1 takes nothing returns nothing\r\n    set gg_trg_Heuz1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Heuz1 )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Heuz1, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Heuz1, Condition( function Trig_Heuz1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Heuz1, function Trig_Heuz1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}