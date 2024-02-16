{
  "Id": 50332494,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Parcel_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I063'\r\nendfunction\r\n\r\nfunction Trig_Parcel_Actions takes nothing returns nothing\r\n    local integer i = 0\r\n    local integer cyclA = 1\r\n\r\n    call stazisst( GetManipulatingUnit(), GetManipulatedItem() )\r\n    call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX( GetManipulatingUnit() ), GetUnitY( GetManipulatingUnit() ) ) )\r\n    loop\r\n        exitwhen cyclA > 6\r\n        if GetItemType(UnitItemInSlot(GetManipulatingUnit(), cyclA-1)) == ITEM_TYPE_ARTIFACT then\r\n            set i = i + 1\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    if i == 0 then\r\n        call ItemRandomizer( GetManipulatingUnit(), \"legendary\" )\r\n    else\r\n        call ItemRandomizer( GetManipulatingUnit(), \"common\" )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Parcel takes nothing returns nothing\r\n    set gg_trg_Parcel = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Parcel, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Parcel, Condition( function Trig_Parcel_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Parcel, function Trig_Parcel_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}