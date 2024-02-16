{
  "Id": 50332665,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Runestone_Brib_Conditions takes nothing returns boolean\r\n    if udg_logic[36] then\r\n        return false\r\n    elseif GetItemTypeId(GetManipulatedItem()) == 'I01C' then\r\n        return false\r\n    elseif inv( GetManipulatingUnit(), 'I01C' ) == 0 then\r\n        return false\r\n    elseif udg_logic[GetPlayerId(GetOwningPlayer(GetManipulatingUnit())) + 1 + 26] then\r\n        return false\r\n    elseif LoadBoolean( udg_hash, GetHandleId( GetManipulatedItem() ), StringHash( \"jule\" ) ) then\r\n        return false\r\n    elseif SubString(BlzGetItemExtendedTooltip(GetManipulatedItem()), 0, 18) == \"|cffC71585Cursed|r\" then\r\n        return false\r\n    endif\r\n    return true\r\nendfunction \r\n\r\nfunction Trig_Runestone_Brib_Actions takes nothing returns nothing \r\n    call BlzSetItemExtendedTooltip( GetManipulatedItem(), \"|cffC71585Cursed|r|n\" + BlzGetItemExtendedTooltip(GetManipulatedItem()) ) // sadtwig\r\n    //call BlzSetItemIconPath( GetManipulatedItem(), \"|cffC71585Cursed|r|n\" + BlzGetItemExtendedTooltip(GetManipulatedItem()) )\r\nendfunction \r\n\r\n//=========================================================================== \r\nfunction InitTrig_Runestone_Brib takes nothing returns nothing \r\n\tset gg_trg_Runestone_Brib = CreateTrigger( ) \r\n\tcall TriggerRegisterAnyUnitEventBJ( gg_trg_Runestone_Brib, EVENT_PLAYER_UNIT_PICKUP_ITEM ) \r\n\tcall TriggerAddCondition( gg_trg_Runestone_Brib, Condition( function Trig_Runestone_Brib_Conditions ) ) \r\n\tcall TriggerAddAction( gg_trg_Runestone_Brib, function Trig_Runestone_Brib_Actions ) \r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}