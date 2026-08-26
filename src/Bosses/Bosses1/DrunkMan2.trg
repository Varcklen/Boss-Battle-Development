{
  "Id": 50333423,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "//TESH.scrollpos=0\r\n//TESH.alwaysfold=0\r\nfunction Trig_DrunkMan2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'n02U' and GetUnitLifePercent(udg_DamageEventTarget) <= 50\r\nendfunction\r\n\r\nfunction Trig_DrunkMan2_Actions takes nothing returns nothing\r\n\tlocal unit boss = udg_DamageEventTarget\r\n\tlocal group g = CreateGroup()\r\n    local unit u\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Thunderclap\\\\ThunderClapCaster.mdl\", boss, \"origin\") )\r\n    \r\n    call GroupEnumUnitsInRange( g, GetUnitX( boss ), GetUnitY( boss ), 800, null )\r\n    loop\r\n        set u = FirstOfGroup(g)\r\n        exitwhen u == null\r\n        if unitst( u, udg_DamageEventTarget, \"enemy\" ) then\r\n            call SetUnitAnimation( boss, \"attack\" )    \r\n            call dummyspawn( boss, 1, 'A0XQ', 0, 0 )\r\n            call IssueTargetOrder( bj_lastCreatedUnit, \"drunkenhaze\", u )\r\n        endif\r\n        call GroupRemoveUnit(g,u)\r\n    endloop\r\n\t\t\r\n\tcall DestroyGroup( g )\r\n    set u = null\r\n    set g = null\r\n    set boss = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_DrunkMan2 takes nothing returns nothing\r\n    set gg_trg_DrunkMan2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_DrunkMan2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_DrunkMan2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_DrunkMan2, Condition( function Trig_DrunkMan2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_DrunkMan2, function Trig_DrunkMan2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}