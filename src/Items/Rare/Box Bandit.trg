{
  "Id": 50332567,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Box_Bandit_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I06Z'\r\nendfunction\r\n\r\nfunction Trig_Box_Bandit_Actions takes nothing returns nothing\r\n\tcall forge( GetManipulatingUnit(), GetManipulatedItem(), 'I05V', 'I06A', 'I06B', true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Box_Bandit takes nothing returns nothing\r\n    set gg_trg_Box_Bandit = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Box_Bandit, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Box_Bandit, Condition( function Trig_Box_Bandit_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Box_Bandit, function Trig_Box_Bandit_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}