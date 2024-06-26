{
  "Id": 50332515,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope ShadowGenerator initializer init\r\n\r\n    globals\r\n        private constant integer ID_ITEM = 'I06H'\r\n        \r\n        private constant integer DAMAGE = 10\r\n        private constant string ANIMATION = \"Abilities\\\\Spells\\\\Undead\\\\DeathandDecay\\\\DeathandDecayDamage.mdl\"\r\n    endglobals\r\n\r\n    /*function Trig_Shadow_Generator_Conditions takes nothing returns boolean\r\n        return IsHeroHasItem(GetSpellAbilityUnit(), ID_ITEM)\r\n    endfunction*/\r\n\r\n    function Trig_Shadow_Generator_Actions takes nothing returns nothing\r\n        call DestroyEffect( AddSpecialEffectTarget( ANIMATION, GetSpellAbilityUnit(), \"origin\") )\r\n        call UnitTakeDamage(GetSpellAbilityUnit(), GetSpellAbilityUnit(), DAMAGE, DAMAGE_TYPE_MAGIC)\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        /*set gg_trg_Shadow_Generator = CreateTrigger(  )\r\n        call TriggerRegisterAnyUnitEventBJ( gg_trg_Shadow_Generator, EVENT_PLAYER_UNIT_SPELL_EFFECT )\r\n        call TriggerAddCondition( gg_trg_Shadow_Generator, Condition( function Trig_Shadow_Generator_Conditions ) )\r\n        call TriggerAddAction( gg_trg_Shadow_Generator, function Trig_Shadow_Generator_Actions )*/\r\n        \r\n        call RegisterDuplicatableItemType(ID_ITEM, EVENT_PLAYER_UNIT_SPELL_EFFECT, function Trig_Shadow_Generator_Actions, null )\r\n    endfunction\r\n\r\nendscope\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}