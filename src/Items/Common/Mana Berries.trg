{
  "Id": 50332463,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Mana_Berries_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell ) and inv(udg_DamageEventSource, 'I01W') > 0 and GetUnitTypeId(udg_DamageEventSource) != 'u000'\r\nendfunction\r\n\r\nfunction Trig_Mana_Berries_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( udg_DamageEventSource )\r\n    local integer i\r\n    \r\n    call SaveInteger( udg_hash, id, StringHash( \"mnbb\" ), LoadInteger( udg_hash, id, StringHash( \"mnbb\" ) ) + 1 )\r\n    set i = LoadInteger( udg_hash, id, StringHash( \"mnbb\" ) )\r\n    if i >= 3 then\r\n        call SaveInteger( udg_hash, id, StringHash( \"mnbb\" ), 0 )\r\n        call manast( udg_DamageEventSource, null, 12 )\r\n        call DestroyEffect(AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\ReplenishMana\\\\SpiritTouchTarget.mdl\", udg_DamageEventSource, \"origin\" ))\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Mana_Berries takes nothing returns nothing\r\n    set gg_trg_Mana_Berries = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Mana_Berries, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Mana_Berries, Condition( function Trig_Mana_Berries_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Mana_Berries, function Trig_Mana_Berries_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}