{
  "Id": 50333573,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Wyrm4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId( udg_DamageEventTarget ) == 'o00M' and GetUnitLifePercent(udg_DamageEventTarget) <= 50\r\nendfunction\r\n\r\nfunction Trig_Wyrm4_Actions takes nothing returns nothing\r\n    local integer i = 1\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    loop\r\n        exitwhen i > 4\r\n        if GetUnitState(udg_hero[i], UNIT_STATE_LIFE) > 0.405 then\r\n            call spectimeunit( udg_hero[i], \"Abilities\\\\Spells\\\\Undead\\\\FrostNova\\\\FrostNovaTarget.mdl\", \"origin\", 1 )\r\n            call bufst( udg_DamageEventTarget, udg_hero[i], 'A0ZC', 'B099', \"bswr4\", 15 )\r\n        endif\r\n        set i = i + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Wyrm4 takes nothing returns nothing\r\n    set gg_trg_Wyrm4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Wyrm4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Wyrm4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Wyrm4, Condition( function Trig_Wyrm4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Wyrm4, function Trig_Wyrm4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}