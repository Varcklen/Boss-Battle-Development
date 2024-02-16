{
  "Id": 50332391,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Alphabet_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0CE'\r\nendfunction\r\n\r\nfunction Trig_Alphabet_Actions takes nothing returns nothing\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    call SetHeroLevel( GetManipulatingUnit(), GetHeroLevel(GetManipulatingUnit()) + 3, true)\r\n    call ModifyHeroSkillPoints( GetManipulatingUnit(), bj_MODIFYMETHOD_SUB, 3 )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Alphabet takes nothing returns nothing\r\n    set gg_trg_Alphabet = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Alphabet, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Alphabet, Condition( function Trig_Alphabet_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Alphabet, function Trig_Alphabet_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}