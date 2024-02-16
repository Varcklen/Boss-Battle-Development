{
  "Id": 50332627,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Mimic_potion_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0CA'\r\nendfunction\r\n\r\nfunction Trig_Mimic_potion_Actions takes nothing returns nothing\r\n\tlocal integer cyclA = 2\r\n\tlocal integer array it\r\n\r\n\tset it[0] = 0\r\n\tset it[1] = 0\r\n\tloop\r\n\t\texitwhen cyclA > 4\r\n\t\tset it[cyclA] = udg_Database_Item_Potion[GetRandomInt( 1, udg_Database_NumberItems[9] )]\r\n\t\tif (it[cyclA] == it[cyclA-1] or it[cyclA] == it[cyclA-2]) then\r\n\t\t\tset cyclA = cyclA - 1\r\n\t\tendif\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\n\tcall forge( GetManipulatingUnit(), GetManipulatedItem(), it[4], it[2], it[3], true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Mimic_potion takes nothing returns nothing\r\n    set gg_trg_Mimic_potion = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Mimic_potion, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Mimic_potion, Condition( function Trig_Mimic_potion_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Mimic_potion, function Trig_Mimic_potion_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}