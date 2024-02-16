{
  "Id": 50333553,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope Paladin03\r\n\r\n    globals\r\n        private constant integer PALADIN_HEALTH_CHECK = 25\r\n        private constant real PALADIN_WAVE_CREATION_COOLDOWN = 0.25\r\n    endglobals\r\n\r\n    function Trig_Paladin3_Conditions takes nothing returns boolean\r\n        return GetUnitTypeId( udg_DamageEventTarget ) == 'h00M' and GetUnitLifePercent(udg_DamageEventTarget) <= PALADIN_HEALTH_CHECK\r\n    endfunction\r\n\r\n    function Trig_Paladin3_Actions takes nothing returns nothing\r\n        call DisableTrigger( GetTriggeringTrigger() )\r\n        call Paladin01_WaveStart(udg_DamageEventTarget, PALADIN_WAVE_CREATION_COOLDOWN)\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    function InitTrig_Paladin3 takes nothing returns nothing\r\n        set gg_trg_Paladin3 = CreateTrigger(  )\r\n        call DisableTrigger( gg_trg_Paladin3 )\r\n        call TriggerRegisterVariableEvent( gg_trg_Paladin3, \"udg_AfterDamageEvent\", EQUAL, 1.00 )\r\n        call TriggerAddCondition( gg_trg_Paladin3, Condition( function Trig_Paladin3_Conditions ) )\r\n        call TriggerAddAction( gg_trg_Paladin3, function Trig_Paladin3_Actions )\r\n    endfunction\r\n\r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}