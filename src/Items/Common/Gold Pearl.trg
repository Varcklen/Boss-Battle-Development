{
  "Id": 50332437,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Gold_Pearl_Conditions takes nothing returns boolean\r\n    return GetSpellAbilityId() == 'A0OW' and combat( GetSpellAbilityUnit(), true, GetSpellAbilityId() ) and not( udg_fightmod[3] )\r\nendfunction\r\n\r\nfunction Trig_Gold_Pearl_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclAEnd\r\n    local unit caster\r\n    local integer i \r\n    \r\n    if CastLogic() then\r\n        set caster = udg_Caster\r\n    elseif RandomLogic() then\r\n        set caster = udg_Caster\r\n        call textst( udg_string[0] + GetObjectName('A0OW'), caster, 64, 90, 10, 1.5 )\r\n    else\r\n        set caster = GetSpellAbilityUnit()\r\n    endif\r\n    \r\n    set i = GetPlayerId( GetOwningPlayer( caster ) ) + 1\r\n    set cyclAEnd = eyest( caster )\r\n\r\n    loop\r\n        exitwhen cyclA > cyclAEnd\r\n        if not( udg_fightmod[3] ) then\r\n            call moneyst( caster, 50 )\r\n            set udg_Data[i + 36] = udg_Data[i + 36] + 50\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Gold_Pearl takes nothing returns nothing\r\n    set gg_trg_Gold_Pearl = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Gold_Pearl, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Gold_Pearl, Condition( function Trig_Gold_Pearl_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Gold_Pearl, function Trig_Gold_Pearl_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}