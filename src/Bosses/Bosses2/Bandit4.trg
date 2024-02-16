{
  "Id": 50333446,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Bandit4_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h014' and GetUnitLifePercent(udg_DamageEventTarget) <= 25\r\nendfunction\r\n\r\nfunction Trig_Bandit4_Actions takes nothing returns nothing\r\n\tlocal integer cyclA = 1\r\n\tlocal real x\r\n\tlocal real y\r\n\r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call SaveInteger( udg_hash, GetHandleId( udg_DamageEventTarget ), StringHash( \"bsrg\" ), 2 )\r\n    call DestroyEffect( AddSpecialEffectTarget(\"Abilities\\\\Spells\\\\Other\\\\Transmute\\\\PileofGold.mdl\", udg_DamageEventTarget, \"origin\") )\r\n\r\n\tloop\r\n\t\texitwhen cyclA > 4\r\n    \t\tset x = GetRectCenterX( udg_Boss_Rect ) + 2000 * Cos( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD )\r\n    \t\tset y = GetRectCenterY( udg_Boss_Rect ) + 2000 * Sin( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD )\r\n    \t\tcall CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'n02V', x, y, 270 )\r\n\t\tset cyclA = cyclA + 1\r\n\tendloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Bandit4 takes nothing returns nothing\r\n    set gg_trg_Bandit4 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Bandit4 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Bandit4, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Bandit4, Condition( function Trig_Bandit4_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Bandit4, function Trig_Bandit4_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}