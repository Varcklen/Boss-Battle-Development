{
  "Id": 50333503,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Chief2 initializer init\r\n\r\n\tglobals\r\n\t\tprivate constant real HEAL_PERCENT = 0.07\r\n\t\tprivate constant string ANIMATION = \"Abilities\\\\Spells\\\\Undead\\\\AnimateDead\\\\AnimateDeadTarget.mdl\"\r\n\tendglobals\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) and udg_fightmod[0] and combat(GetDyingUnit(), false, 0)\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t\tlocal unit boss = GroupPickRandomUnit( GetUnitsOfPlayerAndTypeId( Player(10), 'h01X' ) )\r\n\t\tlocal real healing\r\n\t\t\r\n\t\tif boss == null then\r\n\t\t\treturn\r\n\t\tendif\r\n\t\t\r\n\t\tset healing = GetUnitState( boss, UNIT_STATE_MAX_LIFE) * HEAL_PERCENT * SpellPower_GetBossSpellPower()\r\n\r\n        call SetUnitState( boss, UNIT_STATE_LIFE, GetUnitState( boss, UNIT_STATE_LIFE) + healing )\r\n        call DestroyEffect( AddSpecialEffect( ANIMATION, GetUnitX( boss ), GetUnitY( boss ) ) )\r\n        \r\n\t    set boss = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    set gg_trg_Chief2 = CreateTrigger(  )\r\n\t    call DisableTrigger( gg_trg_Chief2 )\r\n\t    call TriggerRegisterAnyUnitEventBJ( gg_trg_Chief2, EVENT_PLAYER_UNIT_DEATH )\r\n\t    call TriggerAddCondition( gg_trg_Chief2, Condition( function condition ) )\r\n\t    call TriggerAddAction( gg_trg_Chief2, function action )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}