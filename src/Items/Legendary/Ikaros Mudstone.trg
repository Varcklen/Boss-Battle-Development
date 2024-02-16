{
  "Id": 50332779,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Ikaros_Mudstone_Conditions takes nothing returns boolean\r\n    return inv( udg_FightStart_Unit, 'I03H') > 0 and not(udg_fightmod[3])\r\nendfunction\r\n\r\nfunction Trig_Ikaros_Mudstone_Actions takes nothing returns nothing\r\n    local integer i = 1\r\n    loop\r\n        exitwhen i > 4\r\n        if udg_hero[i] != null then\r\n            call DestroyEffect( AddSpecialEffectTarget( \"war3mapImported\\\\Rock Slam.mdx\", udg_hero[i], \"origin\") )\r\n            if BlzGetUnitIntegerField(udg_hero[i],UNIT_IF_PRIMARY_ATTRIBUTE) == 1 then\r\n                call statst( udg_hero[i], 3, 0, 0, 0, true )\r\n            elseif BlzGetUnitIntegerField(udg_hero[i],UNIT_IF_PRIMARY_ATTRIBUTE) == 2  then\r\n                call statst( udg_hero[i], 0, 0, 3, 0, true )\r\n            elseif BlzGetUnitIntegerField(udg_hero[i],UNIT_IF_PRIMARY_ATTRIBUTE) == 3  then\r\n                call statst( udg_hero[i], 0, 3, 0, 0, true )\r\n            endif\r\n        endif\r\n        set i = i + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Ikaros_Mudstone takes nothing returns nothing\r\n    set gg_trg_Ikaros_Mudstone = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Ikaros_Mudstone, \"udg_FightStart_Real\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Ikaros_Mudstone, Condition( function Trig_Ikaros_Mudstone_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Ikaros_Mudstone, function Trig_Ikaros_Mudstone_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}