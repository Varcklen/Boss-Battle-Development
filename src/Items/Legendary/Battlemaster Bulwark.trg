{
  "Id": 50332781,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "scope BattlemasterBulwark initializer init\r\n\r\n    globals\r\n        private constant integer ITEM_ID = 'I0GO'\r\n        private constant real BATTLEMASTER_BULWARK_SHIELD_BONUS = 0.25\r\n    endglobals\r\n\r\n    private function AfterDamageEvent_Conditions takes nothing returns boolean\r\n        return udg_IsDamageSpell == false\r\n    endfunction\r\n\r\n    private function AfterDamageEvent takes nothing returns nothing\r\n        local unit caster = AfterAttack.GetDataUnit(\"caster\")\r\n\t\tlocal real damage = AfterAttack.GetDataReal(\"damage\") * BATTLEMASTER_BULWARK_SHIELD_BONUS\r\n        \r\n        call shield(caster, caster, damage )\r\n        \r\n        set caster = null\r\n    endfunction\r\n\r\n    //===========================================================================\r\n    private function init takes nothing returns nothing\r\n        call RegisterDuplicatableItemTypeCustom( ITEM_ID, AfterAttack, function AfterDamageEvent, function AfterDamageEvent_Conditions )\r\n    endfunction\r\n\r\nendscope\r\n",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}