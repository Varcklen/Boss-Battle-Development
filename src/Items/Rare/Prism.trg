{
  "Id": 50332646,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Prism_Conditions takes nothing returns boolean\r\n    local integer cyclA = 0\r\n    local boolean l = false\r\n\r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetItemTypeId(GetManipulatedItem()) == 'I031' + cyclA then\r\n            set l = true\r\n            set cyclA = 4\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    return l\r\nendfunction\r\n\r\nfunction Trig_Prism_Actions takes nothing returns nothing\r\n    local integer cyclA = 0\r\n\r\n    loop\r\n        exitwhen cyclA > 3\r\n        if GetOwningPlayer(GetManipulatingUnit()) == Player(cyclA) and GetItemTypeId(GetManipulatedItem()) != 'I032' + cyclA then\r\n            call RemoveItem( GetManipulatedItem() )\r\n            set bj_lastCreatedItem = CreateItem( 'I032' + cyclA, GetUnitX(GetManipulatingUnit()), GetUnitY(GetManipulatingUnit()))\r\n            call UnitAddItem( GetManipulatingUnit(), bj_lastCreatedItem)\r\n            set cyclA = 3\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Prism takes nothing returns nothing\r\n    set gg_trg_Prism = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Prism, EVENT_PLAYER_UNIT_PICKUP_ITEM )\r\n    call TriggerAddCondition( gg_trg_Prism, Condition( function Trig_Prism_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Prism, function Trig_Prism_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}