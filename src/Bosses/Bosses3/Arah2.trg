{
  "Id": 50333464,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_Arah2_Conditions takes nothing returns boolean\r\n    return GetUnitTypeId(udg_DamageEventTarget) == 'h00K' and GetUnitLifePercent(udg_DamageEventTarget) <= 35\r\nendfunction\r\n\r\nfunction Trig_Arah2_Actions takes nothing returns nothing\r\n    local integer cyclA = 1\r\n    local integer cyclB\r\n    local real x\r\n    local real y\r\n    \r\n    call DisableTrigger( GetTriggeringTrigger() )\r\n    call DestroyEffect( AddSpecialEffectTarget( \"Abilities\\\\Spells\\\\NightElf\\\\BattleRoar\\\\RoarCaster.mdl\", udg_DamageEventTarget, \"origin\") )\r\n    loop\r\n        exitwhen cyclA > 4\r\n        set x = GetRectCenterX( udg_Boss_Rect ) + 2000 * Cos( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD )\r\n        set y = GetRectCenterY( udg_Boss_Rect ) + 2000 * Sin( ( 45 + ( 90 * cyclA ) ) * bj_DEGTORAD )\r\n        set cyclB = 1\r\n        loop\r\n            exitwhen cyclB > 8\r\n            set bj_lastCreatedUnit = CreateUnit( GetOwningPlayer( udg_DamageEventTarget ), 'h00L', x, y, GetRandomReal( 0, 360 ) )\r\n            if udg_fightmod[4] then\r\n                call UnitApplyTimedLife( bj_lastCreatedUnit, 'BTLF', 60)\r\n            endif\r\n            set cyclB = cyclB + 1\r\n        endloop\r\n        set cyclA = cyclA + 1\r\n    endloop\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Arah2 takes nothing returns nothing\r\n    set gg_trg_Arah2 = CreateTrigger(  )\r\n    call DisableTrigger( gg_trg_Arah2 )\r\n    call TriggerRegisterVariableEvent( gg_trg_Arah2, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n    call TriggerAddCondition( gg_trg_Arah2, Condition( function Trig_Arah2_Conditions ) )\r\n    call TriggerAddAction( gg_trg_Arah2, function Trig_Arah2_Actions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}