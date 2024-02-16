{
  "Id": 50332815,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Papirus_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0C0'\r\nendfunction\r\n\r\nfunction Trig_Papirus_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    \r\n    loop\r\n        exitwhen cyclA > 4\r\n        if udg_hero[cyclA] != null then\r\n            call SetHeroLevel( udg_hero[cyclA], GetHeroLevel(udg_hero[cyclA]) + 3, true )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Papirus takes nothing returns nothing\r\n    set gg_trg_Papirus = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Papirus, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Papirus, Condition( function Trig_Papirus_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Papirus, function Trig_Papirus_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}