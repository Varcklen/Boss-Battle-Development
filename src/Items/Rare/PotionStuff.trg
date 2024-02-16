{
  "Id": 50332651,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PotionStuff_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I05Q'\r\nendfunction\r\n\r\nfunction Trig_PotionStuff_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    loop\r\n        exitwhen cyclA > 6\r\n        if UnitInventoryCount(GetManipulatingUnit()) < 6 then\r\n            set bj_lastCreatedItem = CreateItem( udg_Database_Item_Potion[GetRandomInt(1, udg_Database_NumberItems[9])], GetUnitX( GetManipulatingUnit() ), GetUnitY(GetManipulatingUnit()))\r\n            call UnitAddItem(GetManipulatingUnit(), bj_lastCreatedItem )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphTarget.mdl\", GetManipulatingUnit(), \"origin\" ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PotionStuff takes nothing returns nothing\r\n    set gg_trg_PotionStuff = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PotionStuff, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_PotionStuff, Condition( function Trig_PotionStuff_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PotionStuff, function Trig_PotionStuff_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}