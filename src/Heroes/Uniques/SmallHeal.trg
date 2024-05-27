{
  "Id": 50332887,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_SmallHeal_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0AG' or GetSpellAbilityId() == 'A02W'\r\nendfunction\r\n\r\n\r\nfunction Trig_SmallHeal_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local unit target\r\n    local real heal\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n        set target = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        set target = randomtarget( caster, 900, \"ally\", RT_NOT_FULL_HEALTH, 0, 0 )\r\n        call textst( udg_string[0] + GetObjectName('A0AG'), caster, 64, 90, 10, 1.5 )\r\n        if target == null then\r\n            set caster = null\r\n            return\r\n        endif\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n        set target = GetSpellTargetUnit()\r\n    endif\r\n    set heal = 100 * udg_SpellDamageSpec[GetPlayerId(GetOwningPlayer(caster)) + 1]\r\n    if IsUniqueUpgraded(caster) then\r\n        set heal = heal*2\r\n    endif\r\n    call healst( caster, target, heal )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Human\\\\HolyBolt\\\\HolyBoltSpecialArt.mdl\" , target, \"origin\" ) )\r\n    \r\n    set caster = null\r\n    set target = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_SmallHeal takes nothing returns nothing\r\n    set gg_trg_SmallHeal = CreateNativeEvent( EVENT_PLAYER_UNIT_SPELL_EFFECT, function Trig_SmallHeal_Actions, function Trig_SmallHeal_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}