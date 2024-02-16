{
  "Id": 50332609,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Insatiable_flameCast_Conditions takes nothing returns boolean\r\n    return combat(GetSpellAbilityUnit(), false, 0) and not( udg_fightmod[3] ) and inv( GetSpellAbilityUnit(), 'I0DY' ) > 0 and GetSpellAbilityId() != 'A0OK'\r\nendfunction\r\n\r\nfunction Trig_Insatiable_flameCast_Actions takes nothing returns nothing\r\n    local item it = GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I0DY')\r\n    local ability ab\r\n    \r\n    if it != null then\r\n        set ab = BlzGetItemAbility( it, 'A0OK' )\r\n        if ab != null then\r\n            call BlzSetAbilityIntegerLevelFieldBJ( ab, ABILITY_ILF_MANA_COST, 0, IMaxBJ(0,BlzGetAbilityIntegerLevelField(ab, ABILITY_ILF_MANA_COST, 0) - 5) )\r\n        endif\r\n    endif\r\n\r\n    set ab = null\r\n    set it = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Insatiable_flameCast takes nothing returns nothing\r\n    set gg_trg_Insatiable_flameCast = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Insatiable_flameCast, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Insatiable_flameCast, Condition( function Trig_Insatiable_flameCast_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Insatiable_flameCast, function Trig_Insatiable_flameCast_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}