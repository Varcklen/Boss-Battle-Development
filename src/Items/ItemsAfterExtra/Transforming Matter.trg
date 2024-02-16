{
  "Id": 50332881,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Transforming_Matter_Conditions takes nothing returns boolean\r\n    return inv(GetManipulatingUnit(), 'I0D8') > 0 and GetItemTypeId(GetManipulatedItem()) != null and udg_logic[36] == false\r\nendfunction\r\n\r\nfunction Trig_Transforming_Matter_Actions takes nothing returns nothing\r\n\tlocal unit u = GetManipulatingUnit()\r\n\tlocal item it = GetManipulatedItem()\r\n\r\n\tif not(AlchemyLogic(it)) and GetItemType(it) != ITEM_TYPE_POWERUP and GetItemType(it) != ITEM_TYPE_PURCHASABLE then\r\n\t\tcall DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( u ), GetUnitY( u ) ) )\r\n        call Inventory_ReplaceItemByNew(u, it, DB_SetItems[8][GetRandomInt( 1, udg_DB_SetItems_Num[8] )])\r\n\tendif\r\n\r\n\tset u = null\r\n\tset it = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Transforming_Matter takes nothing returns nothing\r\n    set gg_trg_Transforming_Matter = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Transforming_Matter, EVENT_PLAYER_UNIT_PICKUP_ITEM )\r\n    call TriggerAddCondition( gg_trg_Transforming_Matter, Condition( function Trig_Transforming_Matter_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Transforming_Matter, function Trig_Transforming_Matter_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}