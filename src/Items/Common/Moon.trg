{
  "Id": 50332472,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Moon_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0C1'\r\nendfunction\r\n\r\nfunction Trig_Moon_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local unit u = GetManipulatingUnit()\r\n    \r\n    call stazisst( u, GetItemOfTypeFromUnitBJ( u, 'I0C1') )\r\n    loop\r\n        exitwhen cyclA > 6\r\n        if UnitInventoryCount(u) < 6 then\r\n            call ItemRandomizer( u, \"rare\" )\r\n            call BlzSetItemExtendedTooltip( bj_lastCreatedItem, \"|cffC71585Cursed|r|n\" + BlzGetItemExtendedTooltip(bj_lastCreatedItem) ) // sadwtig\r\n            //call BlzSetItemIconPath( bj_lastCreatedItem, \"|cffC71585Cursed|r|n\" + BlzGetItemExtendedTooltip(bj_lastCreatedItem) )\r\n        else\r\n            set cyclA = 6\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Demon\\\\DarkPortal\\\\DarkPortalTarget.mdl\", GetManipulatingUnit(), \"origin\" ) )\r\n    \r\n    set u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Moon takes nothing returns nothing\r\n    set gg_trg_Moon = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Moon, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Moon, Condition( function Trig_Moon_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Moon, function Trig_Moon_Actions )\r\nendfunction\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}