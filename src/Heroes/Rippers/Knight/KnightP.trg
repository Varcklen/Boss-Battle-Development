{
  "Id": 50333046,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_KnightP_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel( udg_hero[GetPlayerId(GetOwningPlayer(GetKillingUnit())) + 1], 'A05M') > 0 and IsUnitEnemy(GetDyingUnit(), GetOwningPlayer(udg_hero[GetPlayerId(GetOwningPlayer(GetKillingUnit())) + 1])) and ( ( GetUnitTypeId(GetKillingUnit()) == 'u000' ) or ( GetKillingUnit() == udg_hero[GetPlayerId(GetOwningPlayer(GetKillingUnit())) + 1] ) )\r\nendfunction\r\n\r\nfunction Trig_KnightP_Actions takes nothing returns nothing\r\n    local integer i = GetPlayerId(GetOwningPlayer(GetKillingUnit())) + 1\r\n    local real heal = GetUnitState(GetKillingUnit(), UNIT_STATE_MAX_LIFE) * 0.02 * GetUnitAbilityLevel(udg_hero[i], 'A05M')\r\n    local real mana = GetUnitState(GetKillingUnit(), UNIT_STATE_MAX_MANA) * 0.02 * GetUnitAbilityLevel(udg_hero[i], 'A05M')\r\n      \r\n    call healst( udg_hero[i], null, heal )\r\n    call manast( udg_hero[i], null, mana )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\VampiricAura\\\\VampiricAuraTarget.mdl\", udg_hero[i], \"origin\") )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_KnightP takes nothing returns nothing\r\n    set gg_trg_KnightP = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_KnightP, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_KnightP, Condition( function Trig_KnightP_Conditions ) )\r\n    call TriggerAddAction( gg_trg_KnightP, function Trig_KnightP_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}