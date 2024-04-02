{
  "Id": 50333119,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope ThrowingKnife initializer init\r\n\t\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return GetSpellAbilityId( ) == 'A0KL'\r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    local unit caster\r\n\t    \r\n\t    if CastLogic() then\r\n\t        set caster = udg_Caster\r\n\t    elseif RandomLogic() then\r\n\t        set caster = udg_Caster\r\n\t        call textst( udg_string[0] + GetObjectName('A0KL'), caster, 64, 90, 10, 1.5 )\r\n\t    else\r\n\t        set caster = GetSpellAbilityUnit()\r\n\t    endif\r\n\t    \r\n\t    call ThrowingKnifeLib_Cast(caster)\r\n\t    \r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t\tcall CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )\r\n\tendfunction\r\n\t\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}