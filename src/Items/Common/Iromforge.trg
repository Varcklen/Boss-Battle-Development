{
  "Id": 50332458,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Iromforge_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0CC'\r\nendfunction\r\n\r\nfunction Trig_Iromforge_Actions takes nothing returns nothing\r\n\tlocal integer cyclA = 2\r\n\tlocal integer array it\r\n\r\n\tset it[0] = 0\r\n\tset it[1] = 0\r\n\tloop\r\n\t\texitwhen cyclA > 4\r\n\t\tif cyclA == 4 then\r\n\t\t\tset it[cyclA] = DB_SetItems[2][GetRandomInt( 1, udg_DB_SetItems_Num[2] )]\r\n\t\telseif cyclA == 2 then\r\n\t\t\tset it[cyclA] = DB_SetItems[1][GetRandomInt( 1, udg_DB_SetItems_Num[1] )]\r\n\t\telseif cyclA == 3 then\r\n\t\t\tset it[cyclA] = DB_SetItems[5][GetRandomInt( 1, udg_DB_SetItems_Num[5] )]\r\n\t\tendif\r\n\t\tif (it[cyclA] == it[cyclA-1] or it[cyclA] == it[cyclA-2]) then\r\n\t\t\tset cyclA = cyclA - 1\r\n\t\tendif\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\n\tcall forge( GetManipulatingUnit(), GetManipulatedItem(), it[4], it[2], it[3], true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Iromforge takes nothing returns nothing\r\n    set gg_trg_Iromforge = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Iromforge, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Iromforge, Condition( function Trig_Iromforge_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Iromforge, function Trig_Iromforge_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}