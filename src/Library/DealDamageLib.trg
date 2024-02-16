{
  "Id": 50332068,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "library DealDamageLib\r\n\r\n    function UnitTakeDamage takes unit dealer, unit target, real damage, damagetype damageType returns nothing\r\n        local attacktype attackType = ATTACK_TYPE_HERO\r\n        \r\n        if dealer == null or target == null then\r\n            set attackType = null\r\n            set dealer = null\r\n            set target = null\r\n            return\r\n        endif\r\n        \r\n        if damageType == DAMAGE_TYPE_MAGIC then\r\n            set attackType = ATTACK_TYPE_NORMAL\r\n        endif\r\n\r\n        call UnitDamageTarget( dealer, target, damage, true, false, attackType, damageType, WEAPON_TYPE_WHOKNOWS)\r\n            \r\n        set attackType = null\r\n        set dealer = null\r\n        set target = null\r\n    endfunction\r\n\r\nendlibrary",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}