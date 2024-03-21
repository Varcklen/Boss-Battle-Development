{
  "Id": 50332429,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Explosive_Moss_Actions takes nothing returns nothing\r\n\tlocal unit caster = UnitDied.GetDataUnit(\"unit_died\")\r\n\r\n    call GroupAoE( caster, 0, 0, 750, 600, \"enemy\", \"Units\\\\Undead\\\\Abomination\\\\AbominationExplosion.mdl\", null )\r\n\r\n\tset caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Explosive_Moss takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I073', UnitDied, function Trig_Explosive_Moss_Actions, null, \"unit_died\" )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}