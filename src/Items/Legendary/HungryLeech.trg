{
  "Id": 50332919,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope HungryLeech initializer init\r\n\r\n    globals\r\n        private constant integer ID_ITEM = 'I0DG'\r\n        private boolean isLoop = false\r\n    endglobals\r\n\r\n    private function AfterHeal_Conditions takes nothing returns boolean\r\n        return IsHeroHasItem( Event_AfterHeal_Target, ID_ITEM ) and Event_AfterHeal_Target != Event_AfterHeal_Caster and isLoop == false\r\n    endfunction\r\n    \r\n    private function AfterHeal takes nothing returns nothing\r\n        set isLoop = true\r\n        call healst( Event_AfterHeal_Target, Event_AfterHeal_Caster, Event_AfterHeal_Heal )\r\n        set isLoop = false\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger(\"Event_AfterHeal_Real\", function AfterHeal, function AfterHeal_Conditions )\r\n    endfunction\r\nendscope",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}