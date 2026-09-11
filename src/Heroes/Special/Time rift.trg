{
  "Id": 50332921,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope TimeRift initializer init\r\n\r\n\tprivate function condition takes nothing returns boolean\r\n\t    return GetSpellAbilityId() == 'A1BV' \r\n\tendfunction\r\n\t\r\n\tprivate function action takes nothing returns nothing\r\n\t    local unit caster\r\n\t    \r\n\t    if CastLogic() then\r\n\t        set caster = udg_Caster\r\n\t    elseif RandomLogic() then\r\n\t        set caster = udg_Caster\r\n\t        call textst( udg_string[0] + GetObjectName('A1BV'), caster, 64, 90, 10, 1.5 )\r\n\t    else\r\n\t        set caster = GetSpellAbilityUnit()\r\n\t    endif\r\n\t\r\n\t    call UnitResetCooldown( caster )\r\n\t    call DestroyEffect( AddSpecialEffect( \"war3mapImported\\\\Sci Teleport.mdx\", GetUnitX( caster ), GetUnitY( caster ) ) )\r\n\t    \r\n\t    if combat( caster, false, 0 ) then\r\n\t        call NewSpecial( caster, 'A1BW' )\r\n\t    endif\r\n\t    \r\n\t    set caster = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function OnBattleEnd_Condition takes nothing returns boolean\r\n\t\treturn GetUnitAbilityLevel(BattleEnd.TriggerUnit, 'A1BW') > 0\r\n\tendfunction\r\n\r\n\tprivate function OnBattleEnd takes nothing returns nothing\r\n\t\tlocal unit hero = BattleEnd.GetDataUnit(\"caster\")\r\n\t\t\r\n\t\tcall NewSpecial( hero, 'A1BV' ) \r\n\t\t\r\n\t\tset hero = null\r\n\tendfunction\r\n\t\r\n\t//===========================================================================\r\n\tprivate function init takes nothing returns nothing\r\n\t    set gg_trg_Time_rift = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function action, function condition )\r\n\t    call BattleEnd.AddListener(function OnBattleEnd, function OnBattleEnd_Condition)\r\n\tendfunction\r\n\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}