{
  "Id": 50332404,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Battle_halberd_Conditions takes nothing returns boolean\r\n    return ( ( inv( udg_DamageEventSource, 'I025') > 0 ) or ( ( inv( udg_DamageEventSource, 'I030') > 0 ) and udg_Set_Weapon_Logic[GetPlayerId(GetOwningPlayer(udg_DamageEventSource)) + 1 + 16] ) ) and not( udg_IsDamageSpell ) and GetUnitTypeId(udg_DamageEventSource) != 'u000'\r\nendfunction\r\n\r\nfunction Trig_Battle_halberd_Actions takes nothing returns nothing\r\n    local integer id \r\n    local unit target = udg_DamageEventTarget\r\n    local unit caster = udg_DamageEventSource\r\n    local real t = 7\r\n    \r\n    set t = timebonus( caster, t )\r\n    set id = GetHandleId( target )\r\n\r\n    call bufst( caster, target, 'A0ZR', 'B089', \"btlh\", t )\r\n\r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Battle_halberd takes nothing returns nothing\r\n    set gg_trg_Battle_halberd = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Battle_halberd, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Battle_halberd, Condition( function Trig_Battle_halberd_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Battle_halberd, function Trig_Battle_halberd_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}