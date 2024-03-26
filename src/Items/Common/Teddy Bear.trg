{
  "Id": 50332544,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Teddy_Bear_Conditions takes nothing returns boolean\r\n    return IsUnitAlive( AlliedMinionSummoned.TriggerUnit) \r\nendfunction\r\n\r\nfunction Trig_Teddy_Bear_Actions takes nothing returns nothing\r\n    local unit myUnit = AlliedMinionSummoned.GetDataUnit(\"minion\")\r\n\tlocal real hp = BlzGetUnitMaxHP(myUnit)\r\n    \r\n    call BlzSetUnitBaseDamage( myUnit, BlzGetUnitBaseDamage(myUnit, 0) + 5, 0 )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\Slow\\\\SlowCaster.mdl\", myUnit, \"overhead\" ) )\r\n    if GetUnitTypeId(myUnit) == ID_SHEEP then\r\n    \tcall BlzSetUnitMaxHP( myUnit, R2I(BlzGetUnitMaxHP(myUnit) + hp ) )\r\n        call SetUnitLifeBJ( myUnit, GetUnitState(myUnit, UNIT_STATE_LIFE) + R2I(hp) )\r\n    \tcall BlzSetUnitBaseDamage( myUnit, R2I(GetUnitDamage(myUnit) * 2)-GetUnitAvgDiceDamage(myUnit), 0 )\r\n    endif\r\n    \r\n    set myUnit = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Teddy_Bear takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I08V', AlliedMinionSummoned, function Trig_Teddy_Bear_Actions, function Trig_Teddy_Bear_Conditions, \"caster\" )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}