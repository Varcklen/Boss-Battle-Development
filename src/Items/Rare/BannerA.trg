{
  "Id": 50332570,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_BannerA_Conditions takes nothing returns boolean\r\n    return not( udg_IsDamageSpell )  and inv(udg_DamageEventSource, 'I047') > 0 and combat( udg_DamageEventSource, false, 0 ) and not( udg_fightmod[3] ) and luckylogic( udg_DamageEventSource, 2, 1, 100 )\r\nendfunction\r\n\r\nfunction Trig_BannerA_Actions takes nothing returns nothing\r\n    local integer rand = GetRandomInt(1, 3)\r\n\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\Items\\\\AIem\\\\AIemTarget.mdl\", udg_DamageEventSource, \"origin\") )\r\n    if rand == 1 then\r\n        call statst( udg_DamageEventSource, 1, 0, 0, 24, true )\r\n        call textst( \"|c00FF2020 +1 strength\", udg_DamageEventSource, 64, 90, 10, 1 )\r\n    elseif rand == 2 then\r\n        call statst( udg_DamageEventSource, 0, 1, 0, 28, true )\r\n        call textst( \"|c0020FF20 +1 agility\", udg_DamageEventSource, 64, 90, 10, 1 )\r\n    elseif rand == 3 then\r\n        call statst( udg_DamageEventSource, 0, 0, 1, 32, true )\r\n        call textst( \"|c002020FF +1 intelligence\", udg_DamageEventSource, 64, 90, 10, 1 )\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_BannerA takes nothing returns nothing\r\n    set gg_trg_BannerA = CreateTrigger(  )\r\n    call TriggerRegisterVariableEvent( gg_trg_BannerA, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_BannerA, Condition( function Trig_BannerA_Conditions ) )\r\n    call TriggerAddAction( gg_trg_BannerA, function Trig_BannerA_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}