{
  "Id": 50332422,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_FutureBall_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0FH'\r\nendfunction\r\n\r\nfunction Trig_FutureBall_Actions takes nothing returns nothing\r\n\tlocal integer cyclA = 2\r\n\tlocal integer array it\r\n    local integer randl\r\n\r\n\tset it[0] = 0\r\n\tset it[1] = 0\r\n\tloop\r\n\t\texitwhen cyclA > 4\r\n\t\tset randl = GetRandomInt(1, 100)\r\n        if randl <= udg_RarityChance[3] then\r\n            set it[cyclA] = DB_Items[3][GetRandomInt( 1, udg_Database_NumberItems[3] )]\r\n            if (it[cyclA] == it[cyclA-1] or it[cyclA] == it[cyclA-2]) and udg_Database_NumberItems[3] > 2 then\r\n                set cyclA = cyclA - 1\r\n            endif\r\n        elseif randl >= udg_RarityChance[3]+1 and randl <= udg_RarityChance[2] then\r\n            set it[cyclA] = DB_Items[2][GetRandomInt( 1, udg_Database_NumberItems[2] )]\r\n            if (it[cyclA] == it[cyclA-1] or it[cyclA] == it[cyclA-2]) and udg_Database_NumberItems[2] > 2 then\r\n                set cyclA = cyclA - 1\r\n            endif\r\n        elseif randl >= udg_RarityChance[2]+1 then\r\n            set it[cyclA] = DB_Items[1][GetRandomInt( 1, udg_Database_NumberItems[1] )]\r\n            if (it[cyclA] == it[cyclA-1] or it[cyclA] == it[cyclA-2]) and udg_Database_NumberItems[1] > 2 then\r\n                set cyclA = cyclA - 1\r\n            endif\r\n        endif\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\n\tcall forge( GetManipulatingUnit(), GetManipulatedItem(), it[4], it[2], it[3], true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_FutureBall takes nothing returns nothing\r\n    set gg_trg_FutureBall = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_FutureBall, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_FutureBall, Condition( function Trig_FutureBall_Conditions ) )\r\n    call TriggerAddAction( gg_trg_FutureBall, function Trig_FutureBall_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}