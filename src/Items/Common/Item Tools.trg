{
  "Id": 50332474,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope ItemTools initializer init\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return GetSpellAbilityId() == 'A00G' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() ) and udg_fightmod[3] == null\r\n\tendfunction\r\n\t  \r\n\tprivate function action takes nothing returns nothing\r\n\t    local unit caster\r\n\t    local integer cyclA = 1\r\n\t    local integer cyclAEnd\r\n\t    \r\n\t    if CastLogic() then\r\n\t        set caster = udg_Caster\r\n\t    elseif RandomLogic() then\r\n\t        set caster = udg_Caster\r\n\t        call textst( udg_string[0] + GetObjectName('A00G'), caster, 64, 90, 10, 1.5 )\r\n\t    else\r\n\t        set caster = GetSpellAbilityUnit()\r\n\t    endif\r\n\t\r\n\t\tcall DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Human\\\\Polymorph\\\\PolyMorphDoneGround.mdl\", GetUnitX(caster), GetUnitY(caster) ) )\r\n\t    set cyclAEnd = eyest(caster)\r\n\t    loop\r\n\t        exitwhen cyclA > cyclAEnd\r\n\t        if ItemManipulation_IsInventoryFull(caster) == false then\r\n\t        \tcall ItemRandomizerAll( caster, 0 )\r\n\t        endif\r\n\t        set cyclA = cyclA + 1\r\n\t    endloop\r\n\t\r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    call CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}