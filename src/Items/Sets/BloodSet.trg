{
  "Id": 50332857,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope BloodSet initializer init\r\n\r\n    globals\r\n        private constant integer ID_ABILITY = 'A03T'\r\n        private constant real LIFESTEAL_BONUS = 0.4\r\n        \r\n        private constant string ANIMATION = \"Abilities\\\\Spells\\\\Undead\\\\VampiricAura\\\\VampiricAuraTarget.mdl\"\r\n    endglobals\r\n\r\n    private function condition takes nothing returns boolean\r\n        return udg_IsDamageSpell == false and IsUnitHasAbility( AfterAttack.TriggerUnit, ID_ABILITY ) \r\n    endfunction\r\n\r\n    private function action takes nothing returns nothing\r\n    \tlocal unit caster = AfterAttack.GetDataUnit(\"caster\")\r\n        local real heal = udg_DamageEventAmount * LIFESTEAL_BONUS\r\n        \r\n        call healst( caster, null, heal )\r\n        call spectimeunit( caster, ANIMATION, \"origin\", 2 )\r\n        \r\n        set caster = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call AfterAttack.AddListener(function action, function condition)\r\n    endfunction\r\n    \r\nendscope\r\n\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}