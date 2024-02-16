{
  "Id": 50333248,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_OwlWC_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel(GetSpellAbilityUnit(), 'B003') > 0 and GetSpellAbilityId() != 'A0E2'\r\nendfunction\r\n\r\nfunction Trig_OwlWC_Actions takes nothing returns nothing\r\n    local real mana = LoadInteger( udg_hash, GetHandleId( GetSpellAbilityUnit() ), StringHash( \"owlw\" ) )\r\n\r\n    call manast( GetSpellAbilityUnit(), null, mana )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\ReplenishMana\\\\SpiritTouchTarget.mdl\", GetSpellAbilityUnit(), \"origin\" ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_OwlWC takes nothing returns nothing\r\n    set gg_trg_OwlWC = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_OwlWC, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_OwlWC, Condition( function Trig_OwlWC_Conditions ) )\r\n    call TriggerAddAction( gg_trg_OwlWC, function Trig_OwlWC_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}