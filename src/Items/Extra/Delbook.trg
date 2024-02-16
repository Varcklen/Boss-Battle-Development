{
  "Id": 50332847,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Delbook_Conditions takes nothing returns boolean\r\n    return IsItemIdPowerup(GetItemTypeId(GetManipulatedItem()))\r\nendfunction\r\n\r\nfunction DelbookCast takes nothing returns nothing\r\n    local integer id = GetHandleId( GetExpiredTimer() )\r\n    call RemoveItem( LoadItemHandle( udg_hash, id, StringHash( \"delb\" ) ) )\r\n    call FlushChildHashtable( udg_hash, id )\r\nendfunction\r\n\r\nfunction Trig_Delbook_Actions takes nothing returns nothing\r\n    local integer id = GetHandleId( GetManipulatedItem() )\r\n    \r\n    call SaveTimerHandle( udg_hash, GetHandleId( GetManipulatedItem() ), StringHash( \"delb\" ), CreateTimer() )\r\n\tset id = GetHandleId( LoadTimerHandle( udg_hash, GetHandleId( GetManipulatedItem() ), StringHash( \"delb\" ) ) ) \r\n\tcall SaveItemHandle( udg_hash, id, StringHash( \"delb\" ), GetManipulatedItem() )\r\n\tcall TimerStart( LoadTimerHandle( udg_hash, GetHandleId( GetManipulatedItem() ), StringHash( \"delb\" ) ), 0.1, false, function DelbookCast )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Delbook takes nothing returns nothing\r\n    set gg_trg_Delbook = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Delbook, EVENT_PLAYER_UNIT_PICKUP_ITEM )\r\n    call TriggerAddCondition( gg_trg_Delbook, Condition( function Trig_Delbook_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Delbook, function Trig_Delbook_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}