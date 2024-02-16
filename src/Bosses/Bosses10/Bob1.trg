{
  "Id": 50333662,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Bob1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(GetDyingUnit()) == 'n00B'\r\nendfunction\r\n\r\nfunction Trig_Bob1_Actions takes nothing returns nothing\r\n\tlocal unit u = LoadUnitHandle( udg_hash, GetHandleId( GetDyingUnit() ), StringHash( \"bob\" ) )\r\n    local integer v\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call ShowUnit(u, true)\r\n    set Boss_Info[10][3] = 'A19E'\r\n    set v = Boss_Info[10][3]\r\n\r\n\tcall TransmissionFromUnitWithNameBJ( bj_FORCE_ALL_PLAYERS, u, GetUnitName(u), null, \"No! I destroy you all!\", bj_TIMETYPE_SET, 3, false )\r\n\tif bossbar == GetDyingUnit() then\r\n\t\tset bossbar = u\r\n        call IconFrame( \"Last Boss\", BlzGetAbilityIcon(v), BlzGetAbilityTooltip(v, 0), BlzGetAbilityExtendedTooltip(v, 0) )\r\n\tendif\r\n\tif bossbar1 == GetDyingUnit() then\r\n\t\tset bossbar1 = u\r\n        call IconFrame( \"second boss\", BlzGetAbilityIcon(v), BlzGetAbilityTooltip(v, 0), BlzGetAbilityExtendedTooltip(v, 0) )\r\n\tendif\r\n\tcall AUI_TimerGo()\r\n\tcall aggro( u )\r\n\r\n\tcall DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\NightElf\\\\BattleRoar\\\\RoarCaster.mdl\", u, \"origin\" ) )\r\n    \r\n\tset u = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Bob1 takes nothing returns nothing\r\n    set gg_trg_Bob1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Bob1 )\r\n    call TriggerRegisterAnyUnitEventBJ( gg_trg_Bob1, EVENT_PLAYER_UNIT_DEATH )\r\n    call TriggerAddCondition( gg_trg_Bob1, Condition( function Trig_Bob1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Bob1, function Trig_Bob1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}