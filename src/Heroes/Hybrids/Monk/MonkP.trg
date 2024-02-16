{
  "Id": 50333198,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "function Trig_MonkP_Conditions takes nothing returns boolean\r\n    return IsUnitHasAbility( udg_DamageEventSource, 'A08W') and udg_IsDamageSpell == false\r\nendfunction\r\n\r\nfunction Trig_MonkP_Actions takes nothing returns nothing\r\n    local unit target = null\r\n    local integer lvl = GetUnitAbilityLevel(udg_DamageEventSource, 'A08W')\r\n    local real heal = 5. + I2R( ( lvl + 6 ) * lvl )\r\n\r\n    set target = HeroLessHP(udg_DamageEventSource)\r\n    if target != null then\r\n        call healst( udg_DamageEventSource, target, heal )\r\n        set target = null\r\n    endif\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_MonkP takes nothing returns nothing\r\n    //По какой-то причине при udg_AfterDamageEvent другие модификаторы переставали работать?udg_DamageEventAfterArmor\r\n    call CreateEventTrigger( \"udg_AfterDamageEvent\", function Trig_MonkP_Actions, function Trig_MonkP_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}