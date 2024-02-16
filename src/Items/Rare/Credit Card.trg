{
  "Id": 50332579,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Credit_Card_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0CQ'\r\nendfunction\r\n\r\nfunction Trig_Credit_Card_Actions takes nothing returns nothing \r\n\r\n\tcall moneyst( GetManipulatingUnit(), 350 )               \r\n\tcall IconFrame( \"Credit Card\", udg_DB_BonusFrame_Icon[1], udg_DB_BonusFrame_Name[1], udg_DB_BonusFrame_Tooltip[1] )\r\n\tset udg_logic[4] = true\r\n\tset udg_logic[5] = true\r\n\r\n    call StartSound(gg_snd_QuestLog)\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Resurrect\\\\ResurrectTarget.mdl\", GetManipulatingUnit(), \"origin\") )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Credit_Card takes nothing returns nothing\r\n    set gg_trg_Credit_Card = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Credit_Card, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Credit_Card, Condition( function Trig_Credit_Card_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Credit_Card, function Trig_Credit_Card_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}