{
  "Id": 50332585,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Coal_Gift_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I00E'\r\nendfunction\r\n\r\nfunction Trig_Coal_Gift_Actions takes nothing returns nothing\r\n    local integer cyclA = 2\r\n\tlocal integer array it\r\n\r\n\tset it[0] = 0\r\n\tset it[1] = 0\r\n\tloop\r\n\t\texitwhen cyclA > 4\r\n        set it[cyclA] = udg_DB_Item_Destroyed[GetRandomInt( 1, udg_Database_NumberItems[29] )]\r\n\t\tif (it[cyclA] == it[cyclA-1] or it[cyclA] == it[cyclA-2]) then\r\n\t\t\tset cyclA = cyclA - 1\r\n\t\tendif\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\n\tcall forge( GetManipulatingUnit(), GetManipulatedItem(), it[4], it[2], it[3], true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Coal_Gift takes nothing returns nothing\r\n    set gg_trg_Coal_Gift = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Coal_Gift, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Coal_Gift, Condition( function Trig_Coal_Gift_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Coal_Gift, function Trig_Coal_Gift_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}