{
  "Id": 50332749,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Corrupted_Wish_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I00N'\r\nendfunction\r\n\r\nfunction Trig_Corrupted_Wish_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() ) ) )\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    loop\r\n        exitwhen cyclA > 3\r\n        if UnitInventoryCount(GetManipulatingUnit()) < 6 then\r\n            call UnitAddItem( GetManipulatingUnit(), CreateItem(udg_DB_Item_Destroyed[GetRandomInt( 1, udg_Database_NumberItems[29] )], GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() )))\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Corrupted_Wish takes nothing returns nothing\r\n    set gg_trg_Corrupted_Wish = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Corrupted_Wish, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Corrupted_Wish, Condition( function Trig_Corrupted_Wish_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Corrupted_Wish, function Trig_Corrupted_Wish_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}