{
  "Id": 50332548,
  "Comment": "",
  "IsScript": true,
  "RunOnMapInit": false,
  "Script": "globals\r\n    constant integer THIEF_VIST_CHANCE = 10\r\n    constant integer THIEF_VIST_GOLD = 30\r\nendglobals\r\n\r\nfunction Trig_Thiefs_Vest_Conditions takes nothing returns boolean\r\n    if udg_IsDamageSpell then\r\n        return false\r\n    elseif udg_fightmod[3] then\r\n        return false\r\n    elseif combat( AfterAttack.TriggerUnit, false, 0 ) == false then\r\n        return false\r\n    elseif IsUnitEnemy( AfterAttack.TriggerUnit, GetOwningPlayer( AfterAttack.TargetUnit ) ) == false then\r\n        return false\r\n    elseif LuckChance( AfterAttack.TriggerUnit, THIEF_VIST_CHANCE ) == false then\r\n        return false\r\n    endif\r\n    return true\r\nendfunction\r\n\r\nfunction Trig_Thiefs_Vest_Actions takes nothing returns nothing\r\n\tlocal unit caster = AfterAttack.GetDataUnit(\"caster\")\r\n\t\r\n    call moneyst(caster, THIEF_VIST_GOLD)\r\n    \r\n    set caster = null\r\nendfunction\r\n\r\n//===========================================================================\r\nfunction InitTrig_Thiefs_Vest takes nothing returns nothing\r\n    call RegisterDuplicatableItemTypeCustom( 'I0CV', AfterAttack, function Trig_Thiefs_Vest_Actions, function Trig_Thiefs_Vest_Conditions, \"caster\" )\r\nendfunction",
  "Events": [],
  "LocalVariables": [],
  "Conditions": [],
  "Actions": []
}