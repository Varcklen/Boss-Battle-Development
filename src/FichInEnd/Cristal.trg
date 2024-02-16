{
  "Id": 50333711,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Cristal_Conditions takes nothing returns boolean\r\n    return GetUnitAbilityLevel(GetSpellAbilityUnit(), 'B08V') > 0 and udg_combatlogic[GetPlayerId( GetOwningPlayer( GetSpellAbilityUnit() ) ) + 1]\r\nendfunction\r\n\r\nfunction Trig_Cristal_Actions takes nothing returns nothing\r\n\tlocal integer id = GetHandleId( GetSpellAbilityUnit() )\r\n    local integer s = LoadInteger( udg_hash, id, StringHash( \"crst\" ) ) + 1\r\n    \r\n    if s < 5 then\r\n        call textst( \"|c0000ccee \" + I2S(s), GetSpellAbilityUnit(), 64, GetRandomReal( 45, 135 ), 15, 3 )\r\n\t\tcall SaveInteger( udg_hash, id, StringHash( \"crst\" ), s )\r\n    else\r\n\t\tcall SaveInteger( udg_hash, id, StringHash( \"crst\" ), 0 )\r\n\t\tcall textst( \"|c0000ccee Double!\", GetSpellAbilityUnit(), 64, GetRandomReal( 45, 135 ), 15, 3 )\r\n\t\tset udg_CastLogic = true\r\n\t\tset udg_Caster = GetSpellAbilityUnit()\r\n\t\tset udg_Target = GetSpellTargetUnit()\r\n\r\n        set udg_Level = 5\r\n\t\tset udg_Time = 20\r\n        call TriggerExecute( udg_TrigNow )\r\n\tendif\t\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Cristal takes nothing returns nothing\r\n    set gg_trg_Cristal = CreateTrigger(  )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Cristal, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n    call TriggerAddCondition( gg_trg_Cristal, Condition( function Trig_Cristal_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Cristal, function Trig_Cristal_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}