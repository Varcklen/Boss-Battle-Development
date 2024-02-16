{
  "Id": 50332777,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_IkarosSwap_Conditions takes nothing returns boolean\r\n    return inv( udg_FightStart_Unit, 'I099') > 0\r\nendfunction\r\n\r\nfunction Trig_IkarosSwap_Actions takes nothing returns nothing\r\n    local integer i = 1\r\n    call heroswap()\r\n    \r\n    loop\r\n        exitwhen i > 4\r\n        if GetUnitState( udg_hero[i], UNIT_STATE_LIFE ) > 0.405 then\r\n            call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Orc\\\\FeralSpirit\\\\feralspirittarget.mdl\", GetUnitX(udg_hero[i]), GetUnitY(udg_hero[i]) ) )\r\n        endif\r\n        set i = i + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_IkarosSwap takes nothing returns nothing\r\n    set gg_trg_IkarosSwap = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_IkarosSwap, \"udg_FightStart_Real\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_IkarosSwap, Condition( function Trig_IkarosSwap_Conditions ) )\r\n    call TriggerAddAction( gg_trg_IkarosSwap, function Trig_IkarosSwap_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}