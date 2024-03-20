{
  "Id": 50333543,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Mehanic5_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetDyingUnit()) == 'n012'\r\nendfunction\r\n\r\nfunction Trig_Mehanic5_Actions takes nothing returns nothing\r\n    local group g = CreateGroup()\r\n    local unit u\r\n\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Other\\\\Incinerate\\\\FireLordDeathExplode.mdl\", GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ) ) )\r\n    call GroupEnumUnitsInRange( g, GetUnitX( GetDyingUnit() ), GetUnitY( GetDyingUnit() ), 300, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        if unitst( u, GetDyingUnit(), \"enemy\" )  then\r\n            call UnitDamageTarget( GetDyingUnit(), u, 300, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n    endloop\r\n    \r\n    call DestroyGroup( g )\r\n    set g = null\r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Mehanic5 takes nothing returns nothing\r\n    set gg_trg_Mehanic5 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Mehanic5 )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Mehanic5, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Mehanic5, Condition( function Trig_Mehanic5_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Mehanic5, function Trig_Mehanic5_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}