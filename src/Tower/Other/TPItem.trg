{
  "Id": 50332272,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_TPItem_Conditions takes nothing returns boolean\r\n    return RectContainsUnit(gg_rct_Vision5, GetManipulatingUnit()) and LoadBoolean( udg_hash, GetHandleId(GetManipulatedItem() ), StringHash( \"sreg\" ) )\r\nendfunction\r\n\r\nfunction Trig_TPItem_Actions takes nothing returns nothing\r\n    local item it\r\n    \r\n    call SetUnitPosition(GetManipulatingUnit(), GetRectCenterX(gg_rct_HeroTp), GetRectCenterY(gg_rct_HeroTp))\r\n    call SetUnitFacing(GetManipulatingUnit(), 270)\r\n    call PanCameraToTimedForPlayer( GetOwningPlayer(GetManipulatingUnit()), GetRectCenterX(gg_rct_HeroTp), GetRectCenterY(gg_rct_HeroTp), 0.25 )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Void Teleport Caster.mdx\", GetManipulatingUnit(), \"origin\" ) )\r\n    \r\n    set it = CreateItem( GetItemTypeId(GetManipulatedItem()), GetItemX(GetManipulatedItem()), GetItemY(GetManipulatedItem()))\r\n    call SaveBoolean( udg_hash, GetHandleId( it ), StringHash( \"sreg\" ), true )\r\n    \r\n    set it = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_TPItem takes nothing returns nothing\r\n    set gg_trg_TPItem = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_TPItem, EVENT_PLAYER_UNIT_PICKUP_ITEM )\r\n    call TriggerAddCondition( gg_trg_TPItem, Condition( function Trig_TPItem_Conditions ) )\r\n    call TriggerAddAction( gg_trg_TPItem, function Trig_TPItem_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}