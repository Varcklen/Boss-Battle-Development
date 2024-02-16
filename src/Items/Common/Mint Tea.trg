{
  "Id": 50332465,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Mint_Tea_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0YP'\r\nendfunction\r\n\r\nfunction Trig_Mint_Tea_Actions takes nothing returns nothing\r\n    local unit caster\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd \r\n    local real hp\r\n    local real mp\r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0YP'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n\r\n    set hp = GetUnitState( caster, UNIT_STATE_MAX_LIFE) * 0.10\r\n    set mp = GetUnitState( caster, UNIT_STATE_MAX_MANA) * 0.10\r\n    \r\n    call spectimeunit( caster, \"Abilities\\\\Spells\\\\Human\\\\Heal\\\\HealTarget.mdl\", \"origin\", 2 )\r\n    set cyclAEnd = eyest( caster )\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        call healst( caster, null, hp )\r\n        call manast( caster, null, mp )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Mint_Tea takes nothing returns nothing\r\n    set gg_trg_Mint_Tea = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Mint_Tea, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Mint_Tea, Condition( function Trig_Mint_Tea_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Mint_Tea, function Trig_Mint_Tea_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}