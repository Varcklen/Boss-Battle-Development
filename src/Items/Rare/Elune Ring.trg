{
  "Id": 50332605,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Elune_Ring_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell )\r\nendfunction\r\n\r\nfunction Trig_Elune_Ring_Actions takes nothing returns nothing\r\n    local unit u = AfterAttack.GetDataUnit(\"caster\")\r\n    local integer id = GetHandleId( u )\r\n    local integer s = LoadInteger( udg_hash, id, StringHash( \"cgnt\" ) ) + 1\r\n    \r\n    if s >= 7 then\r\n        call MoonTrigger(u)\r\n        call SaveInteger( udg_hash, id, StringHash( \"cgnt\" ), 0 )\r\n    else\r\n        call SaveInteger( udg_hash, id, StringHash( \"cgnt\" ), s )\r\n    endif\r\n    \r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Elune_Ring takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I0FR', AfterAttack, function Trig_Elune_Ring_Actions, function Trig_Elune_Ring_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}