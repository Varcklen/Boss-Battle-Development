{
  "Id": 50332725,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_LegBook_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I09S'\r\nendfunction\r\n\r\nfunction Trig_LegBook_Actions takes nothing returns nothing                \r\n\tset udg_logic[76] = true\r\n    call IconFrame( \"LegBook\", udg_DB_BonusFrame_Icon[4], udg_DB_BonusFrame_Name[4], udg_DB_BonusFrame_Tooltip[4] )\r\n    call StartSound(gg_snd_QuestLog)\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Resurrect\\\\ResurrectTarget.mdl\", GetManipulatingUnit(), \"origin\") )\r\n    call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_LegBook takes nothing returns nothing\r\n    set gg_trg_LegBook = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_LegBook, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_LegBook, Condition( function Trig_LegBook_Conditions ) )\r\n    call TriggerAddAction( gg_trg_LegBook, function Trig_LegBook_Actions )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}