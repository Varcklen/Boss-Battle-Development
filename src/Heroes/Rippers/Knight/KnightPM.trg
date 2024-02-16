{
  "Id": 50333048,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_KnightPM_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel( GetKillingUnit(), 'A133' ) > 0 and IsUnitEnemy(GetDyingUnit(), GetOwningPlayer(GetKillingUnit()))\r\nendfunction\r\n\r\nfunction Trig_KnightPM_Actions takes nothing returns nothing\r\n    local real heal = GetUnitState(GetKillingUnit(), UNIT_STATE_MAX_LIFE) * 0.02 * LoadInteger( udg_hash, GetHandleId( GetKillingUnit() ), StringHash( \"kngee\" ) )\r\n    local real mana = GetUnitState(GetKillingUnit(), UNIT_STATE_MAX_MANA) * 0.02 * LoadInteger( udg_hash, GetHandleId( GetKillingUnit() ), StringHash( \"kngee\" ) )\r\n\r\n    call healst( GetKillingUnit(), null, heal )\r\n    call manast( GetKillingUnit(), null, mana )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\VampiricAura\\\\VampiricAuraTarget.mdl\", GetKillingUnit(), \"origin\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_KnightPM takes nothing returns nothing\r\n    set gg_trg_KnightPM = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_KnightPM, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_KnightPM, Condition( function Trig_KnightPM_Conditions ) )\r\n    call TriggerAddAction( gg_trg_KnightPM, function Trig_KnightPM_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}