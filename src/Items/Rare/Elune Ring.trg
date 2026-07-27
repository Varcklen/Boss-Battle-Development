{
  "Id": 50332605,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Elune_Ring_Conditions takes nothing returns boolean\r\n    return Uniques_Logic(GetSpellAbilityId())\r\nendfunction\r\n\r\nfunction Trig_Elune_Ring_Actions takes nothing returns nothing\r\n    call MoonTrigger(GetSpellAbilityUnit())\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Elune_Ring takes nothing returns nothing\r\n    call RegisterDuplicatableItemType('I0FR', EVENT_PLAYER_UNIT_SPELL_EFFECT, function Trig_Elune_Ring_Actions, function Trig_Elune_Ring_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}