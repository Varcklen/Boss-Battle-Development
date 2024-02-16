{
  "Id": 50332604,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Elixir_of_Acumen_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0BA'\r\nendfunction\r\n\r\nfunction Trig_Elixir_of_Acumen_Actions takes nothing returns nothing\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetManipulatingUnit(), \"origin\" ) )\r\n    if udg_PotionsUsed[GetPlayerId( GetOwningPlayer( GetManipulatingUnit() ) ) + 1] >= 5 then\r\n        call NewUniques( GetManipulatingUnit(), 'A13I' )\r\n    endif\r\n    call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )\r\n    \r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Elixir_of_Acumen takes nothing returns nothing\r\n    set gg_trg_Elixir_of_Acumen = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Elixir_of_Acumen, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Elixir_of_Acumen, Condition( function Trig_Elixir_of_Acumen_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Elixir_of_Acumen, function Trig_Elixir_of_Acumen_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}