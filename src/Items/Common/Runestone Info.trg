{
  "Id": 50332512,
  "Comment": "Runestone Info buff add gets applied in OrbsNerzhulAndOthers to fix buffs not applying correctly.",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Runestone_Info_Conditions takes nothing returns boolean\r\n    return IsUnitAlive( AlliedMinionSummoned.TriggerUnit)\r\nendfunction\r\n\r\nfunction Trig_Runestone_Info_Actions takes nothing returns nothing\r\n\tlocal unit minion = AlliedMinionSummoned.GetDataUnit(\"minion\")\r\n    local real hp = BlzGetUnitMaxHP(minion)*0.4\r\n    local real at = GetUnitDamage(minion)*0.4\r\n    \r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\VampiricAura\\\\VampiricAuraTarget.mdl\", minion, \"origin\") )\r\n    call BlzSetUnitMaxHP( minion, R2I(BlzGetUnitMaxHP(minion) + hp) )\r\n    call SetUnitState(minion, UNIT_STATE_LIFE, GetUnitState(minion, UNIT_STATE_LIFE) + hp)\r\n    call BlzSetUnitBaseDamage( minion, R2I(BlzGetUnitBaseDamage(minion, 0) + at), 0 )\r\n    \r\n    set minion = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Runestone_Info takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I0G7', AlliedMinionSummoned, function Trig_Runestone_Info_Actions, function Trig_Runestone_Info_Conditions, \"caster\" )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}