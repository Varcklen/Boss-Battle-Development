{
  "Id": 50332412,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Chameleon_Tarot_Conditions takes nothing returns boolean\r\n    return GetItemTypeId(GetManipulatedItem()) == 'I0EL'\r\nendfunction\r\n\r\nfunction Trig_Chameleon_Tarot_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetOwningPlayer(GetManipulatingUnit())) + 1\r\n    local integer cyclA\r\n    local item it\r\n    \r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Human\\\\Resurrect\\\\ResurrectTarget.mdl\", GetManipulatingUnit(), \"origin\") )\r\n    call statst( GetManipulatingUnit(), 1, 1, 1, 0, true )\r\n    call stazisst( GetManipulatingUnit(), GetItemOfTypeFromUnitBJ( GetManipulatingUnit(), 'I0EL') )\r\n    \r\n    set cyclA = 0\r\n    loop\r\n        exitwhen cyclA > 5\r\n        set it = UnitItemInSlot(GetManipulatingUnit(), cyclA)\r\n        if it != null then\r\n            call BlzSetItemExtendedTooltip( it, \"|cff00cceeChameleon|r|n\" + BlzGetItemDescription(it) ) // sadtwig\r\n            //call BlzSetItemIconPath( it, \"|cff00cceeChameleon|r|n\" + BlzGetItemDescription(it) )\r\n            //call BlzSetItemDescription( it, \"|cff00cceeChameleon|r|n\" + BlzGetItemDescription(it) )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set it = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Chameleon_Tarot takes nothing returns nothing\r\n    set gg_trg_Chameleon_Tarot = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Chameleon_Tarot, EVENT_PLAYER_UNIT_USE_ITEM )\r\n    call TriggerAddCondition( gg_trg_Chameleon_Tarot, Condition( function Trig_Chameleon_Tarot_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Chameleon_Tarot, function Trig_Chameleon_Tarot_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}