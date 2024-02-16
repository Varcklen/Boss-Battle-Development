{
  "Id": 50332498,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Purple_Liar_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0YF'\r\nendfunction\r\n\r\nfunction Trig_Purple_Liar_Actions takes nothing returns nothing\r\n    local integer x \r\n    local unit caster\r\n    local integer heroId\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0YF'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    set x = eyest( caster )\r\n    set heroId = GetUnitUserData(caster)\r\n    call spectimeunit( caster, \"Abilities\\\\Spells\\\\Human\\\\MarkOfChaos\\\\MarkOfChaosDone.mdl\", \"origin\", 2 )\r\n    call BlzEndUnitAbilityCooldown( caster, udg_Ability_Uniq[heroId] )\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Purple_Liar takes nothing returns nothing\r\n    set gg_trg_Purple_Liar = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Purple_Liar, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Purple_Liar, Condition( function Trig_Purple_Liar_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Purple_Liar, function Trig_Purple_Liar_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}