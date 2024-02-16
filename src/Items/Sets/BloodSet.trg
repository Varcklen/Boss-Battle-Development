{
  "Id": 50332857,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope BloodSet initializer init\r\n\r\n    globals\r\n        private constant integer ID_ABILITY = 'A03T'\r\n        private constant real VAMPIRISM_BONUS = 0.4\r\n        \r\n        private constant string ANIMATION = \"Abilities\\\\Spells\\\\Undead\\\\VampiricAura\\\\VampiricAuraTarget.mdl\"\r\n    endglobals\r\n\r\n    private function AfterDamageEvent_Conditions takes nothing returns boolean\r\n        return IsUnitHasAbility( udg_DamageEventSource, ID_ABILITY ) and udg_IsDamageSpell == false\r\n    endfunction\r\n\r\n    private function AfterDamageEvent takes nothing returns nothing\r\n        local real heal = udg_DamageEventAmount * VAMPIRISM_BONUS\r\n        call healst( udg_DamageEventSource, null, heal )\r\n        call PlaySpecialEffect(ANIMATION, udg_DamageEventSource)\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        //По какой-то причине при udg_AfterDamageEvent другие модификаторы переставали работать?udg_DamageEventAfterArmor\r\n        call CreateEventTrigger( \"udg_AfterDamageEvent\", function AfterDamageEvent, function AfterDamageEvent_Conditions )\r\n    endfunction\r\n\r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}