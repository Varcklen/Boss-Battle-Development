{
  "Id": 50332540,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Time_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0U1' and not( udg_fightmod[3] ) and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() )\r\nendfunction\r\n\r\nfunction Trig_Time_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local unit u \r\n    \r\n    loop\r\n        exitwhen cyclA > 4\r\n        set u = udg_hero[cyclA]\r\n        if u != null then\r\n            call DestroyEffect( AddSpecialEffect( \"war3mapImported\\\\Sci Teleport.mdx\", GetUnitX( u ), GetUnitY( u ) ) )\r\n            call UnitResetCooldown( u )\r\n            call manast(GetSpellAbilityUnit(), u, GetUnitState(u, UNIT_STATE_MAX_MANA))\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    call stazisst( GetSpellAbilityUnit(), GetItemOfTypeFromUnitBJ( GetSpellAbilityUnit(), 'I0B6') )\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Time takes nothing returns nothing\r\n    set gg_trg_Time = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Time, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Time, Condition( function Trig_Time_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Time, function Trig_Time_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}