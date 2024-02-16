{
  "Id": 50332529,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Sheep_Elixir_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0BO'\r\nendfunction\r\n\r\nfunction Trig_Sheep_Elixir_Actions takes nothing returns nothing\r\n    call NewUniques( GetManipulatingUnit(), 'A0MG' )\r\n    call DestroyEffect( AddSpecialEffect( \"Objects\\\\Spawnmodels\\\\Demon\\\\DemonSmallDeathExplode\\\\DemonSmallDeathExplode.mdl\", GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() ) ) )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Sheep_Elixir takes nothing returns nothing\r\n    set gg_trg_Sheep_Elixir = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Sheep_Elixir, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Sheep_Elixir, Condition( function Trig_Sheep_Elixir_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Sheep_Elixir, function Trig_Sheep_Elixir_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}