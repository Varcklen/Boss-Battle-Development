{
  "Id": 50332461,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope SacrificialBlade initializer init\r\n\r\n\tglobals\r\n\t\tprivate constant integer ABILITY_ID = 'A020'\r\n\t\t\r\n\t\tprivate constant integer MANA_RESTORE = 115\r\n\t\tprivate constant integer HEALTH_COST = 150\r\n\tendglobals\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return GetSpellAbilityId() == ABILITY_ID\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    local unit caster\r\n\t    local integer cyclA = 1\r\n\t    local integer cyclAEnd\r\n\t    \r\n\t    if CastLogic() then\r\n\t        set caster = udg_Caster\r\n\t    elseif RandomLogic() then\r\n\t        set caster = udg_Caster\r\n\t        call textst( udg_string[0] + GetObjectName(ABILITY_ID), caster, 64, 90, 10, 1.5 )\r\n\t    else\r\n\t        set caster = GetSpellAbilityUnit()\r\n\t    endif\r\n\t    set cyclAEnd = eyest( caster )\r\n\t    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Undead\\\\RaiseSkeletonWarrior\\\\RaiseSkeleton.mdl\", caster, \"origin\" ) )\r\n\t    loop\r\n\t        exitwhen cyclA > cyclAEnd\r\n\t        call manast( caster, null, MANA_RESTORE )\r\n\t        set cyclA = cyclA + 1\r\n\t    endloop\r\n\t    \r\n\t    call SetUnitState( caster, UNIT_STATE_LIFE, RMaxBJ(0, GetUnitState( caster, UNIT_STATE_LIFE) - HEALTH_COST ) )\r\n\t    \r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}