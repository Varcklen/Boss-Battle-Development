{
  "Id": 50332667,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Runestone_Zirik_Conditions takes nothing returns boolean\r\n    return UnitInventoryCount(BattleEnd.TriggerUnit) < UnitInventorySize(BattleEnd.TriggerUnit) and udg_fightmod[3] == false\r\nendfunction\r\n\r\nfunction Trig_Runestone_Zirik_Actions takes nothing returns nothing\r\n\tlocal unit caster = BattleEnd.GetDataUnit(\"caster\")\r\n    local integer i = GetUnitUserData(caster)\r\n    local item it\r\n    \r\n   set it = ItemRandomizerAll( caster, 0 )\r\n    if GetItemType(it) == ITEM_TYPE_ARTIFACT or GetItemType(it) == ITEM_TYPE_CAMPAIGN then\r\n        call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\ReviveHuman\\\\ReviveHuman.mdl\", caster, \"origin\" ) )\r\n        call statst( caster, 5, 5, 5, 0, true )\r\n        call textst( \"+5 stats!\", caster, 64, GetRandomInt( 45, 135 ), 10, 2.5 )\r\n    elseif not( udg_logic[i + 26] ) then\r\n        call statst( caster, -2, -2, -2, 0, true )\r\n        call textst( \"-2 stats!\", caster, 64, GetRandomInt( 45, 135 ), 10, 2.5 )\r\n    endif\r\n    \r\n    set it = null\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Runestone_Zirik takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I076', BattleEnd, function Trig_Runestone_Zirik_Actions, function Trig_Runestone_Zirik_Conditions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}