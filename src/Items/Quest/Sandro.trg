{
  "Id": 50332769,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Sandro initializer init \r\n\r\n\tfunction Trig_Sandro_Conditions takes nothing returns boolean\r\n\t    return GetItemTypeId(GetManipulatedItem()) == 'I03F'\r\n\tendfunction\r\n\t\r\n\tfunction Trig_Sandro_Actions takes nothing returns nothing\r\n\t    call Sandro( GetManipulatingUnit(), GetManipulatedItem() )\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    set gg_trg_Sandro = CreateTrigger(  )\r\n\t    call TriggerRegisterAnyUnitEventBJ( gg_trg_Sandro, EVENT_PLAYER_UNIT_USE_ITEM )\r\n\t    call TriggerAddCondition( gg_trg_Sandro, Condition( function Trig_Sandro_Conditions ) )\r\n\t    call TriggerAddAction( gg_trg_Sandro, function Trig_Sandro_Actions )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}