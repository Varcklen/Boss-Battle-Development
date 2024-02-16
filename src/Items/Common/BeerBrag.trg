{
  "Id": 50332402,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_BeerBrag_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0CS'\r\nendfunction\r\n\r\nfunction Trig_BeerBrag_Actions takes nothing returns nothing\r\n    call NewUniques( GetManipulatingUnit(), 'A15W' )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Other\\\\StrongDrink\\\\BrewmasterMissile.mdl\", GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() ) ) )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_BeerBrag takes nothing returns nothing\r\n    set gg_trg_BeerBrag = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_BeerBrag, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_BeerBrag, Condition( function Trig_BeerBrag_Conditions ) )\r\n    call TriggerAddAction( gg_trg_BeerBrag, function Trig_BeerBrag_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}