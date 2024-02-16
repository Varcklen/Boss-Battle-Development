{
  "Id": 50332508,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Rarity_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0EK'\r\nendfunction\r\n\r\nfunction Trig_Rarity_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetOwningPlayer(GetManipulatingUnit())) + 1\r\n    \r\n    call IconFrame( \"Rarity\", udg_DB_BonusFrame_Icon[5], udg_DB_BonusFrame_Name[5], udg_DB_BonusFrame_Tooltip[5] )\r\n    set udg_logic[98] = true\r\n    call StartSound(gg_snd_QuestLog)\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Resurrect\\\\ResurrectTarget.mdl\", GetManipulatingUnit(), \"origin\") )\r\n    call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )\r\n\r\n    call stazisst( GetManipulatingUnit(), GetItemOfTypeFromUnitBJ( GetManipulatingUnit(), 'I0EK') )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Rarity takes nothing returns nothing\r\n    set gg_trg_Rarity = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Rarity, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Rarity, Condition( function Trig_Rarity_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Rarity, function Trig_Rarity_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}