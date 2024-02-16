{
  "Id": 50332775,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MidasHand_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I08S'\r\nendfunction\r\n\r\nfunction Trig_MidasHand_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    \r\n    loop\r\n        exitwhen cyclA > 4\r\n        if udg_hero[cyclA] != null then\r\n        call moneyst( udg_hero[cyclA], 1000 )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MidasHand takes nothing returns nothing\r\n    set gg_trg_MidasHand = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_MidasHand, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_MidasHand, Condition( function Trig_MidasHand_Conditions ) )\r\n    call TriggerAddAction( gg_trg_MidasHand, function Trig_MidasHand_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}