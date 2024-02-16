{
  "Id": 50333594,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "//TESH.scrollpos=0\r\n//TESH.alwaysfold=0\r\nfunction Trig_Ent1_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'e006' and GetUnitLifePercent(udg_DamageEventTarget) <= 75\r\nendfunction\r\n\r\nfunction Trig_Ent1_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    loop\r\n        exitwhen cyclA > 20\r\n        set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'o00O', GetRectCenterX( udg_Boss_Rect ) + GetRandomReal( -1750, 1750 ), GetRectCenterY( udg_Boss_Rect ) + GetRandomReal( -1750, 1750 ), GetRandomReal( 0, 360 ) )\r\n        call DestroyEffect( AddSpecialEffect(\"Objects\\\\Spawnmodels\\\\NightElf\\\\EntBirthTarget\\\\EntBirthTarget.mdl\", GetUnitX( bj_lastCreatedUnit ), GetUnitY( bj_lastCreatedUnit ) ) )\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Ent1 takes nothing returns nothing\r\n    set gg_trg_Ent1 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Ent1 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Ent1, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Ent1, Condition( function Trig_Ent1_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Ent1, function Trig_Ent1_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}