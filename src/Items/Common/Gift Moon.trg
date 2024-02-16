{
  "Id": 50332439,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Gift_Moon_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I03Q'\r\nendfunction\r\n\r\nfunction Trig_Gift_Moon_Actions takes nothing returns nothing\r\n    local integer cyclA = 2\r\n\tlocal integer array it\r\n\r\n\tset it[0] = 0\r\n\tset it[1] = 0\r\n\tloop\r\n\t\texitwhen cyclA > 4\r\n        set it[cyclA] = DB_SetItems[6][GetRandomInt( 1, udg_DB_SetItems_Num[6] )]\r\n\t\tif (it[cyclA] == it[cyclA-1] or it[cyclA] == it[cyclA-2]) then\r\n\t\t\tset cyclA = cyclA - 1\r\n\t\tendif\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\n\tcall forge( GetManipulatingUnit(), GetManipulatedItem(), it[4], it[2], it[3], true )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Gift_Moon takes nothing returns nothing\r\n    set gg_trg_Gift_Moon = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Gift_Moon, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Gift_Moon, Condition( function Trig_Gift_Moon_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Gift_Moon, function Trig_Gift_Moon_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}