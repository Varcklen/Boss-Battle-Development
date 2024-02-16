{
  "Id": 50332917,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope BookofSacrifices initializer init\r\n\r\n    globals\r\n        private constant integer ID_ITEM = 'I02V'\r\n        private constant real HEAL_PERCENT = 0.2\r\n        \r\n        private constant string ANIMATION = \"Abilities\\\\Spells\\\\Undead\\\\VampiricAura\\\\VampiricAuraTarget.mdl\"\r\n        \r\n        private boolean Loop = false\r\n    endglobals\r\n    \r\n    private function AfterDamageEvent_Conditions takes nothing returns boolean\r\n        return udg_IsDamageSpell and IsHeroHasItem(ChoosedHero[GetPlayerId( GetOwningPlayer(udg_DamageEventSource) ) + 1], ID_ITEM ) and Loop == false\r\n    endfunction\r\n        \r\n    private function AfterDamageEvent takes nothing returns nothing\r\n        local unit caster = ChoosedHero[GetPlayerId( GetOwningPlayer(udg_DamageEventSource) ) + 1]\r\n        \r\n        set Loop = true\r\n        call healst( caster, null, udg_DamageEventAmount * HEAL_PERCENT )\r\n        call PlaySpecialEffect(ANIMATION, caster )\r\n        set Loop = false\r\n        \r\n        set caster = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call CreateEventTrigger( \"udg_AfterDamageEvent\", function AfterDamageEvent, function AfterDamageEvent_Conditions )\r\n    endfunction\r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}