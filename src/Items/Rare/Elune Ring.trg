{
  "Id": 50332605,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Elune_Ring_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell ) and inv( udg_DamageEventSource, 'I0FR') > 0\r\nendfunction\r\n\r\nfunction Trig_Elune_Ring_Actions takes nothing returns nothing\r\n    local unit u = udg_DamageEventSource\r\n    local integer id = GetHandleId( u )\r\n    local integer s = LoadInteger( udg_hash, id, StringHash( \"cgnt\" ) ) + 1\r\n    \r\n    if s >= 7 then\r\n        call MoonTrigger(u)\r\n        call SaveInteger( udg_hash, id, StringHash( \"cgnt\" ), 0 )\r\n    else\r\n        call SaveInteger( udg_hash, id, StringHash( \"cgnt\" ), s )\r\n    endif\r\n    \r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Elune_Ring takes nothing returns nothing\r\n    set gg_trg_Elune_Ring = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_Elune_Ring, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Elune_Ring, Condition( function Trig_Elune_Ring_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Elune_Ring, function Trig_Elune_Ring_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}