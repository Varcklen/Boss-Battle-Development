{
  "Id": 50332570,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_BannerA_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell ) and combat( AfterAttack.TriggerUnit, false, 0 ) and not( udg_fightmod[3] ) and luckylogic( AfterAttack.TriggerUnit, 2, 1, 100 )\r\nendfunction\r\n\r\nfunction Trig_BannerA_Actions takes nothing returns nothing\r\n\tlocal unit caster = AfterAttack.GetDataUnit(\"caster\")\r\n    local integer rand = GetRandomInt(1, 3)\r\n\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIem\\\\AIemTarget.mdl\", caster, \"origin\") )\r\n    if rand == 1 then\r\n        call statst( caster, 1, 0, 0, 24, true )\r\n        call textst( \"|c00FF2020 +1 strength\", caster, 64, 90, 10, 1 )\r\n    elseif rand == 2 then\r\n        call statst( caster, 0, 1, 0, 28, true )\r\n        call textst( \"|c0020FF20 +1 agility\", caster, 64, 90, 10, 1 )\r\n    elseif rand == 3 then\r\n        call statst( caster, 0, 0, 1, 32, true )\r\n        call textst( \"|c002020FF +1 intelligence\", caster, 64, 90, 10, 1 )\r\n    endif\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_BannerA takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I047', AfterAttack, function Trig_BannerA_Actions, function Trig_BannerA_Conditions, \"caster\" )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}