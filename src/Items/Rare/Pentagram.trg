{
  "Id": 50332653,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Pentagram_Conditions takes nothing returns boolean\r\n    return IsUnitAlive(AlliedMinionSummoned.TriggerUnit)\r\nendfunction\r\n\r\nfunction Trig_Pentagram_Actions takes nothing returns nothing\r\n\tlocal unit caster = AlliedMinionSummoned.GetDataUnit(\"caster\")\r\n\tlocal unit minion = AlliedMinionSummoned.GetDataUnit(\"minion\")\r\n\tlocal integer hp \r\n    local item itemUsed = Trigger_GetItemUsed()\r\n\tlocal integer id = GetHandleId( itemUsed )\r\n    local integer counter = LoadInteger( udg_hash, id, StringHash( \"pent\" ) ) + 1\r\n    \r\n    if counter >= 4 then\r\n        set counter = 0\r\n        set hp = BlzGetUnitMaxHP(minion)\r\n    \tcall BlzSetUnitMaxHP( minion, BlzGetUnitMaxHP(minion) + hp )\r\n        call SetUnitLifeBJ( minion, GetUnitStateSwap(UNIT_STATE_LIFE, minion) + hp )\r\n    \tcall BlzSetUnitBaseDamage( minion, R2I(GetUnitDamage(minion) * 2) - GetUnitAvgDiceDamage(minion), 0 )\r\n    \tcall DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\NightElf\\\\BattleRoar\\\\RoarCaster.mdl\", minion, \"origin\" ) )\r\n    else\r\n        call textst( \"|c005050FF \" + I2S( counter ) + \"/4\", caster, 64, GetRandomReal( 0, 360 ), 7, 1.5 )\r\n    endif\r\n    call SaveInteger( udg_hash, id, StringHash( \"pent\" ), counter )\r\n    \r\n    set minion = null\r\n    set itemUsed = null\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Pentagram takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I0DL', AlliedMinionSummoned, function Trig_Pentagram_Actions, function Trig_Pentagram_Conditions, \"caster\" )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}