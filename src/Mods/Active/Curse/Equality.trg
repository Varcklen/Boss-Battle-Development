{
  "Id": 50332232,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Equality_Conditions takes nothing returns boolean\r\n    return GetUnitLifePercent(udg_DamageEventTarget) <= 50 and IsUnitInGroup( udg_DamageEventTarget, udg_Bosses )\r\nendfunction\r\n\r\nfunction Trig_Equality_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        if GetPlayerSlotState( Player( cyclA - 1 ) ) == PLAYER_SLOT_STATE_PLAYING and GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) > 0.405 then\r\n            call DestroyEffect( AddSpecialEffect( \"Abilities\\\\Spells\\\\Undead\\\\DeathCoil\\\\DeathCoilSpecialArt.mdl\", GetUnitX(udg_hero[cyclA]), GetUnitY(udg_hero[cyclA])) )\r\n            call SetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE, GetUnitState( udg_hero[cyclA], UNIT_STATE_LIFE) - (GetUnitState( udg_hero[cyclA], UNIT_STATE_MAX_LIFE) * 0.2) )\r\n        endif\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Equality takes nothing returns nothing\r\n    set gg_trg_Equality = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Equality )\r\n    call TriggerRegisterVariableEvent( gg_trg_Equality, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Equality, Condition( function Trig_Equality_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Equality, function Trig_Equality_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}