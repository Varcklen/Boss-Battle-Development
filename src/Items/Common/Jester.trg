{
  "Id": 50332455,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Jester_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0DB'\r\nendfunction\r\n\r\nfunction Trig_Jester_Actions takes nothing returns nothing\r\n    local integer cyclA = 0\r\n\r\n    loop\r\n        exitwhen cyclA > 5\r\n        if ( GetSpellTargetItem() == UnitItemInSlot( GetSpellAbilityUnit(), cyclA ) ) and ( GetItemTypeId(GetSpellTargetItem()) != 'I02C' ) and ( GetItemType(GetSpellTargetItem()) != ITEM_TYPE_POWERUP ) then\r\n            call RemoveItem( GetSpellTargetItem() )\r\n            call AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Other\\\\Doom\\\\DoomDeath.mdl\", GetSpellAbilityUnit(), \"origin\")\r\n            call stazisst( GetSpellAbilityUnit(), GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I02C') )\r\n            set cyclA = 5\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Jester takes nothing returns nothing\r\n    set gg_trg_Jester = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Jester, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Jester, Condition( function Trig_Jester_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Jester, function Trig_Jester_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}