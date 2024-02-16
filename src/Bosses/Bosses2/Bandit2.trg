{
  "Id": 50333444,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Bandit2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h014' and GetUnitLifePercent(udg_DamageEventTarget) <= 75.\r\nendfunction\r\n\r\nfunction Trig_Bandit2_Actions takes nothing returns nothing\r\n\tlocal integer cyclA = 1\r\n\tlocal real x\r\n\tlocal real y\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call UnitAddAbility( udg_DamageEventTarget, 'A0XR' )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Other\\\\HowlOfTerror\\\\HowlCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\n\r\n\tloop\r\n\t\texitwhen cyclA > 4\r\n    \t\tset x = GetRectCenterX( udg_Boss_Rect ) + 2000 * Cos( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD )\r\n    \t\tset y = GetRectCenterY( udg_Boss_Rect ) + 2000 * Sin( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD )\r\n    \t\tcall CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'n02V', x, y, 270 )\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Bandit2 takes nothing returns nothing\r\n    set gg_trg_Bandit2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Bandit2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Bandit2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Bandit2, Condition( function Trig_Bandit2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Bandit2, function Trig_Bandit2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}