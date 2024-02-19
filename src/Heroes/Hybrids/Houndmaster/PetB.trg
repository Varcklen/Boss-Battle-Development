{
  "Id": 50333191,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_PetB_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0ND'\r\nendfunction\r\n\r\nfunction Trig_PetB_Actions takes nothing returns nothing\r\n\tlocal integer id = GetHandleId( GetSpellAbilityUnit() )\r\n\tlocal unit owner = LoadUnitHandle( udg_hash, id, StringHash( \"bggrac\" ) )\r\n\tlocal integer damageIncrease = LoadInteger(udg_hash, GetHandleId( owner ), StringHash(\"houndmaster_q_damage_increase\") )\r\n    local real damage = 100 + damageIncrease\r\n\r\n    call dummyspawn( GetSpellAbilityUnit(), 1, 0, 0, 0 )\r\n    call UnitDamageTarget( bj_lastCreatedUnit, GetSpellTargetUnit(), damage, true, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Other\\\\Stampede\\\\StampedeMissileDeath.mdl\", GetSpellTargetUnit(), \"origin\" ) )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_PetB takes nothing returns nothing\r\n    set gg_trg_PetB = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_PetB, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_PetB, Condition( function Trig_PetB_Conditions ) )\r\n    call TriggerAddAction( gg_trg_PetB, function Trig_PetB_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}