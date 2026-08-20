{
  "Id": 50332614,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Liquid_Sulfur_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0G1' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() ) and not(udg_fightmod[3])\r\nendfunction\r\n\r\nfunction Trig_Liquid_Sulfur_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local integer i\r\n    local integer iEnd\r\n    local integer k\r\n    local integer kMax\r\n    local unit hero\r\n\r\n    if CastLogic() then\r\n        set caster = udg_Target\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0G1'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    set i = 1\r\n    set iEnd = eyest( caster )\r\n    loop\r\n        exitwhen i > iEnd\r\n        set k = 1\r\n        set kMax = 4\r\n\t    loop\r\n\t        exitwhen k > kMax\r\n\t        set hero = udg_hero[k]\r\n\t        if hero != null then\r\n\t        \tcall CastLib_CastRandomAbility( hero, udg_DB_Trigger_Pot[GetRandomInt( 1, udg_Database_NumberItems[9] )], 1 )\r\n        \tendif\r\n\t        set k = k + 1\r\n\t    endloop\r\n        set i = i + 1\r\n    endloop\r\n    \r\n\tset hero = null\r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Liquid_Sulfur takes nothing returns nothing\r\n    set gg_trg_Liquid_Sulfur = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Liquid_Sulfur, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Liquid_Sulfur, Condition( function Trig_Liquid_Sulfur_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Liquid_Sulfur, function Trig_Liquid_Sulfur_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}