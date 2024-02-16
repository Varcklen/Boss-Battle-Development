{
  "Id": 50332226,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant real EMOTION_SUPPRESSION_DAMAGE_REDUCTION = 0.1\r\nendglobals\r\n\r\nfunction Trig_Emotion_Suppression_Conditions takes nothing returns boolean\r\n    return udg_modgood[37] and IsUnitType( udg_DamageEventTarget, UNIT_TYPE_HERO)\r\nendfunction\r\n\r\nfunction Trig_Emotion_Suppression_Actions takes nothing returns nothing\r\n    set udg_DamageEventAmount = udg_DamageEventAmount - (Event_OnDamageChange_StaticDamage*EMOTION_SUPPRESSION_DAMAGE_REDUCTION)\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Emotion_Suppression takes nothing returns nothing\r\n    call CreateEventTrigger( \"Event_OnDamageChange_Real\", function Trig_Emotion_Suppression_Actions, function Trig_Emotion_Suppression_Conditions )\r\nendfunction\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}